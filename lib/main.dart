import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/features/auth/screens/institute.dart';
// Import the new screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Screen Responsiveness
      useInheritedMediaQuery: true,
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HOSTII',
          home: InstituteSelectionScreen(), // Set as initial screen
        );
      },
    );
  }
}
