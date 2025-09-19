class AddUserMasterModel {
  String? userId;
  String? userName;
  String? userPassword;
  int? userType;
  int? activeStatus;

  AddUserMasterModel(
      {this.userId,
      this.userName,
      this.userPassword,
      this.userType,
      this.activeStatus});

  AddUserMasterModel.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    userName = json['UserName'];
    userPassword = json['UserPassword'];
    userType = json['UserType'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['UserPassword'] = this.userPassword;
    data['UserType'] = this.userType;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
