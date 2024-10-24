import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/admin/screens/issue_details_screen.dart';
import 'package:goku/features/student/screens/profile_screen.dart';
import 'package:goku/features/student/screens/hostel_fees.dart';
import 'package:goku/features/student/screens/raise_issue_screen.dart';
import 'package:goku/features/student/screens/room_availability.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/theme/text_theme.dart';
import 'package:goku/widgets/category_card.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final userData = {
      'firstName': 'Goraksh Naik',
      'roomNumber': '201',
      'block': 'B',
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.kGreenColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: CircleAvatar(
                backgroundImage: AssetImage(AppConstants.profile),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.kGreenColor, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData['firstName'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Room no: ${userData['roomNumber'] ?? 'N/A'}'),
                        Text('Block no: ${userData['block'] ?? 'N/A'}'),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.create,
                          color: AppColors.kGreenColor),
                      onPressed: () {
                        Navigator.pushNamed(context, '/raise_issue');
                      },
                    ),
                  ],
                ),
              ),
              heightSpacer(20),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              heightSpacer(10),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                children: [
                  CategoryCard(
                    category: 'Room\nAvailability',
                    image: AppConstants.roomAvailability,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomAvailabilityScreen(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    category: '\n create Issues',
                    image: AppConstants.showAllIssues,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RaiseIssueScreen(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    category: 'Staff\nMembers',
                    image: AppConstants.showStaff,
                    onTap: () {
                      Navigator.pushNamed(context, '/show_staff');
                    },
                  ),
                  CategoryCard(
                    category: 'Create\nStaff',
                    image: AppConstants.createStaff,
                    onTap: () {
                      Navigator.pushNamed(context, '/create_staff');
                    },
                  ),
                  CategoryCard(
                    category: 'Hostel\nFee',
                    image: AppConstants.hostelFee,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HostelFee(
                            blockNumber: 'B',
                            roomNumber: '201',
                            maintenanceCharge: '50',
                            parkingCharge: '20',
                            waterCharge: '10',
                            roomCharge: '200',
                            totalCharge: '280',
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    category: 'Change\nRequest',
                    image: AppConstants.changeRequest,
                    onTap: () {
                      Navigator.pushNamed(context, '/change_request');
                    },
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
