import 'package:flutter/material.dart';
import 'package:learnify/components/custom_button.dart';
import 'package:learnify/components/custom_passwordfield.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/components/custom_textfield.dart';
import 'package:learnify/providers/signin_provider.dart';
import 'package:learnify/screens/auth/signup_screen.dart';
import 'package:learnify/utils/custom_navigator.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final signinProvider = Provider.of<SigninProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const RalewayText(
          text: "Sign In",
          color: Colors.black,
          fWaight: FontWeight.bold,
          fontSize: 25,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                labelText: "Enter email",
                pIcon: Icons.email,
                errorMsg: "Enter email",
                controller: signinProvider.emailController,
              ),
              const SizedBox(height: 16),
              CustomPassword(
                labelName: "Enter Password",
                pIcon: Icons.lock,
                errorMsg: "Enter User password",
                isPassword: true,
                controller: signinProvider.passwordController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                buttonName: "Start Learning",
                fSize: 16,
                size: size,
                onTap: () {
                  signinProvider.signInUser(context);
                },
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: RalewayText(
                      text: "or",
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RalewayText(
                      text: "Don't have an account",
                      fWaight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        CustomNavigator.goto(context, const SignUpPage());
                      },
                      child: const RalewayText(
                        text: "Sign Up",
                        color: Colors.teal,
                        fWaight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
