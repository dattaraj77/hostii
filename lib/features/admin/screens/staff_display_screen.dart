import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';

class StaffDisplayScreen extends StatelessWidget {
  const StaffDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for staff
    final List<Map<String, String>> staff = [
      {'name': 'John Doe', 'position': 'Manager', 'email': 'john@example.com'},
      {
        'name': 'Jane Smith',
        'position': 'Assistant',
        'email': 'jane@example.com'
      },
      {
        'name': 'Bob Johnson',
        'position': 'Supervisor',
        'email': 'bob@example.com'
      },
    ];

    return Scaffold(
      appBar: buildAppBar(context, 'Staff Members'),
      body: ListView.builder(
        itemCount: staff.length,
        itemBuilder: (context, index) {
          var member = staff[index];
          return StaffCard(member: member);
        },
      ),
    );
  }
}

class StaffCard extends StatelessWidget {
  final Map<String, String> member;

  const StaffCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member['name'] ?? '',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            heightSpacer(5),
            Text('Position: ${member['position']}'),
            heightSpacer(5),
            Text('Email: ${member['email']}'),
          ],
        ),
      ),
    );
  }
}
