import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/auth/screens/register_screen.dart';
import 'package:goku/features/auth/widgets/custom_button.dart';
import 'package:goku/features/auth/widgets/custom_text_field.dart';
import 'package:goku/features/home/screens/home_screen.dart';
import 'package:goku/features/home/screens/user_homescreen.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/theme/text_theme.dart';

class LoginScreen extends StatelessWidget {
  final String userType;

  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(child: LoginBody(userType: userType)),
    );
  }
}

class LoginBody extends StatefulWidget {
  final String userType;

  const LoginBody({
    super.key,
    required this.userType,
  });

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Mock login action
      if (email.text == "t@mail.com" && password.text == "p") {
        // Navigate to the appropriate home screen
        if (widget.userType == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserHomeScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your image here
              Center(
                child: Image.asset(
                  'images/hostii.png', // Replace with your image path
                  height: 100.h, // Adjust the height as needed
                ),
              ),
              heightSpacer(20), // Add some space after the image
              Text('Email', style: AppTextTheme.kLabelStyle),
              CustomTextField(
                controller: email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              heightSpacer(15),
              Text('Password', style: AppTextTheme.kLabelStyle),
              CustomTextField(
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              heightSpacer(40),
              CustomButton(
                buttonText: "Login",
                press: handleLogin,
              ),
              heightSpacer(20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.kGreenColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
