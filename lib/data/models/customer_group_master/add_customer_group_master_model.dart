class AddCustomerGroupMasterModel {
  String? custGroupName;
  String? cratedUserCode;
  String? updatedUserCode;
  int? activeStatus;

  AddCustomerGroupMasterModel(
      {this.custGroupName,
      this.cratedUserCode,
      this.updatedUserCode,
      this.activeStatus});

  AddCustomerGroupMasterModel.fromJson(Map<String, dynamic> json) {
    custGroupName = json['CustGroupName'];
    cratedUserCode = json['CratedUserCode'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustGroupName'] = this.custGroupName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
