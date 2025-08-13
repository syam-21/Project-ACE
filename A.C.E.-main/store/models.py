from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager


# Custom User Manager
class UserManager(BaseUserManager):
    def create_user(self, user_email, password=None, **extra_fields):
        if not user_email:
            raise ValueError('Users must have an email address')
        user = self.model(
            user_email=self.normalize_email(user_email),
            **extra_fields
        )
        user.set_password(password)
        user.save(using=self._db)
        return user


# User Model
# models.py
class User(AbstractBaseUser):
    ROLES = (
        ('admin', 'Admin'),  # Added admin role
        ('faculty', 'Faculty'),
        ('student', 'Student'),
    )

    UserID = models.AutoField(primary_key=True)
    UserName = models.CharField(max_length=255)
    UserEmail = models.EmailField(unique=True)
    UserInstitute = models.CharField(max_length=255)
    UserRole = models.CharField(max_length=7, choices=ROLES, default='student')

    # Add admin control fields
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)  # Added for admin access
    last_login = models.DateTimeField(null=True, blank=True)

    USERNAME_FIELD = 'UserEmail'
    REQUIRED_FIELDS = ['UserName']

    objects = UserManager()

    def __str__(self):
        return self.UserName

    # Add these methods for admin privileges
    def has_perm(self, perm, obj=None):
        return self.UserRole == 'admin'

    def has_module_perms(self, app_label):
        return self.UserRole == 'admin'


# Course Model
class Course(models.Model):
    CourseID = models.AutoField(primary_key=True)
    CourseCode = models.CharField(max_length=50, unique=True)
    CourseName = models.CharField(max_length=255)
    Description = models.TextField(blank=True, null=True)
    Faculty = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        related_name='courses'
    )

    def __str__(self):
        return self.CourseName


# Quiz Model
class Quiz(models.Model):
    QuizID = models.AutoField(primary_key=True)
    QuizTitle = models.CharField(max_length=255)
    Course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE,
        related_name='quizzes'
    )
    Faculty = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        related_name='quizzes'
    )
    Faculty_name = models.CharField(max_length=255, blank=True, null=True)  # Store Faculty name (optional field)
    TimeLimit = models.PositiveIntegerField()  # in minutes
    NumOfQues = models.PositiveIntegerField()
    CreatedAt = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.QuizTitle

    def save(self, *args, **kwargs):
        # Automatically set the Faculty_name to the related User's UserName
        if self.Faculty:
            self.Faculty_name = self.Faculty.UserName
        super().save(*args, **kwargs)



# Question Model
class Question(models.Model):
    DIFFICULTY_LEVELS = (
        ('easy', 'Easy'),
        ('medium', 'Medium'),
        ('hard', 'Hard'),
    )

    QuesID = models.AutoField(primary_key=True)
    QuesText = models.TextField()
    Quiz = models.ForeignKey(
        Quiz,
        on_delete=models.CASCADE,
        related_name='questions'
    )
    Option1 = models.CharField(max_length=255)
    Option2 = models.CharField(max_length=255)
    Option3 = models.CharField(max_length=255)
    Option4 = models.CharField(max_length=255)
    CorrectAns = models.PositiveSmallIntegerField()  # 1-4
    DifficultyLevel = models.CharField(
        max_length=6,
        choices=DIFFICULTY_LEVELS
    )

    def __str__(self):
        return self.QuesText[:50]  # Return first 50 chars of question


# Score Model
class Score(models.Model):
    ScoreID = models.AutoField(primary_key=True)
    Student = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='scores'
    )
    Quiz = models.ForeignKey(
        Quiz,
        on_delete=models.CASCADE,
        related_name='scores'
    )
    Score = models.PositiveIntegerField()
    SubmittedAt = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('Student', 'Quiz')  # One score per quiz per student

    def __str__(self):
        return f"{self.Student.UserName} - {self.Quiz.QuizTitle}"