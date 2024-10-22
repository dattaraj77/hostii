import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/auth/widgets/custom_button.dart';
import 'package:goku/features/auth/widgets/custom_text_field.dart';
import 'package:goku/theme/text_theme.dart';

class ChangeRoomScreen extends StatefulWidget {
  const ChangeRoomScreen({super.key});

  @override
  State<ChangeRoomScreen> createState() => _ChangeRoomScreenState();
}

class _ChangeRoomScreenState extends State<ChangeRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reason = TextEditingController();
  String? selectedRoom;
  String? selectedBlock;
  List<String> rooms = [];
  List<String> blocks = [];

  @override
  void initState() {
    super.initState();
    fetchRoomsAndBlocks();
  }

  Future<void> fetchRoomsAndBlocks() async {
    // Fetch available rooms and blocks from Firestore
    final roomsSnapshot =
        await FirebaseFirestore.instance.collection('rooms').get();
    final blocksSnapshot =
        await FirebaseFirestore.instance.collection('blocks').get();

    setState(() {
      rooms = roomsSnapshot.docs.map((doc) => doc['number'] as String).toList();
      blocks = blocksSnapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  Future<void> roomChangeRequest() async {
    if (_formKey.currentState!.validate() &&
        selectedRoom != null &&
        selectedBlock != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('roomChangeRequests')
              .add({
            'userId': user.uid,
            'toChangeRoom': selectedRoom,
            'toChangeBlock': selectedBlock,
            'reason': reason.text,
            'status': 'pending',
            'createdAt': FieldValue.serverTimestamp(),
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Room change request submitted successfully')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting request: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Change Room"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Room', style: AppTextTheme.kLabelStyle),
                DropdownButtonFormField<String>(
                  value: selectedRoom,
                  items: rooms
                      .map((room) =>
                          DropdownMenuItem(value: room, child: Text(room)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedRoom = value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                heightSpacer(15),
                Text('Select Block', style: AppTextTheme.kLabelStyle),
                DropdownButtonFormField<String>(
                  value: selectedBlock,
                  items: blocks
                      .map((block) =>
                          DropdownMenuItem(value: block, child: Text(block)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedBlock = value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                heightSpacer(15),
                Text('Reason for change', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: reason,
                  validator: (value) =>
                      value!.isEmpty ? 'Reason is required' : null,
                ),
                heightSpacer(40),
                CustomButton(
                  press: roomChangeRequest,
                  buttonText: 'Submit',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
