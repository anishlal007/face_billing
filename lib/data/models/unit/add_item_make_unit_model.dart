class AddItemMakeUnit {
  String? itemMaketName;
  String? cratedUserCode;
  String? updatedUserCode;
  int? activeStatus;

  AddItemMakeUnit(
      {this.itemMaketName,
      this.cratedUserCode,
      this.updatedUserCode,
      this.activeStatus});

  AddItemMakeUnit.fromJson(Map<String, dynamic> json) {
    itemMaketName = json['ItemMaketName'];
    cratedUserCode = json['CratedUserCode'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemMaketName'] = this.itemMaketName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
