import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/features/student/screens/change_room_screen.dart';

class RoomAvailabilityScreen extends StatelessWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for rooms
    final List<Map<String, dynamic>> rooms = [
      {'number': '101', 'block': 'A', 'capacity': 2, 'currentOccupancy': 1},
      {'number': '102', 'block': 'B', 'capacity': 3, 'currentOccupancy': 3},
      {'number': '103', 'block': 'C', 'capacity': 1, 'currentOccupancy': 0},
    ];

    return Scaffold(
      appBar: buildAppBar(context, 'Room Availabilities'),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          var room = rooms[index];
          return RoomCard(room: room);
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Map<String, dynamic> room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    bool isAvailable = room['currentOccupancy'] < room['capacity'];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AppConstants.bed,
            width: 50.w,
            height: 50.h,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room ${room['number']}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text('Block: ${room['block']}'),
                SizedBox(height: 4.h),
                Text('Capacity: ${room['capacity']}'),
                SizedBox(height: 4.h),
                Text('Occupied: ${room['currentOccupancy']}'),
              ],
            ),
          ),
          GestureDetector(
            onTap: isAvailable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeRoomScreen(),
                      ),
                    );
                  }
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isAvailable ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                isAvailable ? 'Available' : 'Full',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
