import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart'; // Import your login screen

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.r,
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  'images/hostii.png', // Replace with your logo asset
                  width: 200.w,
                  height: 200.h,
                ),
              ),
              SizedBox(height: 40.h),
              CustomButton(
                buttonText: "USER",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(userType: 'user'),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              CustomButton(
                buttonText: "ADMIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen(userType: 'admin'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback press;

  const CustomButton({
    required this.buttonText,
    required this.press,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.h),
        ),
        onPressed: press,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
