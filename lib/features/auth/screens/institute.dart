import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/features/auth/screens/1.dart'; // Import your selection screen

class InstituteSelectionScreen extends StatelessWidget {
  const InstituteSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Institute',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            InstituteButton(
              instituteName: 'GEC',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(),
                  ),
                );
              },
            ),
            InstituteButton(
              instituteName: 'PCCE',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(),
                  ),
                );
              },
            ),
            InstituteButton(
              instituteName: 'DBCE',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(),
                  ),
                );
              },
            ),
            InstituteButton(
              instituteName: 'RIT',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InstituteButton extends StatelessWidget {
  final String instituteName;
  final VoidCallback onTap;

  const InstituteButton({
    required this.instituteName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Icon(Icons.school, size: 24.sp),
              SizedBox(width: 10.w),
              Text(
                instituteName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
