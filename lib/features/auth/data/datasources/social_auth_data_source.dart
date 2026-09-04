import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/social_provider.dart';
import '../models/social_auth_model.dart';

abstract class SocialAuthDataSource {
  /// Opens the native platform modal and returns the secure token
  Future<SocialAuthModel> authenticate(SocialProvider provider);

  /// Clears active SDK sessions
  Future<void> logout();
}

class SocialAuthDataSourceImpl implements SocialAuthDataSource {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<SocialAuthModel> authenticate(SocialProvider provider) async {
    switch (provider) {
      case SocialProvider.google:
        return await _authenticateGoogle();
      case SocialProvider.apple:
        return await _authenticateApple();
      case SocialProvider.facebook:
        return await _authenticateFacebook();
    }
  }

  Future<SocialAuthModel> _authenticateGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // 🎯 Throws specific exception if user cancels
    if (googleUser == null) throw UserCancelledException();

    // Extracts the native Google Authentication container
    final GoogleSignInAuthentication auth = await googleUser.authentication;

    if (auth.idToken == null) {
      throw Exception('Failed to retrieve Google ID token.');
    }

    return SocialAuthModel(
      token: auth.idToken!,
      firstName: googleUser.displayName?.split(' ').first,
      lastName: googleUser.displayName?.split(' ').skip(1).join(' '),
    );
  }

  Future<SocialAuthModel> _authenticateApple() async {
    try {
      // Returns the AuthorizationCredentialAppleID container
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      if (credential.identityToken == null) {
        throw Exception('Failed to retrieve Apple Identity token.');
      }

      return SocialAuthModel(
        // 🚀 FIXED: identityToken is already a String. No conversion needed.
        token: credential.identityToken!,
        firstName: credential.givenName,
        lastName: credential.familyName,
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw UserCancelledException();
      }
      rethrow;
    }
  }

  Future<SocialAuthModel> _authenticateFacebook() async {
    // Request limited tracking for iOS compliance
    final LoginResult result = await FacebookAuth.instance.login(
      loginTracking: LoginTracking.limited,
      permissions: ['email', 'public_profile'],
    );

    if (result.status == LoginStatus.cancelled) {
      throw UserCancelledException();
    }
    if (result.status != LoginStatus.success) {
      throw Exception('Facebook sign-in failed.');
    }

    final tokenInfo = result.accessToken;

    if (tokenInfo != null) {
      // Check if we received a Limited Login Token (iOS without App Tracking)
      if (tokenInfo.type == AccessTokenType.limited) {
        // In Limited Login, we CANNOT call getUserData().
        return SocialAuthModel(
          token: tokenInfo.tokenString,
          // Since we can't call the Graph API, we use a fallback or
          // you would need to manually decode the tokenString (which is a JWT) to get the name.
          firstName: 'Facebook',
          lastName: 'User',
        );
      }
      // Standard Login Token (Android, or iOS with App Tracking Enabled)
      else if (tokenInfo.type == AccessTokenType.classic) {
        final userData = await FacebookAuth.instance.getUserData();
        return SocialAuthModel(
          token: tokenInfo.tokenString,
          firstName: userData['first_name'],
          lastName: userData['last_name'],
        );
      }
    }

    throw Exception('No valid token returned from Facebook.');
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
  }
}
