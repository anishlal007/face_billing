class ItemMakeMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  ItemMakeMasterListModel({this.status, this.message, this.info});

  ItemMakeMasterListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic itemMakeCode;
  String? itemMaketName;
  String? cratedUserCode;
  String? createdDate;
  dynamic updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  Info(
      {this.itemMakeCode,
      this.itemMaketName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    itemMakeCode = json['ItemMakeCode'];
    itemMaketName = json['ItemMaketName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemMakeCode'] = this.itemMakeCode;
    data['ItemMaketName'] = this.itemMaketName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
