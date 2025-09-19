class ItemLocationMasterList {
  bool? status;
  String? message;
  List<Info>? info;

  ItemLocationMasterList({this.status, this.message, this.info});

  ItemLocationMasterList.fromJson(Map<String, dynamic> json) {
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
  dynamic? itemLocationCode;
  String? itemLocationName;
  String? cratedUserCode;
  String? createdDate;
  dynamic updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  Info(
      {this.itemLocationCode,
      this.itemLocationName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    itemLocationCode = json['ItemLocationCode'];
    itemLocationName = json['ItemLocationName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemLocationCode'] = this.itemLocationCode;
    data['ItemLocationName'] = this.itemLocationName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
