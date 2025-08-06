# Firebase Setup Instructions

## Step 5: Add iOS App (Optional)

1. Click **"Add app"** → iOS icon
2. Enter bundle ID: `com.nulinz.task_management_app`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` folder

## Step 6: Replace Demo Config Files

**Delete existing demo files:**
```bash
rm android/app/google-services.json
rm ios/Runner/GoogleService-Info.plist
```

**Add your real Firebase config files:**
- Place your downloaded `google-services.json` in `android/app/`
- Place your downloaded `GoogleService-Info.plist` in `ios/Runner/`

## Step 7: Update Firestore Rules

In Firebase Console → Firestore Database → Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{document} {
      allow read, write: if request.auth != null;
    }
    
    // Employee tasks collection
    match /employee_task/{document} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Step 8: Test the Integration

1. Run `flutter clean`
2. Run `flutter pub get`
3. Run `flutter run`
4. Try creating an account
5. Try logging in
6. Try creating tasks

## Troubleshooting

**If you get build errors:**
1. Clean project: `flutter clean`
2. Get dependencies: `flutter pub get`
3. Rebuild: `flutter run`

**If authentication fails:**
1. Check if Email/Password is enabled in Firebase Console
2. Verify your config files are in correct locations

**If Firestore fails:**
1. Check Firestore rules allow authenticated users
2. Verify your project ID matches in config files