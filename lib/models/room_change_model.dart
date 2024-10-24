import 'dart:convert';

class RoomChangeModel {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  RoomChangeModel({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory RoomChangeModel.fromRawJson(String str) =>
      RoomChangeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomChangeModel.fromJson(Map<String, dynamic> json) =>
      RoomChangeModel(
        status: json["status"],
        statusCode: json["statusCode"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "error": error,
      };
}

class Result {
  final String status;
  final int roomChangeRequestId;
  final int currentRoomNumber;
  final int toChangeRoomNumber;
  final String currentBlock;
  final String toChangeBlock;
  final String changeReason;
  final StudentDetails studentDetails;
  final String studentEmailId;

  Result({
    required this.status,
    required this.roomChangeRequestId,
    required this.currentRoomNumber,
    required this.toChangeRoomNumber,
    required this.currentBlock,
    required this.toChangeBlock,
    required this.changeReason,
    required this.studentDetails,
    required this.studentEmailId,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        roomChangeRequestId: json["roomChangeRequestId"],
        currentRoomNumber: json["currentRoomNumber"],
        toChangeRoomNumber: json["toChangeRoomNumber"],
        currentBlock: json["currentBlock"],
        toChangeBlock: json["toChangeBlock"],
        changeReason: json["changeReason"],
        studentDetails: StudentDetails.fromJson(json["studentDetails"]),
        studentEmailId: json["studentEmailId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "roomChangeRequestId": roomChangeRequestId,
        "currentRoomNumber": currentRoomNumber,
        "toChangeRoomNumber": toChangeRoomNumber,
        "currentBlock": currentBlock,
        "toChangeBlock": toChangeBlock,
        "changeReason": changeReason,
        "studentDetails": studentDetails.toJson(),
        "studentEmailId": studentEmailId,
      };
}

class StudentDetails {
  String userName;
  String emailId;
  dynamic password;
  int roleId;
  String firstName;
  String lastName;
  int phoneNumber;
  dynamic jobRole;
  dynamic roomNumber;
  dynamic block;

  StudentDetails({
    required this.userName,
    required this.emailId,
    required this.password,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.jobRole,
    required this.roomNumber,
    required this.block,
  });

  factory StudentDetails.fromRawJson(String str) =>
      StudentDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        userName: json["userName"],
        emailId: json["emailId"],
        password: json["password"],
        roleId: json["roleId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        jobRole: json["jobRole"],
        roomNumber: json["roomNumber"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "emailId": emailId,
        "password": password,
        "roleId": roleId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "jobRole": jobRole,
        "roomNumber": roomNumber,
        "block": block,
      };
}
