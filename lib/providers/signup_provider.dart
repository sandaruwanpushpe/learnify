import 'package:flutter/material.dart';
import 'package:learnify/controllers/auth_controller.dart';
import 'package:learnify/utils/custom_error.dart';

class SignupProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  //User registration function
  Future<void> registerUser(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      CustomErrorDialog.toast(context, "please input your email!");
    } else if (_passwordController.text.isEmpty) {
      CustomErrorDialog.toast(context, "please input your password!");
    } else {
      //call the createUserAccount function in AuthController class with parameters
      AuthController()
          .createUserAccount(context,
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        clearTextFields();
      });
    }
  }

  void clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
    notifyListeners();
  }
}
