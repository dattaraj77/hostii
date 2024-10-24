import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/admin/screens/issue_details_screen.dart';
import 'package:goku/features/admin/screens/staff_display_screen.dart';
import 'package:goku/features/student/screens/hostel_fees.dart';
import 'package:goku/features/student/screens/profile_screen.dart';
import 'package:goku/features/admin/screens/room_change_requests_screen.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/theme/text_theme.dart';
import 'package:goku/widgets/category_card.dart';
import 'package:goku/features/student/screens/room_availability.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to different screens based on the selected index
    switch (index) {
      case 0:
        // Current screen
        break;
      case 1:
        break;
      case 2:
        Navigator.pushNamed(context, '/raise_issue');
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RoomChangeRequestScreen(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mock user data
    final userData = {
      'firstName': 'Admin',
      'office': 'W1',
      'block': 'A',
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
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
              child: const CircleAvatar(
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
                          '${userData['firstName']}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Office: ${userData['office']}'),
                        Text('Block: ${userData['block']}'),
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
                mainAxisSpacing: 10.h, // Add vertical spacing
                crossAxisSpacing: 10.w, // Add horizontal spacing
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
                    category: 'All\nIssues',
                    image: AppConstants.raiseIssue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StaffDisplayScreen(),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    category: 'Staff\nMembers',
                    image: AppConstants.staffMember,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StaffDisplayScreen(),
                        ),
                      );
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
                          builder: (context) => const HostelFee(
                            blockNumber: 'A1', // Dummy value
                            roomNumber: '101', // Dummy value
                            maintenanceCharge: '50', // Dummy value
                            parkingCharge: '20', // Dummy value
                            waterCharge: '10', // Dummy value
                            roomCharge: '200', // Dummy value
                            totalCharge: '280', // Dummy value
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryCard(
                    category: 'Change\nRequest',
                    image: AppConstants.roomChange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomChangeRequestScreen(),
                        ),
                      );
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

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}
