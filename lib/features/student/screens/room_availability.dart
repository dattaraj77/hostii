import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/api_services/api_provider.dart';
import 'package:goku/api_services/api_utils.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/student/screens/change_room_screen.dart';
import 'package:goku/models/room_availability_model.dart';

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
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Number: ${room['number']}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            heightSpacer(5),
            Text('Block: ${room['block']}'),
            heightSpacer(5),
            Text('Capacity: ${room['capacity']}'),
            heightSpacer(5),
            Text('Current Occupancy: ${room['currentOccupancy']}'),
            heightSpacer(10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: room['currentOccupancy'] < room['capacity']
                    ? () {
                        // Handle room booking or details
                      }
                    : null,
                child: Text(
                  room['currentOccupancy'] < room['capacity']
                      ? 'Available'
                      : 'Unavailable',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
