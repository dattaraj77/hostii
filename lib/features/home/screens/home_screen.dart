import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/student/screens/profile_screen.dart';
import 'package:goku/features/admin/screens/room_change_requests_screen.dart';
import 'package:goku/theme/colors.dart';
import 'package:goku/theme/text_theme.dart';
import 'package:goku/widgets/category_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> _userStream;
  List<ChartData>? _chartData;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots();
    }
    _fetchChartData();
  }

  Future<void> _fetchChartData() async {
    try {
      final chartSnapshot = await FirebaseFirestore.instance
          .collection('roomChangeRequests')
          .get();
      final totalRequests = chartSnapshot.docs.length;
      final approvedRequests =
          chartSnapshot.docs.where((doc) => doc['status'] == 'approved').length;
      final rejectedRequests =
          chartSnapshot.docs.where((doc) => doc['status'] == 'rejected').length;
      final pendingRequests =
          totalRequests - approvedRequests - rejectedRequests;

      setState(() {
        _chartData = [
          ChartData('Approved', approvedRequests.toDouble(), Colors.green),
          ChartData('Rejected', rejectedRequests.toDouble(), Colors.red),
          ChartData('Pending', pendingRequests.toDouble(), Colors.grey),
        ];
      });
    } catch (e) {
      print('Error fetching chart data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: SvgPicture.asset(
                AppConstants.profile,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No user data found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),
              child: Column(
                children: [
                  heightSpacer(20),
                  Container(
                    height: 140.h,
                    width: double.maxFinite,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Color(0xFF007B3B)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          heightSpacer(5),
                          Text(
                            userData['firstName'] ?? 'User',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          heightSpacer(10),
                          Text(
                            'Room Number: ${userData['roomNumber'] ?? 'N/A'}',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightSpacer(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryCard(
                        category: 'Room\nAvailability',
                        image: AppConstants.roomAvailability,
                        onTap: () {
                          Navigator.pushNamed(context, '/room_availability');
                        },
                      ),
                      CategoryCard(
                        category: 'Raise an\nIssue',
                        image: AppConstants.raiseIssue,
                        onTap: () {
                          Navigator.pushNamed(context, '/raise_issue');
                        },
                      ),
                      CategoryCard(
                        category: 'Change\nRequests',
                        image: AppConstants.roomChange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RoomChangeRequestScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  heightSpacer(20),
                  if (_chartData != null)
                    SfCircularChart(
                      title: ChartTitle(text: 'Room Change Requests'),
                      legend: Legend(isVisible: true),
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: _chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.label,
                          yValueMapper: (ChartData data, _) => data.value,
                          dataLabelMapper: (ChartData data, _) =>
                              '${data.label}\n${data.value.toInt()}',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
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
