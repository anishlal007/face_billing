class AddCustomerMasterModel {
  String? custId;
  String? custName;
  String? custDOB;
  int? gender;
  int? custGroupCode;
  int? custAreaCode;
  int? custStateCode;
  int? custCountryCode;
  String? custAddress1;
  String? custPinCode;
  String? custMobileNo;
  String? custEmailId;
  String? custGSTINNo;
  int? custGSTType;
  int? taxIsIncluded;
  String? custCreatedDate;
  int? updatedUserCode;
  int? createdUserCode;
  int? custActiveStatus;

  AddCustomerMasterModel(
      {this.custId,
      this.custName,
      this.custDOB,
      this.gender,
      this.custGroupCode,
      this.custAreaCode,
      this.custStateCode,
      this.custCountryCode,
      this.custAddress1,
      this.custPinCode,
      this.custMobileNo,
      this.custEmailId,
      this.custGSTINNo,
      this.custGSTType,
      this.taxIsIncluded,
      this.custCreatedDate,
      this.updatedUserCode,
      this.createdUserCode,
      this.custActiveStatus});

  AddCustomerMasterModel.fromJson(Map<String, dynamic> json) {
    custId = json['CustId'];
    custName = json['CustName'];
    custDOB = json['CustDOB'];
    gender = json['Gender'];
    custGroupCode = json['CustGroupCode'];
    custAreaCode = json['CustAreaCode'];
    custStateCode = json['CustStateCode'];
    custCountryCode = json['CustCountryCode'];
    custAddress1 = json['CustAddress1'];
    custPinCode = json['CustPinCode'];
    custMobileNo = json['CustMobileNo'];
    custEmailId = json['CustEmailId'];
    custGSTINNo = json['CustGSTINNo'];
    custGSTType = json['CustGSTType'];
    taxIsIncluded = json['TaxIsIncluded'];
    custCreatedDate = json['CustCreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    createdUserCode = json['CreatedUserCode'];
    custActiveStatus = json['CustActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustId'] = this.custId;
    data['CustName'] = this.custName;
    data['CustDOB'] = this.custDOB;
    data['Gender'] = this.gender;
    data['CustGroupCode'] = this.custGroupCode;
    data['CustAreaCode'] = this.custAreaCode;
    data['CustStateCode'] = this.custStateCode;
    data['CustCountryCode'] = this.custCountryCode;
    data['CustAddress1'] = this.custAddress1;
    data['CustPinCode'] = this.custPinCode;
    data['CustMobileNo'] = this.custMobileNo;
    data['CustEmailId'] = this.custEmailId;
    data['CustGSTINNo'] = this.custGSTINNo;
    data['CustGSTType'] = this.custGSTType;
    data['TaxIsIncluded'] = this.taxIsIncluded;
    data['CustCreatedDate'] = this.custCreatedDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CustActiveStatus'] = this.custActiveStatus;
    return data;
  }
}
