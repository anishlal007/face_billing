class TaxMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  TaxMasterListModel({this.status, this.message, this.info});

  TaxMasterListModel.fromJson(Map<String, dynamic> json) {
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
  int? taxCode;
  String? taxId;
  String? taxName;
  int? taxPercentage;
  int? taxType;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  int? activeStatus;

  Info(
      {this.taxCode,
      this.taxId,
      this.taxName,
      this.taxPercentage,
      this.taxType,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    taxCode = json['TaxCode'];
    taxId = json['TaxId'];
    taxName = json['TaxName'];
    taxPercentage = json['TaxPercentage'];
    taxType = json['TaxType'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaxCode'] = this.taxCode;
    data['TaxId'] = this.taxId;
    data['TaxName'] = this.taxName;
    data['TaxPercentage'] = this.taxPercentage;
    data['TaxType'] = this.taxType;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
