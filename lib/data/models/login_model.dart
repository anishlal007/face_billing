class LoginModel {
  bool? status;
  String? message;
  String? token;
  User? user;

  LoginModel({this.status, this.message, this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? userCode;
  String? userId;
  String? userName;
  String? userType;

  User({this.userCode, this.userId, this.userName, this.userType});

  User.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    userId = json['UserId'];
    userName = json['UserName'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserCode'] = this.userCode;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['UserType'] = this.userType;
    return data;
  }
}
