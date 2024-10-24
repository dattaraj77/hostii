import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/auth/screens/login_screen.dart';
import 'package:goku/features/auth/widgets/custom_button.dart';
import 'package:goku/features/auth/widgets/custom_text_field.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/theme/text_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  Map<String, dynamic> userData = {
    'userName': 'john_doe',
    'phoneNumber': '1234567890',
    'firstName': 'John',
    'lastName': 'Doe',
    'roomNumber': '101',
    'block': 'A',
    'emailId': 'john.doe@example.com',
  };

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    // Mock user data loading
    setState(() {
      username.text = userData['userName'] ?? '';
      phoneNumber.text = userData['phoneNumber'] ?? '';
      firstName.text = userData['firstName'] ?? '';
      lastName.text = userData['lastName'] ?? '';
    });
  }

  void updateProfile() {
    // Mock profile update action
    setState(() {
      userData['userName'] = username.text;
      userData['firstName'] = firstName.text;
      userData['lastName'] = lastName.text;
      userData['phoneNumber'] = phoneNumber.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile Updated Successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kGreenColor,
        title: Text("Profile",
            style: AppTextTheme.kLabelStyle.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Mock logout action
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen(
                            userType: '',
                          )));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppConstants.profile,
                  height: 180.h, width: 180.w),
              heightSpacer(10),
              Text(
                '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}',
                style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              heightSpacer(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF2E8B57)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Room No - ${userData['roomNumber'] ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFF333333), fontSize: 17.sp),
                      ),
                    ),
                  ),
                  widthSpacer(30),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF2E8B57)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Block No - ${userData['block'] ?? ''}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFF333333), fontSize: 17.sp),
                      ),
                    ),
                  ),
                ],
              ),
              heightSpacer(20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  userData['emailId'] ?? '',
                  style: TextStyle(
                      color: AppColors.kSecondaryColor, fontSize: 17.sp),
                ),
              ),
              heightSpacer(20),
              CustomTextField(
                controller: username,
                inputHint: 'Username',
                prefixIcon: const Icon(Icons.person_2_outlined),
              ),
              heightSpacer(20),
              CustomTextField(
                controller: phoneNumber,
                inputHint: 'Phone Number',
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              heightSpacer(20),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          controller: firstName, inputHint: 'First Name')),
                  widthSpacer(20),
                  Expanded(
                      child: CustomTextField(
                          controller: lastName, inputHint: 'Last Name')),
                ],
              ),
              heightSpacer(40),
              CustomButton(
                press: updateProfile,
                buttonText: 'Save',
              )
            ],
          ),
        ),
      ),
    );
  }
}
