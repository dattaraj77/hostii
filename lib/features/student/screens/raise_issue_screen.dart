import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  void createAnIssue() {
    if (_formKey.currentState!.validate() && selectedIssue != null) {
      // Mock issue creation action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Issue created successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
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
