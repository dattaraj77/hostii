import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/models/room_change_model.dart';

class RoomChangeRequestScreen extends StatefulWidget {
  const RoomChangeRequestScreen({super.key});

  @override
  State<RoomChangeRequestScreen> createState() =>
      _RoomChangeRequestScreenState();
}

class _RoomChangeRequestScreenState extends State<RoomChangeRequestScreen> {
  RoomChangeModel? roomModel;

  Future<void> fetchRequests() async {
    // Mock data
    roomModel = RoomChangeModel(
      status: 'success',
      statusCode: 200,
      result: [
        Result(
          status: 'pending',
          roomChangeRequestId: 1,
          currentRoomNumber: 101,
          toChangeRoomNumber: 102,
          currentBlock: 'A',
          toChangeBlock: 'B',
          changeReason: 'Need more space',
          studentEmailId: 'student@example.com',
          studentDetails: StudentDetails(
            userName: 'student1',
            emailId: 'student@example.com',
            roomNumber: 101,
            firstName: 'Student',
            lastName: 'One',
            phoneNumber: 1234567890,
            roleId: 2,
            password: null,
            jobRole: null,
            block: 'A',
          ),
        ),
      ],
      error: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Room change requests'),
      body: FutureBuilder(
        future: fetchRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Result> room = roomModel!.result;
            return roomModel == null
                ? const Center(
                    child: Text(
                      "No change room requests found",
                    ),
                  )
                : ListView.builder(
                    itemCount: room.length,
                    itemBuilder: (context, index) {
                      final request = room[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RoomCard(request: request),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Result request;

  const RoomCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(),
      ),
      child: Column(
        children: [
          heightSpacer(20),
          Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [
                  const Color(0xFF2E8B57).withOpacity(0.5),
                  const Color(0x002E8B57),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    heightSpacer(20),
                    Icon(
                      Icons.account_circle,
                      size: 70.sp,
                      color: const Color(0xFF2E8B57),
                    ),
                    heightSpacer(10),
                    Text(
                      '${request.studentDetails.firstName} ${request.studentDetails.lastName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    heightSpacer(20),
                  ],
                ),
                widthSpacer(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(10.0),
                    Text(
                      'Username: ${request.studentDetails.firstName}',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Current Room: ${request.currentRoomNumber}'),
                    heightSpacer(8.0),
                    Text('Current Block: ${request.currentBlock}'),
                    heightSpacer(8.0),
                    Text('To Change Room: ${request.toChangeRoomNumber}'),
                    heightSpacer(8.0),
                    Text('To Change Block: ${request.toChangeBlock}'),
                    heightSpacer(8.0),
                    Text('Reason: ${request.changeReason}'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 40.h,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Mock action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request Rejected'),
                        ),
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFED6A77),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 8,
                            offset: Offset(1, 3),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reject',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                widthSpacer(32),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Mock action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request Approved'),
                        ),
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2ECC71),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 8,
                            offset: Offset(1, 3),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Approve',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
