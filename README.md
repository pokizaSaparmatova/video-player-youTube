# Flutter Authentication App with Bloc & Firebase

A beautiful Flutter authentication app that implements the login screen design with Bloc state management and Firebase authentication.

## Features

- 🎨 **Beautiful UI Design** - Matches the modern gradient design from the provided mockup
- 🔐 **Firebase Authentication** - Email/password sign-in, sign-up, and password reset
- 🏗️ **Bloc State Management** - Clean architecture with BLoC pattern
- 📱 **Responsive Design** - Works on different screen sizes
- ✨ **Modern Animations** - Smooth transitions and loading states
- 🔒 **Form Validation** - Client-side validation for email and password fields

## Screenshots

The app includes the following screens:
- **Login Screen** - Matches the provided design with gradient header
- **Sign Up Screen** - Clean registration form
- **Forgot Password Screen** - Password reset functionality
- **Home Screen** - Welcome screen for authenticated users

## Getting Started

### Prerequisites

- Flutter SDK (3.1.5 or higher)
- Firebase project set up
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd flutter-auth-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   
   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable Authentication in your Firebase project:
      - Go to Authentication > Sign-in method
      - Enable "Email/Password" provider
   
   c. Add your app to Firebase:
      - For Android: Download `google-services.json` and place it in `android/app/`
      - For iOS: Download `GoogleService-Info.plist` and place it in `ios/Runner/`
   
   d. Install Firebase CLI and FlutterFire CLI:
      ```bash
      npm install -g firebase-tools
      dart pub global activate flutterfire_cli
      ```
   
   e. Configure Firebase for Flutter:
      ```bash
      flutterfire configure
      ```
      
      This will generate a new `firebase_options.dart` file with your actual Firebase configuration.

4. **Update Firebase Configuration**
   
   Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase project configuration, or use the auto-generated file from FlutterFire CLI.

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── blocs/
│   └── auth/
│       ├── auth_bloc.dart       # Main authentication BLoC
│       ├── auth_event.dart      # Authentication events
│       └── auth_state.dart      # Authentication states
├── screens/
│   ├── login_screen.dart        # Login UI (matches design)
│   ├── signup_screen.dart       # Registration UI
│   ├── forgot_password_screen.dart  # Password reset UI
│   └── home_screen.dart         # Home screen for authenticated users
├── firebase_options.dart        # Firebase configuration
└── main.dart                    # App entry point
```

## Dependencies

```yaml
dependencies:
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  
  # Bloc State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2
  equatable: ^2.0.5
```

## Authentication Flow

1. **App Launch**: Checks if user is already authenticated
2. **Login Screen**: User enters email and password
3. **Registration**: New users can create an account
4. **Password Reset**: Users can reset forgotten passwords via email
5. **Home Screen**: Authenticated users see the welcome screen
6. **Sign Out**: Users can securely sign out

## Bloc Architecture

The app uses the BLoC (Business Logic Component) pattern for state management:

### Events
- `AuthSignInRequested` - User attempts to sign in
- `AuthSignUpRequested` - User attempts to create account
- `AuthSignOutRequested` - User signs out
- `AuthCheckRequested` - Check current auth status
- `AuthForgotPasswordRequested` - Request password reset

### States
- `AuthInitial` - Initial state
- `AuthLoading` - Processing authentication
- `AuthAuthenticated` - User successfully signed in
- `AuthUnauthenticated` - User not signed in
- `AuthError` - Authentication error occurred
- `AuthPasswordResetSent` - Password reset email sent

## UI Design

The app recreates the beautiful login screen design with:
- **Gradient backgrounds** - Pink to gray gradient for main background
- **Colorful headers** - Different gradient combinations for each screen
- **Clean forms** - Underlined input fields matching the design
- **Modern buttons** - Gradient buttons with smooth animations
- **Responsive layout** - Adapts to different screen sizes

## Error Handling

The app includes comprehensive error handling:
- Network connectivity issues
- Invalid email/password combinations
- Firebase authentication errors
- Form validation errors

## Security Features

- Password visibility toggle
- Form validation (email format, password length)
- Firebase security rules (configure in Firebase Console)
- Secure password reset via email

## Customization

### Colors
Update the color scheme in `main.dart` and individual screen files to match your brand:

```dart
colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B5CF6)),
```

### Firebase Rules
Configure Firestore security rules in your Firebase console for additional security.

### Styling
Modify the gradient colors and styling in each screen file to customize the appearance.

## Testing

Run tests with:
```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Troubleshooting

1. **Firebase connection issues**: Ensure your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly configured
2. **Build errors**: Run `flutter clean` and `flutter pub get`
3. **Authentication not working**: Check Firebase Authentication is enabled in your Firebase console

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions, please open an issue on GitHub.
