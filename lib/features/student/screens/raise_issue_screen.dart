import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';
import 'package:goku/features/auth/widgets/custom_button.dart';
import 'package:goku/features/auth/widgets/custom_text_field.dart';
import 'package:goku/theme/text_theme.dart';

class RaiseIssueScreen extends StatefulWidget {
  const RaiseIssueScreen({super.key});

  @override
  State<RaiseIssueScreen> createState() => _RaiseIssueScreenState();
}

class _RaiseIssueScreenState extends State<RaiseIssueScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController studentComment = TextEditingController();
  String? selectedIssue;
  List<String> issues = [
    'Bathroom',
    'Bedroom',
    'Water',
    'Furniture',
    'Kitchen'
  ];

  Future<void> createAnIssue() async {
    if (_formKey.currentState!.validate() && selectedIssue != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          final userData = userDoc.data() as Map<String, dynamic>;

          await FirebaseFirestore.instance.collection('issues').add({
            'userId': user.uid,
            'roomNumber': userData['roomNumber'],
            'block': userData['block'],
            'issue': selectedIssue,
            'studentComment': studentComment.text,
            'studentEmailId': user.email,
            'status': 'OPEN',
            'createdAt': FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Issue created successfully')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating issue: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Create Issue"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Issue you are facing?', style: AppTextTheme.kLabelStyle),
                DropdownButtonFormField<String>(
                  value: selectedIssue,
                  items: issues
                      .map((issue) =>
                          DropdownMenuItem(value: issue, child: Text(issue)))
                      .toList(),
                  onChanged: (value) => setState(() => selectedIssue = value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                heightSpacer(15),
                Text('Comment', style: AppTextTheme.kLabelStyle),
                CustomTextField(
                  controller: studentComment,
                  validator: (value) =>
                      value!.isEmpty ? 'Comment is required' : null,
                ),
                heightSpacer(40),
                CustomButton(
                  buttonText: "Submit",
                  press: createAnIssue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
