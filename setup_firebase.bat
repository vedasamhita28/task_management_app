@echo off
echo Setting up Firebase for Task Management App...
echo.

echo Step 1: Cleaning project...
flutter clean

echo Step 2: Getting dependencies...
flutter pub get

echo Step 3: Building project...
flutter build apk --debug

echo.
echo Firebase setup complete!
echo.
echo Next steps:
echo 1. Go to https://console.firebase.google.com
echo 2. Create a new project named 'task-management-app'
echo 3. Add Android app with package: com.nulinz.task_management_app
echo 4. Download google-services.json and place in android/app/
echo 5. Enable Authentication (Email/Password)
echo 6. Create Firestore Database
echo.
pause