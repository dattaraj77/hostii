import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goku/common/app_bar.dart';
import 'package:goku/common/spacing.dart';

class CreateStaffScreen extends StatefulWidget {
  const CreateStaffScreen({super.key});

  @override
  _CreateStaffScreenState createState() => _CreateStaffScreenState();
}

class _CreateStaffScreenState extends State<CreateStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Handle staff creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Staff member created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Create Staff'),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name', style: TextStyle(fontSize: 16.sp)),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              heightSpacer(15),
              Text('Position', style: TextStyle(fontSize: 16.sp)),
              TextFormField(
                controller: positionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a position';
                  }
                  return null;
                },
              ),
              heightSpacer(15),
              Text('Email', style: TextStyle(fontSize: 16.sp)),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              heightSpacer(30),
              Center(
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Create Staff'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
