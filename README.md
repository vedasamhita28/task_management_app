# Task Management App

A modern and efficient task management application built with Flutter, designed to help users organize their tasks and boost productivity.

## Features

- 📱 Cross-platform support (iOS & Android)
- 🔔 Push Notifications for task reminders
- 🎨 Modern and intuitive user interface
- 📊 Task categorization and prioritization
- 🔄 Real-time task synchronization
- 🌙 Dark/Light theme support
- 🔒 Secure user authentication
- 📅 Calendar integration
- 📈 Progress tracking and analytics

## Getting Started

## Screens from the Application 

![Image](https://github.com/user-attachments/assets/81de5958-37f3-43a5-b4ac-20aa760f05e3) ![Image](https://github.com/user-attachments/assets/11d44da2-a0df-4b39-bb7d-f2bb56858b57) ![Image](https://github.com/user-attachments/assets/1089937d-6b8e-4a51-a539-b1a9acbd9bb0) 
![Image](https://github.com/user-attachments/assets/94b1d44d-75a7-43fc-8c10-0390c306be08) ![Image](https://github.com/user-attachments/assets/86d67c03-62fc-4faa-81d0-b58c90931bd1) ![Image](https://github.com/user-attachments/assets/c9010e70-57db-403e-beb8-4e8229023571)


### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code
- Firebase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/task_management_app.git
```

2. Navigate to the project directory:
```bash
cd task_management_app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Configure Firebase:
   - Create a new Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and add the configuration files:
     - For Android: Place `google-services.json` in `android/app/`
     - For iOS: Place `GoogleService-Info.plist` in `ios/Runner/`

5. Configure Push Notifications:
   - Get the server key from Firebase Console
   - Create `lib/widgets/server_key.dart` with your Firebase server key

### Running the App

```bash
flutter run
```

## Project Structure

```
lib/
├── models/         # Data models
├── screens/        # UI screens
├── widgets/        # Reusable widgets
├── services/       # Business logic and services
├── utils/          # Utility functions
└── main.dart       # Entry point
```

## Dependencies

- Firebase Core
- Firebase Auth
- Firebase Cloud Messaging
- Provider (State Management)
- Shared Preferences
- Flutter Local Notifications

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors who have helped shape this project

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)
Project Link: [https://github.com/yourusername/task_management_app](https://github.com/yourusername/task_management_app)

