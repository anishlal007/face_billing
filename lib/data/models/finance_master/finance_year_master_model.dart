class FinanceYearMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  FinanceYearMasterListModel({this.status, this.message, this.info});

  FinanceYearMasterListModel.fromJson(Map<String, dynamic> json) {
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
  String? finYearCode;
  String? finYearStartDate;
  String? finYearEndDate;
  dynamic currentFinYear;
  dynamic cessPercentage;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  Info(
      {this.finYearCode,
      this.finYearStartDate,
      this.finYearEndDate,
      this.currentFinYear,
      this.cessPercentage,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    finYearCode = json['FinYearCode'];
    finYearStartDate = json['FinYearStartDate'];
    finYearEndDate = json['FinYearEndDate'];
    currentFinYear = json['CurrentFinYear'];
    cessPercentage = json['CessPercentage'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FinYearCode'] = this.finYearCode;
    data['FinYearStartDate'] = this.finYearStartDate;
    data['FinYearEndDate'] = this.finYearEndDate;
    data['CurrentFinYear'] = this.currentFinYear;
    data['CessPercentage'] = this.cessPercentage;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
