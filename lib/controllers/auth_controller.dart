// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnify/providers/user_provider.dart';
import 'package:learnify/utils/custom_error.dart';
import 'package:learnify/utils/custom_success.dart';
import 'package:logger/logger.dart';

class AuthController {
  //create user account
  Future<void> createUserAccount(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    CustomSuccessDialog.show(context);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        UserProvider().checkAuthState(context);
        Logger().i("User created with UID: ${credential.user!.uid}");
      } else {
        CustomErrorDialog.toast(context, "User creation failed.");
        Logger().e("Credential user is null.");
      }
      CustomSuccessDialog.dismiss(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomErrorDialog.toast(context, "The password provided is too weak.");
        Logger().e('Weak password.');
      } else if (e.code == 'email-already-in-use') {
        CustomErrorDialog.toast(
            context, "The account already exists for that email.");
        Logger().e('Email already in use.');
      } else if (e.code == 'invalid-email') {
        CustomErrorDialog.toast(context, "Invalid email format.");
        Logger().e('Invalid email.');
      } else {
        CustomErrorDialog.toast(context, "An error occurred: ${e.message}");
        Logger().e(e.message);
      }
    } catch (e) {
      Logger().e("Unexpected error: $e");
      CustomErrorDialog.toast(context, "An unexpected error occurred.");
      CustomSuccessDialog.dismiss(context);
    } finally {
      CustomSuccessDialog.dismiss(context);
    }
  }

  //SignInToAccount function
  Future<void> signInToAccount(BuildContext context,
      {required String email, required String password}) async {
    try {
      CustomSuccessDialog.show(context);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserProvider().checkAuthState(context);
      CustomSuccessDialog.toast(context, "Welcome back!");
      Logger().i(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomErrorDialog.toast(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        CustomErrorDialog.toast(
            context, "Wrong password provided for that user.");
      } else if (e.code == 'weak-password') {
        CustomErrorDialog.toast(context, "The password provided is too weak.");
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomErrorDialog.toast(
            context, "The account already exists for that email.");
        Logger().e('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        CustomErrorDialog.toast(context, "Invalid Email");
        Logger().e('Invalid Email');
      } else if (e.code == 'operation-not-allowed') {
        CustomErrorDialog.toast(context, "Operation not allowed.");
        Logger().e('Operation not allowed.');
      }
    } catch (e) {
      CustomErrorDialog.toast(context, "Invalid details");
      Logger().e(e);
    } finally {
      CustomSuccessDialog.dismiss(context);
    }
  }

  //signout user
  Future<void> signOutUser(BuildContext context) async {
    CustomSuccessDialog.show(context);

    try {
      await FirebaseAuth.instance.signOut();
      await UserProvider().checkAuthState(context);
    } catch (e) {
      CustomSuccessDialog.dismiss(context);
      Logger().d('failed to disconnect on signout');
    }
    CustomSuccessDialog.dismiss(context);
    CustomSuccessDialog.toast(context, "Sign out successfully!");
    
  }
}
