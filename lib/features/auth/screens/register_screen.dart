import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/auth/widgets/custom_button.dart';
import 'package:goku/features/auth/widgets/custom_text_field.dart';
import 'package:goku/theme/text_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController block = TextEditingController();
  final TextEditingController roomNumber = TextEditingController();

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Mock registration action
      if (email.text == "test@example.com") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
        Navigator.pop(context); // Go back to login screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Registration"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('First Name', style: AppTextTheme.kLabelStyle),
                          CustomTextField(
                            controller: firstName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    widthSpacer(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Name', style: AppTextTheme.kLabelStyle),
                          CustomTextField(
                            controller: lastName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightSpacer(15),
                Text('Email', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email address';
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
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text('Confirm Password', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: confirmPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value != password.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text('Phone Number', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: phoneNumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text('Block', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: block,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Block is required';
                    }
                    return null;
                  },
                ),
                heightSpacer(15),
                Text('Room Number', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: roomNumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Room number is required';
                    }
                    return null;
                  },
                ),
                heightSpacer(30),
                CustomButton(
                  buttonText: "Register",
                  press: registerUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
