class AddSupplierGroupMasterModel {
  String? supGroupName;
  String? cratedUserCode;
  String? updatedUserCode;
  int? activeStatus;

  AddSupplierGroupMasterModel(
      {this.supGroupName,
      this.cratedUserCode,
      this.updatedUserCode,
      this.activeStatus});

  AddSupplierGroupMasterModel.fromJson(Map<String, dynamic> json) {
    supGroupName = json['SupGroupName'];
    cratedUserCode = json['CratedUserCode'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SupGroupName'] = this.supGroupName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
