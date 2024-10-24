import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/models/issue_model.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  IssueModel? issueModel;

  Future<void> fetchIssues() async {
    // Mock data
    issueModel = IssueModel(
      status: 'success',
      statusCode: 200,
      result: [
        Result(
          issueId: 1,
          roomDetails: RoomDetails(
            roomNumber: 101,
            roomCapacity: 2,
            roomCurrentCapacity: 1,
            roomType: RoomType(roomId: 1, roomType: 'Single'),
            roomStatus: 'Available',
            blockId: BlockId(
              blockId: 1,
              block: 'A',
              blockName: 'Block A',
              blockOwner: 'Owner A',
            ),
          ),
          issue: 'Leaking faucet',
          studentComment: 'Needs urgent repair',
          studentEmailId: 'student@example.com',
          staffComment: null,
          studentDetails: StudentDetails(
            userName: 'student1',
            emailId: 'student@example.com',
            firstName: 'Student',
            lastName: 'One',
            phoneNumber: 1234567890,
            roleId: 2,
            password: null,
            jobRole: null,
          ),
        ),
        // Add more mock issues here if needed
      ],
      error: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Student Issues'),
      body: FutureBuilder(
        future: fetchIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Result> issues = issueModel!.result;
            return issueModel == null
                ? const Center(
                    child: Text(
                      "No Issues found",
                    ),
                  )
                : ListView.builder(
                    itemCount: issues.length,
                    itemBuilder: (context, index) {
                      final issue = issues[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    IssueDetailScreen(issue: issue),
                              ),
                            );
                          },
                          child: IssueCard(issue: issue),
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Result issue;

  const IssueCard({super.key, required this.issue});

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
                    Image.asset(
                      AppConstants.person,
                      height: 70.h,
                      width: 70.w,
                    ),
                    heightSpacer(10),
                    Text(
                      '${issue.studentDetails.firstName} ${issue.studentDetails.lastName}',
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
                      'Username: ${issue.studentDetails.firstName}',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Issue: ${issue.issue}'),
                    heightSpacer(8.0),
                    Text('Student Comment: ${issue.studentComment}'),
                    heightSpacer(8.0),
                    Text('Room Number: ${issue.roomDetails.roomNumber}'),
                    heightSpacer(8.0),
                    Text('Block: ${issue.roomDetails.blockId.blockName}'),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // Mock action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Issue Resolved'),
                      ),
                    );
                  },
                  child: Container(
                    width: 120.w,
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      color: Colors.blue,
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
                          'Resolve',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IssueDetailScreen extends StatelessWidget {
  final Result issue;

  const IssueDetailScreen({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Issue Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Issue: ${issue.issue}',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            heightSpacer(16),
            Text(
                'Student: ${issue.studentDetails.firstName} ${issue.studentDetails.lastName}'),
            Text('Email: ${issue.studentEmailId}'),
            Text('Room Number: ${issue.roomDetails.roomNumber}'),
            Text('Block: ${issue.roomDetails.blockId.blockName}'),
            heightSpacer(16),
            Text('Student Comment: ${issue.studentComment}'),
            heightSpacer(16),
            ElevatedButton(
              onPressed: () {
                // Implement resolve functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Issue Resolved')),
                );
                Navigator.pop(context);
              },
              child: Text('Resolve Issue'),
            ),
          ],
        ),
      ),
    );
  }
}
