class AddFinanceYearMasterModel {
  String? finYearStartDate;
  String? finYearEndDate;
  int? currentFinYear;
  int? cessPercentage;
  String? cratedUserCode;
  String? updatedUserCode;
  int? activeStatus;

  AddFinanceYearMasterModel(
      {this.finYearStartDate,
      this.finYearEndDate,
      this.currentFinYear,
      this.cessPercentage,
      this.cratedUserCode,
      this.updatedUserCode,
      this.activeStatus});

  AddFinanceYearMasterModel.fromJson(Map<String, dynamic> json) {
    finYearStartDate = json['FinYearStartDate'];
    finYearEndDate = json['FinYearEndDate'];
    currentFinYear = json['CurrentFinYear'];
    cessPercentage = json['CessPercentage'];
    cratedUserCode = json['CratedUserCode'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FinYearStartDate'] = this.finYearStartDate;
    data['FinYearEndDate'] = this.finYearEndDate;
    data['CurrentFinYear'] = this.currentFinYear;
    data['CessPercentage'] = this.cessPercentage;
    data['CratedUserCode'] = this.cratedUserCode;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
