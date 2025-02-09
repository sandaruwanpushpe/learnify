import 'package:flutter/material.dart';
import 'package:learnify/controllers/auth_controller.dart';
import 'package:learnify/utils/custom_error.dart';
import 'package:logger/logger.dart';

class SigninProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  //signInUser function
  Future<void> signInUser(BuildContext context) async {
    if (_emailController.text.isEmpty) {
      CustomErrorDialog.toast(context, "please input your email");
      Logger().e('please input your email');
    } else if (_passwordController.text.isEmpty) {
      CustomErrorDialog.toast(context, "please input your password");
      Logger().e("please input your password");
    } else {
      //call the signInToAccount function in AuthController class with parameters
      AuthController()
          .signInToAccount(context,
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        clearTextFields();
      });
    }
    notifyListeners();
  }

  void clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
    notifyListeners();
  }
}
