class AddGenericsMasterModel {
  String? genericName;
  String? createdUserCode;
  int? activeStatus;

  AddGenericsMasterModel(
      {this.genericName, this.createdUserCode, this.activeStatus});

  AddGenericsMasterModel.fromJson(Map<String, dynamic> json) {
    genericName = json['GenericName'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GenericName'] = this.genericName;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
