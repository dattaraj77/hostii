// import 'dart:convert';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// class UserResponse {
//   final String emailId;
//   final String phoneNumber;
//   final String roomNumber;
//   final String userName;
//   final String block;
//   final String firstName;
//   final String lastName;
//   final int roleId;

//   UserResponse({
//     required this.emailId,
//     required this.phoneNumber,
//     required this.roomNumber,
//     required this.userName,
//     required this.block,
//     required this.firstName,
//     required this.lastName,
//     required this.roleId,
//   });

//   factory UserResponse.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return UserResponse(
//       emailId: data['emailId'] ?? '',
//       phoneNumber: data['phoneNumber']?.toString() ?? '',
//       roomNumber: data['roomNumber']?.toString() ?? '',
//       userName: data['userName'] ?? '',
//       block: data['block'] ?? '',
//       firstName: data['firstName'] ?? '',
//       lastName: data['lastName'] ?? '',
//       roleId: data['roleId'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       'emailId': emailId,
//       'phoneNumber': phoneNumber,
//       'roomNumber': roomNumber,
//       'userName': userName,
//       'block': block,
//       'firstName': firstName,
//       'lastName': lastName,
//       'roleId': roleId,
//     };
//   }
// }

// class Result {
//   String userName;
//   String? emailId;
//   RoleId? roleId;
//   String? firstName;
//   String? lastName;
//   int? phoneNumber;
//   int? roomNumber;
//   String? block;

//   Result({
//     required this.userName,
//     required this.emailId,
//     required this.roleId,
//     required this.firstName,
//     required this.lastName,
//     required this.phoneNumber,
//     required this.roomNumber,
//     required this.block,
//   });

//   factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         userName: json["userName"],
//         emailId: json["emailId"],
//         roleId: RoleId.fromJson(json["roleId"]),
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phoneNumber: json["phoneNumber"],
//         roomNumber: json["roomNumber"],
//         block: json["block"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userName": userName,
//         "emailId": emailId,
//         "roleId": roleId!.toJson(),
//         "firstName": firstName,
//         "lastName": lastName,
//         "phoneNumber": phoneNumber,
//         "roomNumber": roomNumber,
//         "block": block,
//       };
// }

// class RoleId {
//   int roleId;
//   String role;

//   RoleId({
//     required this.roleId,
//     required this.role,
//   });

//   factory RoleId.fromRawJson(String str) => RoleId.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory RoleId.fromJson(Map<String, dynamic> json) => RoleId(
//         roleId: json["roleId"],
//         role: json["role"],
//       );

//   Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "role": role,
//       };
// }
