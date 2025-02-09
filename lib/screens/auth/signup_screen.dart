import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify/components/custom_button.dart';
import 'package:learnify/components/custom_passwordfield.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/components/custom_textfield.dart';
import 'package:learnify/providers/signup_provider.dart';
import 'package:learnify/screens/auth/signin_screen.dart';
import 'package:learnify/utils/custom_navigator.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const RalewayText(
          text: "Sign Up",
          color: Colors.black,
          fWaight: FontWeight.bold,
          fontSize: 25,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            CustomNavigator.goto(context, const SignInPage());
          },
        ),
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
                controller: signupProvider.emailController,
              ),
              const SizedBox(height: 16),
              CustomPassword(
                labelName: "Enter Password",
                pIcon: Icons.lock,
                errorMsg: "Enter User password",
                isPassword: true,
                controller: signupProvider.passwordController,
              ),
              const SizedBox(height: 16),
              // Terms and Conditions
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "By Signing up, you agree to our ",
                    style: GoogleFonts.raleway(
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms, Privacy \nPolicy",
                        style: GoogleFonts.raleway(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: " and ",
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Cookie Use.",
                        style: GoogleFonts.raleway(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              CustomButton(
                buttonName: "Create Account",
                fSize: 16,
                size: size,
                onTap: () {
                  signupProvider.registerUser(context);
                },
              ),
              const SizedBox(height: 10),
              // Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RalewayText(
                    text: "Already have an account? ",
                    fWaight: FontWeight.bold,
                    fontSize: 16,
                    textAlign: TextAlign.start,
                  ),
                  TextButton(
                    onPressed: () {
                      CustomNavigator.goto(context, const SignInPage());
                    },
                    child: const RalewayText(
                      text: "Sign In",
                      color: Colors.teal,
                      fWaight: FontWeight.bold,
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
