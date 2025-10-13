class UserMasterListModel {
  bool? status;
  String? message;
  List<UserInfo>? info;

  UserMasterListModel({this.status, this.message, this.info});

  UserMasterListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // info = json["user"] == null ? null : UserInfo.fromJson(json["user"]);
    if (json['info'] != null) {
      info = <UserInfo>[];
      json['info'].forEach((v) {
        info!.add(new UserInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  dynamic userCode;
  String? userId;
  String? userName;
  String? userPassword;
  dynamic userType;
  dynamic activeStatus;
  String? userCreateDate;
  String? userLoginDate;

  UserInfo(
      {this.userCode,
      this.userId,
      this.userName,
      this.userPassword,
      this.userType,
      this.activeStatus,
      this.userCreateDate,
      this.userLoginDate
      });

  UserInfo.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    userId = json['UserId'];
    userName = json['UserName'];
    // userPassword = json['UserPassword'];
    userType = json['UserType'];
    activeStatus = json['ActiveStatus'];
    userCreateDate = json['UserCreateDate'];
    userLoginDate = json['UserLoginDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserCode'] = this.userCode;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['UserPassword'] = this.userPassword;
    data['UserType'] = this.userType;
    data['ActiveStatus'] = this.activeStatus;
    data['UserCreateDate'] = this.userCreateDate;
    data['UserLoginDate'] = this.userLoginDate;
    return data;
  }
}



// import 'dart:convert';

// UserMasterListModel userMasterListModelFromJson(String str) => UserMasterListModel.fromJson(json.decode(str));

// String userMasterListModelToJson(UserMasterListModel data) => json.encode(data.toJson());

// class UserMasterListModel {
//     bool? status;
//     String? message;
//     String? token;
//     UserInfo? info;

//     UserMasterListModel({
//         this.status,
//         this.message,
//         this.token,
//         this.info,
//     });

//     factory UserMasterListModel.fromJson(Map<String, dynamic> json) => UserMasterListModel(
//         status: json["status"],
//         message: json["message"],
//         token: json["token"],
//         info: json["user"] == null ? null : UserInfo.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "token": token,
//         "user": info?.toJson(),
//     };
// }

// class UserInfo {
//     int? userCode;
//     String? userId;
//     String? userName;
//     int? userType;

//     UserInfo({
//         this.userCode,
//         this.userId,
//         this.userName,
//         this.userType,
//     });

//     factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
//         userCode: json["UserCode"],
//         userId: json["UserId"],
//         userName: json["UserName"],
//         userType: json["UserType"],
//     );

//     Map<String, dynamic> toJson() => {
//         "UserCode": userCode,
//         "UserId": userId,
//         "UserName": userName,
//         "UserType": userType,
//     };
// }
