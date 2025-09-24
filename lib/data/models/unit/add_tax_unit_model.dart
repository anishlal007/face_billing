class AddTaxModelReq {
  String? taxId;
  String? taxName;
  dynamic taxPercentage;
  dynamic taxType;
  String? cratedUserCode;
  String? createdDate;
  dynamic updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  AddTaxModelReq(
      {this.taxId,
      this.taxName,
      this.taxPercentage,
      this.taxType,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  AddTaxModelReq.fromJson(Map<String, dynamic> json) {
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
