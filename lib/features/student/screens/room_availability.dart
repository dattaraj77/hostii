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
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomAvailabilityScreen extends StatelessWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Room Availabilities'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No rooms available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var room = snapshot.data!.docs[index];
              return RoomCard(room: room);
            },
          );
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final QueryDocumentSnapshot room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(
                AppConstants.bed,
                height: 70.h,
                width: 70.w,
              ),
              Text(
                'Room no. - ${room['number']}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          widthSpacer(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block ${room['block']}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                'Capacity: ${room['capacity']}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                'Current Occupancy: ${room['currentOccupancy']}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14.sp,
                ),
              ),
              heightSpacer(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: room['currentOccupancy'] < room['capacity']
                      ? const Color(0xFF2ECC71)
                      : const Color(0xFFE74C3C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: room['currentOccupancy'] < room['capacity']
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeRoomScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : Text(
                        'Unavailable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
