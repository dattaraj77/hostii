// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:goku/api_services/api_utils.dart';
// import 'package:goku/features/home/screens/home_screen.dart';
// import 'package:goku/features/auth/screens/login_screen.dart';
// import 'package:goku/api_services/api_urls.dart' as urls;

// import 'package:goku/theme/colors.dart';

// class ApiCall {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final urls.ApiUrls apiUrls = urls.ApiUrls();

//   Future<void> handleLogin(
//     BuildContext context,
//     String email,
//     String password,
//   ) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Fetch user data from Firestore
//       final userDoc = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();
//       final userData = userDoc.data();

//       // Update ApiUrls with user data
//       urls.ApiUrls.email = userData!['emailId'];
//       urls.ApiUrls.phoneNumber = userData['phoneNumber'].toString();
//       urls.ApiUrls.roomNumber = userData['roomNumber'].toString();
//       urls.ApiUrls.username = userData['userName'];
//       urls.ApiUrls.blockNumber = userData['block'];
//       urls.ApiUrls.firstName = userData['firstName'];
//       urls.ApiUrls.lastName = userData['lastName'];
//       urls.ApiUrls.roleId = userData['roleId'];

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = 'An error occurred. Please try again.';
//       if (e.code == 'user-not-found') {
//         errorMessage = 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         errorMessage = 'Wrong password provided for that user.';
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           backgroundColor: AppColors.kGreenColor,
//           content: Text(errorMessage),
//         ),
//       );
//     }
//   }

//   Future<String?> registerStudent(
//     String username,
//     String firstName,
//     String lastName,
//     String password,
//     String email,
//     String phoneNumber,
//     String block,
//     String roomNumber,
//     BuildContext context,
//   ) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         "userName": username,
//         "emailId": email,
//         "roleId": 2,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phoneNumber": phoneNumber,
//         "roomNumber": roomNumber,
//         "block": block
//       });

//       ApiUtils.showSucessSnackBar(context, "Student created successfully");
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         ApiUtils.showErrorSnackBar(
//             context, 'The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         ApiUtils.showErrorSnackBar(
//             context, 'The account already exists for that email.');
//       }
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//     return null;
//   }

//   Future<void> createStaff(
//     BuildContext context,
//     String username,
//     String email,
//     String password,
//     String firstName,
//     String lastName,
//     String phoneNumber,
//   ) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       await _firestore.collection('staff').doc(userCredential.user!.uid).set({
//         "userName": username,
//         "emailId": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "phoneNumber": phoneNumber,
//         "roleId": 2, // Assuming 2 is the role ID for staff
//         "createdAt": FieldValue.serverTimestamp(),
//       });

//       ApiUtils.showSucessSnackBar(context, 'Staff created successfully');
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//   }

//   Future<String?> roomChangeRequest(
//     String changeRoomNumber,
//     String changeBlockNumber,
//     String reason,
//     BuildContext context,
//   ) async {
//     try {
//       await _firestore.collection('roomChangeRequests').add({
//         "currentRoomNumber": urls.ApiUrls.roomNumber ?? "",
//         "toChangeRoomNumber": changeRoomNumber,
//         "currentBlock": urls.ApiUrls.blockNumber ?? "",
//         "toChangeBlock": changeBlockNumber,
//         "changeReason": reason,
//         "studentEmailId": urls.ApiUrls.email ?? "",
//         "status": "PENDING"
//       });

//       ApiUtils.showSucessSnackBar(
//           context, 'Room change request submitted successfully');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       );
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//     return null;
//   }

//   Future<void> updateProfile(
//     BuildContext context,
//     String username,
//     String firstName,
//     String lastName,
//     String phoneNumber,
//   ) async {
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).update({
//           "userName": username,
//           "firstName": firstName,
//           "lastName": lastName,
//           "phoneNumber": phoneNumber,
//         });

//         ApiUtils.showSucessSnackBar(context, 'Profile Updated Successfully');
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomeScreen(),
//           ),
//         );
//       } else {
//         ApiUtils.showErrorSnackBar(context, 'User not logged in');
//       }
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//   }

//   Future<String?> createAnIssue(
//     String roomNumber,
//     String block,
//     String issue,
//     String comment,
//     String email,
//     String phoneNumber,
//     BuildContext context,
//   ) async {
//     try {
//       await _firestore.collection('issues').add({
//         "roomNumber": roomNumber,
//         "block": block,
//         "issue": issue,
//         "studentComment": comment,
//         "studentEmailId": email,
//         "status": "OPEN",
//         "createdAt": FieldValue.serverTimestamp(),
//       });

//       ApiUtils.showSucessSnackBar(context, 'Issue created successfully');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       );
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//     return null;
//   }

//   Future<void> closeAnIssue(
//     String issueId,
//     String status,
//     BuildContext context,
//   ) async {
//     try {
//       await _firestore.collection('issues').doc(issueId).update({
//         "status": status,
//         "updatedAt": FieldValue.serverTimestamp(),
//       });

//       ApiUtils.showSucessSnackBar(context, 'Issue closed successfully');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       );
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//   }

//   Future<void> approveOrRejectRequest(
//     String requestId,
//     String adminComment,
//     String action,
//     BuildContext context,
//   ) async {
//     try {
//       await _firestore.collection('roomChangeRequests').doc(requestId).update({
//         "approveOrReject": action,
//         "adminComment": adminComment,
//         "status": action,
//         "updatedAt": FieldValue.serverTimestamp(),
//       });

//       ApiUtils.showSucessSnackBar(context, 'Request $action successfully');
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(),
//         ),
//       );
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//   }

//   Future<void> deleteStaff(
//     BuildContext context,
//     String emailId,
//   ) async {
//     try {
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('staff')
//           .where('emailId', isEqualTo: emailId)
//           .limit(1)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         await _firestore
//             .collection('staff')
//             .doc(querySnapshot.docs.first.id)
//             .delete();

//         User? user = _auth.currentUser;
//         if (user != null && user.email == emailId) {
//           await user.delete();
//         }

//         ApiUtils.showSucessSnackBar(context, 'Staff deleted successfully');
//       } else {
//         ApiUtils.showErrorSnackBar(context, 'Staff not found');
//       }
//     } catch (e) {
//       ApiUtils.showErrorSnackBar(context, e.toString());
//     }
//   }
// }
