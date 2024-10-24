import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/constants.dart';
import 'package:goku/common/spacing.dart';

class HostelFee extends StatelessWidget {
  final String blockNumber;
  final String roomNumber;
  final String maintenanceCharge;
  final String parkingCharge;
  final String waterCharge;
  final String roomCharge;
  final String totalCharge;

  const HostelFee({
    super.key,
    required this.blockNumber,
    required this.roomNumber,
    required this.maintenanceCharge,
    required this.parkingCharge,
    required this.waterCharge,
    required this.roomCharge,
    required this.totalCharge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Hostel Fees',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSpacer(20),
              SvgPicture.asset(
                AppConstants.hostel,
                height: 150.h,
              ),
              heightSpacer(30),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hostel Details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      heightSpacer(20),
                      _buildDetailRow('Block no.', blockNumber),
                      _buildDetailRow('Room no.', roomNumber),
                      heightSpacer(20),
                      Text(
                        'Payment Details',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      heightSpacer(20),
                      _buildDetailRow(
                          'Maintenance charge', '\$ $maintenanceCharge'),
                      _buildDetailRow('Parking charge', '\$ $parkingCharge'),
                      _buildDetailRow('Water charge', '\$ $waterCharge'),
                      _buildDetailRow('Room charge', '\$ $roomCharge'),
                      heightSpacer(20),
                      Divider(color: Colors.grey),
                      heightSpacer(20),
                      _buildDetailRow('Total Amount', '\$ $totalCharge'),
                      heightSpacer(30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 30.w),
                          ),
                          onPressed: () {
                            // Add payment logic here
                          },
                          child: Text(
                            'Proceed to Payment',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      heightSpacer(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label - ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
