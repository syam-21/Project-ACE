from django.urls import path
from . import views

urlpatterns = [
    # Home and Info routes
    path('', views.homepage, name='homepage'),
    path('about/', views.about, name='about'),
    path('Login/', views.Login, name='Login'),
    path('Signup/', views.Signup, name='Signup'),
    path('Info/', views.Info, name='Info'),
    path('Logout/', views.Logout, name='Logout'),

    # Student routes
    path('student/', views.student_dashboard, name='student_dashboard'),
    path('student/search_quizzes/', views.search_quizzes, name='search_quizzes'),
    path('student/custom_quiz/', views.custom_quiz, name='custom_quiz'),
    path('student/quiz/<int:quiz_id>/results/', views.quiz_results, name='quiz_results'),
    path('student/serve_quiz/<int:quiz_id>/<int:time_limit>/<int:num_of_questions>/', views.serve_quiz, name='serve_quiz'),
    path('student/submit_quiz/<int:quiz_id>/', views.submit_quiz, name='submit_quiz'),
    path('student/take_quiz/<int:quiz_id>/', views.take_quiz, name='take_quiz'),
    path('student/quiz_results/<int:quiz_id>/', views.quiz_results, name='quiz_results'),
    path('student/quizzes_by_teacher/', views.quizzes_by_teacher, name='quizzes_by_teacher'),
    path('student/quizzes_filter/', views.quizzes_filter, name='quizzes_filter'),

    # Admin routes
    path('admin/', views.admin, name='admin'),
    path('delete_user/', views.delete_user, name='delete_user'),
    path('delete_course/', views.delete_course, name='delete_course'),
    path('delete_quiz/', views.delete_quiz, name='delete_quiz'),
    path('create_course/', views.create_course, name='create_course'),

    # Teacher routes
    path('teacher/', views.teacher, name='teacher'),
    path('teacher/create_quiz/', views.create_quiz, name='create_quiz'),
    path('teacher/see_quiz/', views.see_quiz, name='see_quiz'),
    path('teacher/add_questions/<int:quiz_id>/', views.add_questions, name='add_questions'),
    path('teacher/student_result/<int:student_id>/<int:quiz_id>/', views.student_result, name='student_result'),
    path('teacher/my_quizzes/', views.teacher_quizzes, name='teacher_quizzes'),
    path('teacher/view_student_scores/<int:quiz_id>/', views.view_student_scores, name='view_student_scores'),
    path('teacher/quiz_results/<int:quiz_id>/', views.quiz_results, name='quiz_results'),
    path('teacher/see_quiz/<int:quiz_id>/', views.view_quiz, name='view_quiz'),
    path('teacher/student_number/<int:quiz_id>/', views.student_number, name='student_number'),
    # Routes for students to view teacher's quizzes (and take them)
    path('teacher/student_number/', views.student_number, name='student_number'),
    path('student/taken_quizzes/', views.student_taken_quizzes, name='student_taken_quizzes'),
    path('teacher/quiz_students/', views.teacher_quiz_students, name='teacher_quiz_students'),

]
