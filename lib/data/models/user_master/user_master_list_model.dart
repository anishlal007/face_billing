class UserMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  UserMasterListModel({this.status, this.message, this.info});

  UserMasterListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(new Info.fromJson(v));
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

class Info {
  int? userCode;
  String? userId;
  String? userName;
  String? userPassword;
  int? userType;
  int? activeStatus;
  String? userCreateDate;
  String? userLoginDate;

  Info(
      {this.userCode,
      this.userId,
      this.userName,
      this.userPassword,
      this.userType,
      this.activeStatus,
      this.userCreateDate,
      this.userLoginDate});

  Info.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    userId = json['UserId'];
    userName = json['UserName'];
    userPassword = json['UserPassword'];
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
