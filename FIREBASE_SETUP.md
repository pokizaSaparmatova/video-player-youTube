# Firebase Setup Guide

This guide will help you set up Firebase for your Flutter authentication app.

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or "Create a project"
3. Enter a project name (e.g., "flutter-auth-app")
4. Choose whether to enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Enable Authentication

1. In your Firebase project, go to "Authentication" in the left sidebar
2. Click on the "Sign-in method" tab
3. Enable the "Email/Password" provider:
   - Click on "Email/Password"
   - Toggle "Enable" to ON
   - Click "Save"

## Step 3: Add Your App to Firebase

### For Android:

1. In the Firebase console, click the Android icon to add an Android app
2. Enter your Android package name: `com.example.videoPlayerYouTube`
3. Enter an app nickname (optional): "Flutter Auth App"
4. Enter the SHA-1 certificate fingerprint (optional for now)
5. Click "Register app"
6. Download the `google-services.json` file
7. Place this file in your Flutter project at: `android/app/google-services.json`

### For iOS:

1. In the Firebase console, click the iOS icon to add an iOS app
2. Enter your iOS bundle ID: `com.example.videoPlayerYouTube`
3. Enter an app nickname (optional): "Flutter Auth App"
4. Enter your App Store ID (optional)
5. Click "Register app"
6. Download the `GoogleService-Info.plist` file
7. Place this file in your Flutter project at: `ios/Runner/GoogleService-Info.plist`

### For Web:

1. In the Firebase console, click the Web icon to add a web app
2. Enter an app nickname: "Flutter Auth App"
3. Check "Also set up Firebase Hosting" if you want to deploy to Firebase Hosting
4. Click "Register app"
5. Copy the Firebase config object - you'll need this for the next step

## Step 4: Configure Firebase Options

Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration:

### Method 1: Manual Configuration

Update the values in `lib/firebase_options.dart`:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-actual-web-api-key',
  appId: 'your-actual-web-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  authDomain: 'your-project-id.firebaseapp.com',
  storageBucket: 'your-project-id.appspot.com',
);

static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-actual-android-api-key',
  appId: 'your-actual-android-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  storageBucket: 'your-project-id.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'your-actual-ios-api-key',
  appId: 'your-actual-ios-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  storageBucket: 'your-project-id.appspot.com',
  iosClientId: 'your-actual-ios-client-id',
  iosBundleId: 'com.example.videoPlayerYouTube',
);
```

### Method 2: Using FlutterFire CLI (Recommended)

1. Install Firebase CLI and FlutterFire CLI:
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Configure FlutterFire:
   ```bash
   flutterfire configure
   ```

4. This will automatically generate a new `firebase_options.dart` file with your actual configuration.

## Step 5: Update Android Configuration (if targeting Android)

Add the following to your `android/app/build.gradle` file:

```gradle
// At the top of the file, add:
apply plugin: 'com.google.gms.google-services'

// In the dependencies section, add:
implementation 'com.google.firebase:firebase-bom:32.0.0'
```

Add the following to your `android/build.gradle` file:

```gradle
// In the dependencies section, add:
classpath 'com.google.gms:google-services:4.3.15'
```

## Step 6: Update iOS Configuration (if targeting iOS)

1. Open your iOS project in Xcode: `ios/Runner.xcworkspace`
2. Right-click on "Runner" in the project navigator
3. Select "Add Files to Runner"
4. Navigate to and select the `GoogleService-Info.plist` file you downloaded
5. Make sure "Copy items if needed" is checked
6. Click "Add"

## Step 7: Test Your Setup

1. Run your Flutter app:
   ```bash
   flutter run
   ```

2. Try creating a new account or signing in
3. Check the Firebase Console > Authentication > Users to see if users are being created

## Troubleshooting

### Common Issues:

1. **"No Firebase App '[DEFAULT]' has been created"**
   - Make sure `Firebase.initializeApp()` is called in `main.dart`
   - Verify your `firebase_options.dart` configuration

2. **"google-services.json not found"**
   - Ensure the file is placed in `android/app/google-services.json`
   - Make sure the Android configuration is properly set up

3. **"GoogleService-Info.plist not found"**
   - Ensure the file is added to your iOS project in Xcode
   - Verify the file is in the correct target

4. **Authentication not working**
   - Check that Email/Password provider is enabled in Firebase Console
   - Verify your project configuration matches your Firebase project

### Debug Mode:

You can enable debug mode to see more detailed error messages:

```dart
// In your main.dart, add:
FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
```

## Security Rules (Optional)

For production apps, consider setting up Firestore security rules in the Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Next Steps

After completing the setup:

1. Test all authentication flows (sign up, sign in, password reset, sign out)
2. Customize the UI to match your brand
3. Add additional Firebase services (Firestore, Storage, etc.) if needed
4. Set up proper error handling and validation
5. Configure security rules for production

Your Flutter authentication app with Firebase is now ready to use!