class HnsMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  HnsMasterListModel({this.status, this.message, this.info});

  HnsMasterListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic hsnCode;
  String? hsnName;
  String? hsnNo;
  dynamic gstPercentage;
  dynamic cessPercentage;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  Info(
      {this.hsnCode,
      this.hsnName,
      this.hsnNo,
      this.gstPercentage,
      this.cessPercentage,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    hsnCode = json['HsnCode'];
    hsnName = json['HsnName'];
    hsnNo = json['HsnNo'];
    gstPercentage = json['GstPercentage'];
    cessPercentage = json['CessPercentage'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HsnCode'] = this.hsnCode;
    data['HsnName'] = this.hsnName;
    data['HsnNo'] = this.hsnNo;
    data['GstPercentage'] = this.gstPercentage;
    data['CessPercentage'] = this.cessPercentage;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
