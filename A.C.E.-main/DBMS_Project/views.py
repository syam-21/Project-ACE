from django.contrib.auth.models import User

def homepage(request):
    return render(request, 'Homepage.html')


def about(request):
    return render(request, 'about.html')


def Signup(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        role = request.POST['role']
        password = request.POST['password']  # Do not hash the password
        passkey = request.POST.get('passkey', '')

        # Validate passkey for admin and teacher roles
        if (role == 'admin' and passkey != 'adminpasskey') or (role == 'teacher' and passkey != 'teacherpasskey'):
            return render(request, 'Signup.html', {'error': 'Invalid passkey'})

        # Use raw SQL to insert the user
        sql = """
            INSERT INTO store_user (UserName, UserEmail, UserRole, password, is_active)
            VALUES (%s, %s, %s, %s, %s)
        """
        params = [username, email, role, password, True]

        with connection.cursor() as cursor:
            cursor.execute(sql, params)

        return redirect('/Login/')
    else:
        return render(request, 'Signup.html')





def Login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        # Retrieve user record using raw SQL (including UserID now)
        sql = """
            SELECT UserID, UserName, UserEmail, UserRole, password, is_active 
            FROM store_user 
            WHERE UserName = %s
        """
        params = [username]
        with connection.cursor() as cursor:
            cursor.execute(sql, params)
            user = cursor.fetchone()

        # Verify user exists, password matches, and account is active
        if user and password == user[4] and user[5]:
            # Store user details in session
            request.session['user_id'] = user[0]       # Store UserID in session
            request.session['username'] = user[1]      # Store UserName in session (if needed for display)
            request.session['is_authenticated'] = True # Mark the session as logged in
            # Debugging output to confirm the session data
            print(f"User ID stored in session: {request.session.get('user_id')}")
            # Update last_login timestamp to now
            with connection.cursor() as cursor:
                cursor.execute(
                    "UPDATE store_user SET last_login = NOW() WHERE UserName = %s",
                    [username]
                )
            # Redirect based on role
            user_role = user[3]
            if user_role == 'admin':
                return redirect('/admin/')
            elif user_role == 'teacher':
                return redirect('/teacher/')
            else:  # student or any other role
                return redirect('/student/')
        else:
            # Authentication failed: invalid credentials or inactive account
            return render(request, 'Login.html', {'error': 'Invalid username or password'})
    # GET request or just show login form
    return render(request, 'Login.html')


def teacher(request):
    username = request.session.get('username')
    return render(request, 'teacher.html', {'username': username})


def create_quiz(request):
    if request.method == 'POST':
        # Handle form submission to create quiz (e.g., saving quiz in the database)
        quiz_title = request.POST['quiz_title']
        course = request.POST['course']
        time_limit = request.POST['time_limit']
        num_of_questions = request.POST['num_of_questions']

        # Example insert for creating a quiz, replace this with your logic
        sql = """
            INSERT INTO store_quiz (QuizTitle, Course, Faculty, TimeLimit, NumOfQues)
            VALUES (%s, %s, %s, %s, %s)
        """
        params = [quiz_title, course, request.session.get('username'), time_limit, num_of_questions]

        with connection.cursor() as cursor:
            cursor.execute(sql, params)

        return redirect('/teacher/see_quiz/')  # Redirect after quiz creation

    return render(request, 'create_quiz.html')


def see_quiz(request):
    # Fetch teacher's ID from session
    teacher_id = request.session.get('user_id')

    if request.method == 'POST':
        teacher_name = request.POST.get('teacher_name', '')
        teacher_id_input = request.POST.get('teacher_id', '')
        course_code = request.POST.get('course_code', '')
        difficulty = request.POST.get('difficulty', '')

        # Base query for fetching quizzes
        sql_quizzes = """
            SELECT q.QuizID, q.QuizTitle, 
                   CASE 
                       WHEN COUNT(CASE WHEN s.DifficultyLevel = 'hard' THEN 1 END) > COUNT(CASE WHEN s.DifficultyLevel = 'easy' THEN 1 END) THEN 'hard'
                       WHEN COUNT(CASE WHEN s.DifficultyLevel = 'medium' THEN 1 END) > COUNT(CASE WHEN s.DifficultyLevel = 'easy' THEN 1 END) THEN 'medium'
                       ELSE 'easy'
                   END AS avg_difficulty,
                   q.TimeLimit, q.NumOfQues, u.UserName
            FROM store_quiz q
            JOIN store_user u ON q.Faculty_id = u.UserID
            LEFT JOIN store_question s ON q.QuizID = s.Quiz_id
            WHERE 1
        """

        # Conditions based on input fields
        conditions = []
        params = []

        if teacher_id_input:
            conditions.append("u.UserID = %s")
            params.append(teacher_id_input)
        if teacher_name:
            conditions.append("u.UserName LIKE %s")
            params.append(f"%{teacher_name}%")
        if course_code:
            conditions.append("q.Course_id IN (SELECT CourseID FROM store_course WHERE CourseCode = %s)")
            params.append(course_code)
        if difficulty:
            conditions.append("s.DifficultyLevel = %s")
            params.append(difficulty)

        # Combine base query with conditions
        if conditions:
            sql_quizzes += " AND " + " AND ".join(conditions)

        # Add GROUP BY clause
        sql_quizzes += " GROUP BY q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName"

        # Execute query
        with connection.cursor() as cursor:
            cursor.execute(sql_quizzes, params)
            quizzes = cursor.fetchall()

        return render(request, 'teacher/view_quizzes.html', {'quizzes': quizzes})

    return render(request, 'teacher/see_quiz.html')

def student_number(request, quiz_id):
    # Fetch the number of students who took this quiz
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(DISTINCT Student_id) 
            FROM store_score 
            WHERE Quiz_id = %s
        """, [quiz_id])
        student_count = cursor.fetchone()[0]

    # Fetch the students who took the quiz, their names, and scores
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT s.Student_id, u.UserName, s.Score
            FROM store_score s
            JOIN store_user u ON s.Student_id = u.UserID
            WHERE s.Quiz_id = %s
        """, [quiz_id])
        student_results = cursor.fetchall()

    return render(request, 'teacher/student_number.html', {
        'quiz_id': quiz_id,
        'student_count': student_count,
        'student_results': student_results
    })


def admin(request):
    username = request.session.get('username')
    with connection.cursor() as cursor:
        cursor.execute("SELECT UserRole FROM store_user WHERE UserName = %s", [username])
        user_role = cursor.fetchone()

    if not user_role or user_role[0] != 'admin':
        return redirect('/')

    # Fetch all users
    with connection.cursor() as cursor:
        cursor.execute("SELECT UserID, UserName, UserEmail, UserRole, is_active FROM store_user")
        users = cursor.fetchall()

    # Fetch all courses
    with connection.cursor() as cursor:
        cursor.execute("SELECT CourseID, CourseCode, CourseName, Description, Faculty_id FROM store_course")
        courses = cursor.fetchall()

    # Fetch all quizzes
    with connection.cursor() as cursor:
        cursor.execute("SELECT QuizID, QuizTitle, Course_id, Faculty_id, TimeLimit, NumOfQues, CreatedAt FROM store_quiz")
        quizzes = cursor.fetchall()

    message = request.session.pop('message', None)  # Get and remove message from session

    return render(request, 'admin.html', {
        'users': users,
        'courses': courses,
        'quizzes': quizzes,
        'message': message
    })


def delete_course(request):
    if request.method == 'POST':
        course_id = request.POST.get('course_id')
        try:
            with connection.cursor() as cursor:
                cursor.execute("DELETE FROM store_course WHERE CourseID = %s", [course_id])
            request.session['message'] = "Course deleted successfully."
        except Exception as e:
            request.session['message'] = f"Error deleting course: {e}"
    return redirect('/admin/')

def delete_quiz(request):
    if request.method == 'POST':
        quiz_id = request.POST.get('quiz_id')
        try:
            with connection.cursor() as cursor:
                cursor.execute("DELETE FROM store_quiz WHERE QuizID = %s", [quiz_id])
            request.session['message'] = "Quiz deleted successfully."
        except Exception as e:
            request.session['message'] = f"Error deleting quiz: {e}"
    return redirect('/admin/')


def student(request):
    # Retrieve the current student's info from session
    username = request.session.get('username')
    user_id = request.session.get('user_id')

    teacher_quizzes = []       # Quizzes found by teacher search
    filtered_quizzes = []      # Quizzes found by course/difficulty filter (or all quizzes by default)
    taken_quizzes = []         # Quizzes that the student has already taken (with scores)

    teacher_search_performed = False
    filter_performed = False

    # Preserve search/filter inputs for form repopulation
    teacher_query = ''
    course_code = ''
    difficulty = ''

    if request.method == 'POST':
        # **Teacher Search Form Submitted**
        if 'teacher_submit' in request.POST:
            teacher_query = request.POST.get('teacher_query', '').strip()
            teacher_search_performed = True
            if teacher_query:
                with connection.cursor() as cursor:
                    if teacher_query.isdigit():
                        # Search by teacher ID
                        cursor.execute("""
                            SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                            FROM store_quiz q
                            JOIN store_user u ON q.Faculty_id = u.UserID
                            JOIN store_course c ON q.Course_id = c.CourseID
                            WHERE u.UserID = %s
                        """, [teacher_query])
                    else:
                        # Search by teacher name (partial match)
                        cursor.execute("""
                            SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                            FROM store_quiz q
                            JOIN store_user u ON q.Faculty_id = u.UserID
                            JOIN store_course c ON q.Course_id = c.CourseID
                            WHERE u.UserName LIKE %s
                        """, [f"%{teacher_query}%"])
                    teacher_quizzes = cursor.fetchall()

        # **Course/Difficulty Filter Form Submitted**
        if 'filter_submit' in request.POST:
            course_code = request.POST.get('course_code', '').strip()
            difficulty = request.POST.get('difficulty', '').strip()
            filter_performed = True
            # Build base SQL query for quizzes with necessary joins
            sql_query = """
                SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                FROM store_quiz q
                JOIN store_course c ON q.Course_id = c.CourseID
                JOIN store_user u ON q.Faculty_id = u.UserID
            """
            conditions = []
            params = []
            if course_code:
                conditions.append("c.CourseCode = %s")
                params.append(course_code)
            if difficulty:
                # Include quizzes that have at least one question of the given difficulty
                conditions.append("q.QuizID IN (SELECT Quiz_id FROM store_question WHERE DifficultyLevel = %s)")
                params.append(difficulty)
            if conditions:
                sql_query += " WHERE " + " AND ".join(conditions)
            with connection.cursor() as cursor:
                cursor.execute(sql_query, params)
                filtered_quizzes = cursor.fetchall()

    # If no filter was applied, fetch all quizzes by default for the dashboard
    if not filter_performed:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                FROM store_quiz q
                JOIN store_course c ON q.Course_id = c.CourseID
                JOIN store_user u ON q.Faculty_id = u.UserID
            """)
            filtered_quizzes = cursor.fetchall()

    # Fetch quizzes already taken by this student (with scores)
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT q.QuizID, q.QuizTitle, q.NumOfQues, s.Score
            FROM store_score s
            JOIN store_quiz q ON s.Quiz_id = q.QuizID
            WHERE s.Student_id = %s
        """, [user_id])
        taken_quizzes = cursor.fetchall()

    # List of taken quiz IDs to identify which quizzes the student has completed
    taken_ids = [row[0] for row in taken_quizzes]

    # Prepare context for template rendering
    context = {
        'username': username,
        'teacher_quizzes': teacher_quizzes,
        'filtered_quizzes': filtered_quizzes,
        'taken_quizzes': taken_quizzes,
        'taken_ids': taken_ids,
        'teacher_search_performed': teacher_search_performed,
        'filter_performed': filter_performed,
        'teacher_query': teacher_query,
        'course_code': course_code,
        'selected_difficulty': difficulty,
    }
    return render(request, 'student.html', context)


def Info(request):
    username = request.session.get('username')

    # Use raw SQL to retrieve the user information
    sql = "SELECT UserName, UserEmail, UserRole, UserInstitute, last_login FROM store_user WHERE UserName = %s"
    params = [username]

    with connection.cursor() as cursor:
        cursor.execute(sql, params)
        user = cursor.fetchone()

    if user:
        return render(request, 'Info.html', {
            'username': user[0],
            'email': user[1],
            'role': user[2],
            'institute': user[3] if user[3] else None,
            'last_login': user[4],  # Added last_login to the context
            'user_role': user[2]  # Passed to template for conditional navigation
        })
    else:
        return redirect('/Login/')


def Logout(request):
    # Clear all session data
    request.session.flush()
    # Redirect to homepage
    return redirect('/')


def Studentquiz(request):
    username = request.session.get('username')
    return render(request, 'Studentquiz.html', {'username': username})


def delete_user(request):
    # Check if user is admin
    username = request.session.get('username')
    with connection.cursor() as cursor:
        cursor.execute("SELECT UserRole FROM store_user WHERE UserName = %s", [username])
        user_role = cursor.fetchone()

    if not user_role or user_role[0] != 'admin':
        return redirect('/')

    if request.method == 'POST':
        user_id = request.POST.get('user_id')

        # Don't allow admin to delete themselves
        with connection.cursor() as cursor:
            cursor.execute("SELECT UserID FROM store_user WHERE UserName = %s", [username])
            admin_id = cursor.fetchone()[0]

        if str(admin_id) == user_id:
            request.session['message'] = "You cannot delete your own account."
            return redirect('/admin/')

        # Delete the user
        with connection.cursor() as cursor:
            cursor.execute("DELETE FROM store_user WHERE UserID = %s", [user_id])

        request.session['message'] = "User deleted successfully."

    return redirect('/admin/')




def create_quiz(request):
    # Get the current authenticated teacher based on session username
    username = request.session.get('username')
    userid = request.session.get('user_id')

    # Debugging output to confirm the session data
    print(f"User ID from session: {userid}, User Name: {username}")

    # Check if the user is authenticated
    if not userid:
        return redirect('/login/')  # Redirect to login page if no user is authenticated

    # Fetch the courses that the teacher is associated with
    sql_courses = """
        SELECT CourseID, CourseName FROM store_course
    """
    with connection.cursor() as cursor:
        cursor.execute(sql_courses)
        courses = cursor.fetchall()

    # If no courses are available, show an error
    if not courses:
        return render(request, 'create_quiz.html', {'error': 'No courses available to create a quiz.'})

    if request.method == 'POST':
        # Retrieve form data
        quiz_title = request.POST['quiz_title']
        course_id = request.POST['course']
        time_limit = request.POST['time_limit']
        num_of_questions = request.POST['num_of_questions']

        try:
            # Insert the new quiz record using raw SQL
            sql_insert_quiz = """
                INSERT INTO store_quiz (QuizTitle, Course_id, Faculty_id, Faculty_name, TimeLimit, NumOfQues, CreatedAt)
                VALUES (%s, %s, %s, %s, %s, %s, NOW())
            """
            with connection.cursor() as cursor:
                cursor.execute(sql_insert_quiz, [quiz_title, course_id, userid, username, time_limit, num_of_questions])

                # Get the ID of the newly created quiz
                cursor.execute("SELECT LAST_INSERT_ID()")
                quiz_id = cursor.fetchone()[0]

            # Redirect to the page to add questions for the quiz
            return redirect(f'/teacher/add_questions/{quiz_id}/')

        except Exception as e:
            # Handle error if something goes wrong with the insertion
            return render(request, 'create_quiz.html', {'courses': courses, 'error': str(e)})

    # Render the page with the list of courses for GET requests
    return render(request, 'create_quiz.html', {'courses': courses})


from django.db import transaction


def add_questions(request, quiz_id):
    # Get the current authenticated teacher (if needed for permission checks or context)
    username = request.session.get('username')

    # Query the quiz to get its title and the total number of questions expected
    with connection.cursor() as cursor:
        cursor.execute("SELECT QuizTitle, NumOfQues FROM store_quiz WHERE QuizID = %s", [quiz_id])
        quiz_info = cursor.fetchone()
    if not quiz_info:
        # If no quiz is found (should not happen for a valid quiz_id), redirect to dashboard
        return redirect('/teacher/')
    quiz_title, total_questions = quiz_info[0], int(quiz_info[1])

    if request.method == 'POST':
        # Process the submission of all questions for this quiz
        questions_data = []  # to collect data for each question to insert
        for i in range(1, total_questions + 1):
            # Retrieve form data for question i
            q_text = request.POST.get(f'question_text_{i}')
            opt1 = request.POST.get(f'option1_{i}')
            opt2 = request.POST.get(f'option2_{i}')
            opt3 = request.POST.get(f'option3_{i}')
            opt4 = request.POST.get(f'option4_{i}')
            correct = request.POST.get(f'correct_answer_{i}')
            difficulty = request.POST.get(f'difficulty_{i}')

            # Validate that all fields for this question are provided
            if not q_text or not opt1 or not opt2 or not opt3 or not opt4 or not correct or not difficulty:
                error_msg = "Please fill out all fields for every question before submitting."
                # Re-render the template with an error message (and the same number of question fields)
                context = {
                    'quiz_id': quiz_id,
                    'quiz_title': quiz_title,
                    'total_questions': total_questions,
                    'questions_range': range(1, total_questions + 1),
                    'error': error_msg
                }
                return render(request, 'add_questions.html', context)

            # Convert correct answer to integer (it should be a number 1-4)
            try:
                correct_int = int(correct)
            except ValueError:
                correct_int = None
            questions_data.append((q_text, quiz_id, opt1, opt2, opt3, opt4, correct_int, difficulty))

        # All questions have data; insert them into the database
        try:
            with transaction.atomic():  # ensure all inserts succeed or none
                with connection.cursor() as cursor:
                    insert_sql = """
                        INSERT INTO store_question 
                        (QuesText, Quiz_id, Option1, Option2, Option3, Option4, CorrectAns, DifficultyLevel)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    """
                    for params in questions_data:
                        cursor.execute(insert_sql, params)
            # After successfully adding all questions, redirect to the teacher dashboard
            return redirect('/teacher/')
        except Exception as e:
            # If any error occurs during insertion, show an error on the form
            context = {
                'quiz_id': quiz_id,
                'quiz_title': quiz_title,
                'total_questions': total_questions,
                'questions_range': range(1, total_questions + 1),
                'error': "An error occurred while saving the questions. Please try again."
            }
            return render(request, 'add_questions.html', context)

    else:
        # GET request: show the form to add questions
        # (Optional) Prevent adding more questions if the quiz already has the required number
        with connection.cursor() as cursor:
            cursor.execute("SELECT COUNT(*) FROM store_question WHERE Quiz_id = %s", [quiz_id])
            existing_count = cursor.fetchone()[0]
        if existing_count >= total_questions:
            # All questions are already added; redirect to dashboard
            return redirect('/teacher/')

        # Render the form template with the appropriate number of question fields
        context = {
            'quiz_id': quiz_id,
            'quiz_title': quiz_title,
            'total_questions': total_questions,
            'questions_range': range(1, total_questions + 1)
        }
        return render(request, 'add_questions.html', context)


def create_course(request):
    if request.method == 'POST':
        course_code = request.POST['course_code']
        course_name = request.POST['course_name']
        course_description = request.POST.get('course_description', '')

        # Get the logged-in user's UserID from the session
        user_id = request.session.get('user_id')
        print("User ID from session: ", user_id)  # Debug output

        if not user_id:
            # If user_id is not set, return an error or redirect to login.
            return render(request, 'create_quiz.html', {'error': 'User session expired. Please log in again.'})

        try:
            # Insert the new course into the database
            sql_insert_course = """
                INSERT INTO store_course (CourseCode, CourseName, Description, Faculty_id)
                VALUES (%s, %s, %s, %s)
            """
            with connection.cursor() as cursor:
                cursor.execute(sql_insert_course, [course_code, course_name, course_description, user_id])

            return redirect('/teacher/create_quiz/')  # Redirect back to quiz creation

        except Exception as e:
            return render(request, 'create_quiz.html', {'error': str(e)})

    return render(request, 'create_quiz.html')


# views.py

def quizzes_by_teacher(request):
    quizzes = []
    error_msg = None
    if request.method == 'POST':
        teacher_input = request.POST.get('teacher_identifier', '').strip()
        if teacher_input:
            try:
                with connection.cursor() as cursor:
                    # Determine if input is an ID (numeric) or name (string)
                    if teacher_input.isdigit():
                        # Filter by teacher's UserID
                        cursor.execute("""
                            SELECT QuizID, QuizTitle, TimeLimit, NumOfQues 
                            FROM store_quiz 
                            WHERE Faculty_id = %s
                        """, [int(teacher_input)])
                    else:
                        # Filter by teacher's name (UserName)
                        cursor.execute("""
                            SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues 
                            FROM store_quiz q 
                            JOIN store_user u ON q.Faculty_id = u.UserID 
                            WHERE u.UserName = %s
                        """, [teacher_input])
                    quizzes = cursor.fetchall()  # List of tuples (QuizID, QuizTitle, TimeLimit, NumOfQues)
                    # If no quizzes found, prepare a message
                    if not quizzes:
                        error_msg = "No quizzes found for the given teacher."
            except Exception as e:
                error_msg = f"Error retrieving quizzes: {e}"
        else:
            error_msg = "Please enter a teacher name or ID."
    # On GET (or after POST), render template with form and any results or errors
    return render(request, 'student/quizzes_by_teacher.html', {
        'quizzes': quizzes,
        'error': error_msg,
        'teacher_input': request.POST.get('teacher_identifier', '')
    })



def quizzes_filter(request):
    quizzes = []
    message = None
    # Pre-fetch courses list for the dropdown (optional)
    with connection.cursor() as cursor:
        cursor.execute("SELECT CourseCode FROM store_course")
        courses = [row[0] for row in cursor.fetchall()]
    if request.method == 'POST':
        course_code = request.POST.get('course_code', '').strip()
        difficulty = request.POST.get('difficulty', '').strip()
        time_limit = request.POST.get('time_limit', '').strip()
        num_questions = request.POST.get('num_questions', '').strip()
        try:
            # Build the SQL query dynamically based on provided filters
            base_sql = """
                SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                FROM store_quiz q
                JOIN store_course c ON q.Course_id = c.CourseID
                JOIN store_user u ON q.Faculty_id = u.UserID
                WHERE 1=1
            """
            params = []
            if course_code:
                base_sql += " AND c.CourseCode = %s"
                params.append(course_code)
            if difficulty:
                # Assume Quiz has a DifficultyLevel field (or all questions in quiz share this level)
                base_sql += " AND q.DifficultyLevel = %s"
                params.append(difficulty)
            if time_limit:
                base_sql += " AND q.TimeLimit = %s"
                params.append(time_limit)
            if num_questions:
                base_sql += " AND q.NumOfQues = %s"
                params.append(num_questions)
            with connection.cursor() as cursor:
                cursor.execute(base_sql, params)
                quizzes = cursor.fetchall()  # tuples of (QuizID, QuizTitle, TimeLimit, NumOfQues, TeacherName, CourseName)
            if not quizzes:
                message = "No quizzes match the selected criteria."
        except Exception as e:
            message = f"Error searching quizzes: {e}"
    return render(request, 'student/quizzes_filter.html', {
        'courses': courses,
        'quizzes': quizzes,
        'message': message,
        # Also pass selected filters back to template to retain them
        'selected_course': request.POST.get('course_code', ''),
        'selected_difficulty': request.POST.get('difficulty', ''),
        'selected_time': request.POST.get('time_limit', ''),
        'selected_num': request.POST.get('num_questions', '')
    })




def serve_quiz(request, quiz_id, time_limit, num_of_questions):
    # Fetch the questions for the selected quiz
    sql_questions = """
        SELECT QuesText, Option1, Option2, Option3, Option4 
        FROM store_question 
        WHERE Quiz_id = %s
        LIMIT %s
    """
    with connection.cursor() as cursor:
        cursor.execute(sql_questions, [quiz_id, num_of_questions])
        questions = cursor.fetchall()

    # Pass the questions and quiz details to the template
    return render(request, 'student/take_quiz.html', {
        'questions': questions,
        'quiz_id': quiz_id,
        'time_limit': time_limit
    })



def submit_quiz(request, quiz_id):
    if request.method == 'POST':
        student_id = request.session.get('user_id')  # Get the logged-in student's ID
        answers = request.POST  # Assuming answers are submitted as form data

        # Get the logged-in teacher's username to store it in the Faculty_name field
        teacher_id = request.session.get('user_id')  # Faculty ID
        teacher = User.objects.get(UserID=teacher_id)  # Fetch the teacher using the UserID from the session
        teacher_username = teacher.UserName  # Get the username of the logged-in teacher

        # Calculate the score based on the student's answers
        score = calculate_score(answers, quiz_id)

        # Save the score and teacher username in the Score model
        try:
            sql_insert_score = """
                INSERT INTO store_score (Student_id, Quiz_id, Score)
                VALUES (%s, %s, %s)
            """
            with connection.cursor() as cursor:
                cursor.execute(sql_insert_score, [student_id, quiz_id, score])

            # Optionally, update the Faculty_name field in the Quiz model after submission (if needed)
            sql_update_faculty_name = """
                UPDATE store_quiz
                SET Faculty_name = %s
                WHERE QuizID = %s
            """
            with connection.cursor() as cursor:
                cursor.execute(sql_update_faculty_name, [teacher_username, quiz_id])

            return redirect('/student/')  # Redirect back to the student dashboard after submission

        except Exception as e:
            return render(request, 'student/take_quiz.html', {'error': str(e)})

    return render(request, 'student/take_quiz.html')



def calculate_score(answers, quiz_id):
    # Calculate the score here based on the student's answers and the correct answers from the database
    score = 0
    for question_id, answer in answers.items():
        # Compare the student's answer with the correct answer from the database (fetch correct answers)
        sql_answer = """
            SELECT CorrectAns FROM store_question WHERE QuesID = %s AND Quiz_id = %s
        """
        with connection.cursor() as cursor:
            cursor.execute(sql_answer, [question_id, quiz_id])
            correct_answer = cursor.fetchone()

        if correct_answer and answer == str(correct_answer[0]):
            score += 1

    return score



def teacher_view_scores(request):
    if request.method == 'POST':
        teacher_id = request.POST['teacher_id']

        # Fetch all quizzes created by the teacher
        sql_quizzes = """
            SELECT q.QuizID, q.QuizTitle 
            FROM store_quiz q
            WHERE q.Faculty_id = %s
        """
        with connection.cursor() as cursor:
            cursor.execute(sql_quizzes, [teacher_id])
            quizzes = cursor.fetchall()

        # Fetch all student scores for these quizzes
        sql_scores = """
            SELECT s.Score, u.UserName, s.SubmittedAt
            FROM store_score s
            JOIN store_user u ON s.Student_id = u.UserID
            WHERE s.Quiz_id IN (SELECT QuizID FROM store_quiz WHERE Faculty_id = %s)
        """
        with connection.cursor() as cursor:
            cursor.execute(sql_scores, [teacher_id])
            scores = cursor.fetchall()

        return render(request, 'teacher/view_scores.html', {'scores': scores, 'quizzes': quizzes})

    return render(request, 'teacher/input_teacher_id.html')



def see_quiz(request):
    # Fetch teacher's ID from session
    teacher_id = request.session.get('user_id')

    if request.method == 'POST':
        teacher_name = request.POST.get('teacher_name', '')
        teacher_id_input = request.POST.get('teacher_id', '')
        course_code = request.POST.get('course_code', '')

        # Base query for fetching quizzes (without difficulty level)
        sql_quizzes = """
            SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName 
            FROM store_quiz q
            JOIN store_user u ON q.Faculty_id = u.UserID
            WHERE 1
        """

        # Conditions based on input fields
        conditions = []
        params = []
        if teacher_id_input:
            conditions.append("u.UserID = %s")
            params.append(teacher_id_input)
        if teacher_name:
            conditions.append("u.UserName LIKE %s")
            params.append(f"%{teacher_name}%")
        if course_code:
            conditions.append("q.Course_id IN (SELECT CourseID FROM store_course WHERE CourseCode = %s)")
            params.append(course_code)

        # Combine base query with conditions
        if conditions:
            sql_quizzes += " AND " + " AND ".join(conditions)

        # Execute the query with the accumulated conditions and parameters
        with connection.cursor() as cursor:
            cursor.execute(sql_quizzes, params)
            quizzes = cursor.fetchall()

        # Render the results page with the filtered quizzes
        return render(request, 'teacher/view_quizzes.html', {'quizzes': quizzes})

    # For GET request, just render the filtering form page
    return render(request, 'teacher/see_quiz.html')



def quiz_results(request, quiz_id):
    # (Optional) Verify the logged-in teacher owns this quiz:
    # You could query store_quiz to check Faculty_id and compare with request.session['user_id'].
    quiz_title = None
    scores = []
    try:
        with connection.cursor() as cursor:
            # Get the quiz title for context
            cursor.execute("SELECT QuizTitle, Faculty_id FROM store_quiz WHERE QuizID = %s", [quiz_id])
            quiz = cursor.fetchone()
            if not quiz:
                return render(request, 'teacher/quiz_results.html', {'error': "Quiz not found."})
            quiz_title = quiz[0]
            # If needed, ensure the user is the owner:
            # teacher_id = request.session.get('user_id')
            # if quiz[1] != teacher_id: return HttpResponseForbidden("Not your quiz.")
            # Fetch all students and their scores for this quiz
            cursor.execute("""
                SELECT u.UserName, s.Score 
                FROM store_score s 
                JOIN store_user u ON s.Student_id = u.UserID 
                WHERE s.Quiz_id = %s
            """, [quiz_id])
            scores = cursor.fetchall()  # list of (UserName, Score)
    except Exception as e:
        return render(request, 'teacher/quiz_results.html', {'error': f"Error loading results: {e}"})
    return render(request, 'teacher/quiz_results.html', {
        'quiz_title': quiz_title,
        'scores': scores
    })




def view_student_scores(request, quiz_id):
    # Get the teacher's ID from session
    teacher_id = request.session.get('user_id')

    # Fetch all student scores for the quiz
    sql_scores = """
        SELECT s.Score, u.UserName, s.SubmittedAt
        FROM store_score s
        JOIN store_user u ON s.Student_id = u.UserID
        WHERE s.Quiz_id = %s
    """
    with connection.cursor() as cursor:
        cursor.execute(sql_scores, [quiz_id])
        scores = cursor.fetchall()

    return render(request, 'teacher/view_student_scores.html', {'scores': scores, 'quiz_id': quiz_id})



def view_quiz(request, quiz_id):
    # Fetch quiz details
    sql_quiz = """
        SELECT q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName 
        FROM store_quiz q
        JOIN store_user u ON q.Faculty_id = u.UserID
        WHERE q.QuizID = %s
    """
    with connection.cursor() as cursor:
        cursor.execute(sql_quiz, [quiz_id])
        quiz = cursor.fetchone()

    # Fetch questions for this quiz
    sql_questions = """
        SELECT QuesText, Option1, Option2, Option3, Option4, CorrectAns
        FROM store_question
        WHERE Quiz_id = %s
    """
    with connection.cursor() as cursor:
        cursor.execute(sql_questions, [quiz_id])
        questions = cursor.fetchall()

    return render(request, 'teacher/view_quiz.html', {'quiz': quiz, 'questions': questions})

def teacher_quizzes(request):
    quiz_list = []
    error = None
    if request.method == 'POST':
        identifier = request.POST.get('teacher_identifier', '').strip()
        if not identifier:
            error = "Please enter your User ID or Name."
        else:
            try:
                # Determine teacher's UserID (if name given)
                with connection.cursor() as cursor:
                    if identifier.isdigit():
                        teacher_id = int(identifier)
                    else:
                        # Look up the user ID by name
                        cursor.execute("SELECT UserID FROM store_user WHERE UserName = %s", [identifier])
                        result = cursor.fetchone()
                        if not result:
                            teacher_id = None
                        else:
                            teacher_id = result[0]
                if teacher_id is None:
                    error = "No teacher found with that name."
                else:
                    # Fetch quizzes by this teacher with count of students who took each
                    with connection.cursor() as cursor:
                        cursor.execute(f"""
                            SELECT q.QuizID, q.QuizTitle,
                                   (SELECT COUNT(*) FROM store_score s WHERE s.Quiz_id = q.QuizID) AS taken_count
                            FROM store_quiz q
                            WHERE q.Faculty_id = %s
                        """, [teacher_id])
                        quiz_list = cursor.fetchall()  # list of tuples (QuizID, QuizTitle, taken_count)
                    if not quiz_list:
                        message = "You have not created any quizzes yet."
            except Exception as e:
                error = f"Error retrieving quizzes: {e}"
    else:
        # GET request – we could optionally auto-fill the form if the teacher is logged in
        message = "Enter your name or ID to see your quizzes."
    return render(request, 'teacher/my_quizzes.html', {
        'quizzes': quiz_list,
        'error': error,
        'message': locals().get('message', None)
    })



def student_dashboard(request):
    username = request.session.get('username')
    # Render a simple dashboard with links to both flows
    return render(request, 'student_dashboard.html', {'username': username})


def search_quizzes(request):
    error = None
    quizzes = []
    teacher_query = ''
    course_query = ''

    if request.method == 'POST':
        # We allow two kinds of searches in one form:
        # either by teacher identifier or by course identifier.
        teacher_query = request.POST.get('teacher_query', '').strip()
        course_query = request.POST.get('course_query', '').strip()

        if teacher_query or course_query:
            sql = """
                SELECT q.QuizID, q.QuizTitle, q.TimeLimit, q.NumOfQues, u.UserName, c.CourseName
                FROM store_quiz q
                JOIN store_user u ON q.Faculty_id = u.UserID
                JOIN store_course c ON q.Course_id = c.CourseID
                WHERE 1=1
            """
            params = []
            if teacher_query:
                # If numeric assume teacher ID; otherwise, search by teacher name.
                if teacher_query.isdigit():
                    sql += " AND u.UserID = %s"
                    params.append(int(teacher_query))
                else:
                    sql += " AND u.UserName LIKE %s"
                    params.append(f"%{teacher_query}%")
            if course_query:
                # Search by course code or course name (assuming course_name is in the table)
                sql += " AND (c.CourseCode LIKE %s OR c.CourseName LIKE %s)"
                params.extend([f"%{course_query}%", f"%{course_query}%"])
            try:
                with connection.cursor() as cursor:
                    cursor.execute(sql, params)
                    quizzes = cursor.fetchall()  # Each tuple is (id, title, time, num, teacher, course)
                if not quizzes:
                    error = "No quizzes found for the given criteria."
            except Exception as e:
                error = f"Error: {e}"
        else:
            error = "Please enter a teacher name/ID or a course to search."
    return render(request, 'student/search_quizzes.html', {
        'quizzes': quizzes,
        'error': error,
        'teacher_query': teacher_query,
        'course_query': course_query,
    })


import random


def custom_quiz(request):
    error = None
    questions = []
    if request.method == 'POST':
        course_query = request.POST.get('course_query', '').strip()
        difficulty = request.POST.get('difficulty', '').strip()
        custom_time = request.POST.get('custom_time', '').strip()
        num_questions = request.POST.get('num_questions', '').strip()
        # Validate inputs
        if not (course_query and difficulty and custom_time and num_questions):
            error = "Please fill out all fields."
        else:
            try:
                num_questions = int(num_questions)
                custom_time = int(custom_time)
            except ValueError:
                error = "Time limit and number of questions must be numbers."

        if not error:
            # Query questions for given criteria. This selects all questions matching the course and difficulty.
            sql = """
                SELECT QuesID, QuesText, Option1, Option2, Option3, Option4, CorrectAns
                FROM store_question
                WHERE DifficultyLevel = %s 
                AND Quiz_id IN (
                    SELECT QuizID FROM store_quiz 
                    WHERE Course_id IN (
                        SELECT CourseID FROM store_course 
                        WHERE CourseCode LIKE %s OR CourseName LIKE %s
                    )
                )
            """
            # Use the course_query for both CourseCode and CourseName matching.
            params = [difficulty, f"%{course_query}%", f"%{course_query}%"]
            try:
                with connection.cursor() as cursor:
                    cursor.execute(sql, params)
                    all_questions = cursor.fetchall()  # List of questions matching criteria.
                if not all_questions:
                    error = "No questions found matching these criteria."
                else:
                    # Randomly select the desired number of questions (if available)
                    if len(all_questions) < num_questions:
                        error = "Not enough questions found. Try a different criteria."
                    else:
                        questions = random.sample(all_questions, num_questions)
            except Exception as e:
                error = f"Error retrieving questions: {e}"

        # If no error and questions are selected, save the custom quiz for the student or pass to template to render quiz.
        if questions:
            # For simplicity we pass the questions list and custom time to a quiz-taking template.
            return render(request, 'student/custom_quiz.html', {
                'questions': questions,
                'custom_time': custom_time,
            })
    return render(request, 'student/custom_quiz.html', {'error': error})



def submit_custom_quiz(request):
    if request.method == 'POST':
        student_id = request.session.get('user_id')
        # Assuming each question's form field name is the QuesID
        answers = request.POST  # Contains responses keyed by question IDs
        # Use the existing calculate_score function or implement a custom version
        # For example:
        score = calculate_score(answers, None)  # If custom quiz doesn’t have a QuizID, modify accordingly.
        # Save result in a custom way or show the result immediately.
        return render(request, 'student/custom_quiz_results.html', {'score': score})
    return redirect('/student/')


from django.shortcuts import render, redirect
from django.db import connection

def take_quiz(request, quiz_id):
    # Retrieve quiz details (e.g., title and time limit)
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT QuizTitle, TimeLimit 
            FROM store_quiz 
            WHERE QuizID = %s
        """, [quiz_id])
        quiz = cursor.fetchone()  # quiz is a tuple: (QuizTitle, TimeLimit)

    # Retrieve all questions for this quiz
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT QuesID, QuesText, Option1, Option2, Option3, Option4, CorrectAns
            FROM store_question
            WHERE Quiz_id = %s
            ORDER BY QuesID
        """, [quiz_id])
        questions = cursor.fetchall()

    return render(request, 'student/take_quiz.html', {
        'quiz_id': quiz_id,
        'quiz': quiz,
        'questions': questions
    })


def submit_quiz(request, quiz_id):
    if request.method == 'POST':
        student_id = request.session.get('user_id')
        answers = request.POST  # The submitted form data; keys are expected to be QuesIDs

        score = 0
        total = 0
        with connection.cursor() as cursor:
            for key, value in answers.items():
                # Skip non-question keys (e.g., csrfmiddlewaretoken)
                try:
                    ques_id = int(key)
                except ValueError:
                    continue
                # Fetch the correct answer for this question
                cursor.execute("""
                    SELECT CorrectAns 
                    FROM store_question 
                    WHERE QuesID = %s AND Quiz_id = %s
                """, [ques_id, quiz_id])
                result = cursor.fetchone()
                if result:
                    correct = result[0]
                    total += 1
                    if str(correct) == value:  # Compare as strings
                        score += 1

        # Save or update the student's score and record the submission time
        with connection.cursor() as cursor:
            # Check if there's already an entry for this student and quiz.
            cursor.execute("""
                SELECT Score 
                FROM store_score 
                WHERE Student_id = %s AND Quiz_id = %s
            """, [student_id, quiz_id])
            existing = cursor.fetchone()
            if existing:
                # If the record exists, update the score and update the submission time.
                cursor.execute("""
                    UPDATE store_score 
                    SET Score = %s, SubmittedAt = NOW()
                    WHERE Student_id = %s AND Quiz_id = %s
                """, [score, student_id, quiz_id])
            else:
                # Otherwise, insert a new record along with the current timestamp.
                cursor.execute("""
                    INSERT INTO store_score (Student_id, Quiz_id, Score, SubmittedAt)
                    VALUES (%s, %s, %s, NOW())
                """, [student_id, quiz_id, score])

        # Redirect to the quiz results page after submission.
        return redirect(f"/student/quiz/{quiz_id}/results/")
    else:
        return redirect("/student/")


def quiz_results(request, quiz_id):
    student_id = request.session.get('user_id')

    # Retrieve the student's score for this quiz
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT Score
            FROM store_score
            WHERE Student_id = %s AND Quiz_id = %s
        """, [student_id, quiz_id])
        result = cursor.fetchone()
    score = result[0] if result else None

    # Retrieve questions along with their correct answers so the student can review
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT QuesText, Option1, Option2, Option3, Option4, CorrectAns
            FROM store_question
            WHERE Quiz_id = %s
            ORDER BY QuesID
        """, [quiz_id])
        questions = cursor.fetchall()

    return render(request, 'student/quiz_results.html', {
        'quiz_id': quiz_id,
        'score': score,
        'questions': questions
    })

def student_number(request, quiz_id):
    # Fetch the number of students who took this quiz
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(DISTINCT Student_id) 
            FROM store_score 
            WHERE Quiz_id = %s
        """, [quiz_id])
        student_count = cursor.fetchone()[0]

    # Fetch the students who took the quiz, their names, and scores
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT s.Student_id, u.UserName, s.Score
            FROM store_score s
            JOIN store_user u ON s.Student_id = u.UserID
            WHERE s.Quiz_id = %s
        """, [quiz_id])
        student_results = cursor.fetchall()

    return render(request, 'teacher/student_number.html', {
        'quiz_id': quiz_id,
        'student_count': student_count,
        'student_results': student_results
    })

def student_result(request, student_id, quiz_id):
    # Fetch the student's answers and scores for the quiz
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT q.QuesText, s.Answer, q.CorrectAns
            FROM store_response s
            JOIN store_question q ON s.Question_id = q.QuesID
            WHERE s.Student_id = %s AND s.Quiz_id = %s
        """, [student_id, quiz_id])
        answers = cursor.fetchall()

    return render(request, 'teacher/student_result.html', {
        'answers': answers,
        'quiz_id': quiz_id,
        'student_id': student_id
    })



def teacher_dashboard(request):
    # Fetch all quizzes for the teacher
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT QuizID, QuizTitle
            FROM store_quiz
            WHERE Faculty_id = %s
        """, [request.session.get('user_id')])
        quizzes = cursor.fetchall()

    return render(request, 'teacher_dashboard.html', {
        'quizzes': quizzes,  # Pass quizzes list with quiz_id and title
        'username': request.session.get('username')
    })


def student_taken_quizzes(request):
    # Retrieve the student's info from session
    user_id = request.session.get('user_id')

    # Fetch quizzes that the student has taken
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT q.QuizID, q.QuizTitle, s.Score, q.TimeLimit, q.NumOfQues
            FROM store_score s
            JOIN store_quiz q ON s.Quiz_id = q.QuizID
            WHERE s.Student_id = %s
        """, [user_id])
        taken_quizzes = cursor.fetchall()

    # Render the page with the taken quizzes
    return render(request, 'student/taken_quizzes.html', {'taken_quizzes': taken_quizzes})


def teacher_quiz_students(request):
    # Get the logged-in teacher's ID from session
    teacher_id = request.session.get('user_id')

    if not teacher_id:
        return redirect('/Login/')  # If no teacher is logged in, redirect to login page

    # Fetch the quizzes created by the teacher
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT q.QuizID, q.QuizTitle
            FROM store_quiz q
            WHERE q.Faculty_id = %s
        """, [teacher_id])
        quizzes = cursor.fetchall()

    quiz_students = []

    # Fetch students who took each quiz with their score and submission time
    for quiz in quizzes:
        quiz_id, quiz_title = quiz
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT u.UserName, s.Score, s.SubmittedAt
                FROM store_score s
                JOIN store_user u ON s.Student_id = u.UserID
                WHERE s.Quiz_id = %s
            """, [quiz_id])
            students = cursor.fetchall()
            quiz_students.append({
                'quiz_title': quiz_title,
                'students': students
            })

    return render(request, 'teacher/quiz_students.html', {'quiz_students': quiz_students})



