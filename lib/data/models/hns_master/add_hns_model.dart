class AddHnsModel {
  String? hsnName;
  String? hsnNo;
  int? gstPercentage;
  int? cessPercentage;
  String? cratedUserCode;
  int? activeStatus;

  AddHnsModel(
      {this.hsnName,
      this.hsnNo,
      this.gstPercentage,
      this.cessPercentage,
      this.cratedUserCode,
      this.activeStatus});

  AddHnsModel.fromJson(Map<String, dynamic> json) {
    hsnName = json['HsnName'];
    hsnNo = json['HsnNo'];
    gstPercentage = json['GstPercentage'];
    cessPercentage = json['CessPercentage'];
    cratedUserCode = json['CratedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HsnName'] = this.hsnName;
    data['HsnNo'] = this.hsnNo;
    data['GstPercentage'] = this.gstPercentage;
    data['CessPercentage'] = this.cessPercentage;
    data['CratedUserCode'] = this.cratedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
