class CustomPlatformException implements Exception {
  final String code;
  CustomPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid';
      case 'operation-not-allowed':
        return 'The sign-in provider is diabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The firebase session cookie has expired. Please sign in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'unknown':
        return 'An unknown Firebase error occured. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'user-not-found':
        return 'Invalid login details. User not found';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      case 'email-already-exists':
        return 'The email address already exists. Please use a different email';
      case 'provider-already-linked':
        return 'The account is already linked with another provider';
      case 'invalid-credential':
        return 'The supplied credential is malformed or has expired';
      case 'captcha-check-failed':
        return 'The reCAPTCHA response is invalid. Please try again';
      case 'app-not-authorized':
        return 'The app is not authorized to use the Firebase Authentication with the provided API key';
      case 'ketchain-error':
        return 'A keychain error occured. Please check the keychain and try again';
      case 'invalid-app-credential':
        return 'The app credential is invalid. Please provide a valid app credential.';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed-in user.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'missing-iframe-start':
        return 'The email template is missing the iframe start tag.';
      case 'missing-iframe-end':
        return 'The email template is missing the iframe end tag.';
      case 'missing-iframe-src':
        return 'The email template is missing the iframe src attribute.';
      case 'auth-domain-config-required':
        return 'The suthDomain configuration is required for the action code verification link.';
      case 'missing-app-credential':
        return 'The app credential is missing. Please provide a valid app credential.';
      case 'web-storage-unsupported':
        return 'Web storage is not supported by the browser. Please try a different browser.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has benn deleted.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID.';
      case 'invalid-message-payload':
        return 'The email template verification message payload is invalid.';
      case 'invalid-sender':
        return 'The email template sender is invalid. Please verify the sendor\'s email.';
      case 'invalid-recipient-email':
        return 'The recipient email address is invalid. Please provide a valid recipient email.';
      case 'missing-action-code':
        return 'The action code is missing. Please provide a valid action code.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and aunthentication is required. Please sign in again.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new action code.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      default:
        return 'An unexpected Firebase error occurred. Please try again.';
    }
  }



}