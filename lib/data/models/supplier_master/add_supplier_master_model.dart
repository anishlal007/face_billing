class AddSupplierMasterModel {
  String? supId;
  String? supName;
  int? supGroupCode;
  int? supAreaCode;
  int? supStateCode;
  int? supCountryCode;
  String? supAddress1;
  String? supPinCode;
  String? supMobileNo;
  String? supEmailId;
  String? supGSTINNo;
  String? supLicenseNo;
  String? supPanNo;
  int? supGSTType;
  int? taxIsIncluded;
  String? createdUserCode;
  int? supActiveStatus;

  AddSupplierMasterModel(
      {this.supId,
      this.supName,
      this.supGroupCode,
      this.supAreaCode,
      this.supStateCode,
      this.supCountryCode,
      this.supAddress1,
      this.supPinCode,
      this.supMobileNo,
      this.supEmailId,
      this.supGSTINNo,
      this.supLicenseNo,
      this.supPanNo,
      this.supGSTType,
      this.taxIsIncluded,
      this.createdUserCode,
      this.supActiveStatus});

  AddSupplierMasterModel.fromJson(Map<String, dynamic> json) {
    supId = json['SupId'];
    supName = json['SupName'];
    supGroupCode = json['SupGroupCode'];
    supAreaCode = json['SupAreaCode'];
    supStateCode = json['SupStateCode'];
    supCountryCode = json['SupCountryCode'];
    supAddress1 = json['SupAddress1'];
    supPinCode = json['SupPinCode'];
    supMobileNo = json['SupMobileNo'];
    supEmailId = json['SupEmailId'];
    supGSTINNo = json['SupGSTINNo'];
    supLicenseNo = json['SupLicenseNo'];
    supPanNo = json['SupPanNo'];
    supGSTType = json['SupGSTType'];
    taxIsIncluded = json['TaxIsIncluded'];
    createdUserCode = json['CreatedUserCode'];
    supActiveStatus = json['SupActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SupId'] = this.supId;
    data['SupName'] = this.supName;
    data['SupGroupCode'] = this.supGroupCode;
    data['SupAreaCode'] = this.supAreaCode;
    data['SupStateCode'] = this.supStateCode;
    data['SupCountryCode'] = this.supCountryCode;
    data['SupAddress1'] = this.supAddress1;
    data['SupPinCode'] = this.supPinCode;
    data['SupMobileNo'] = this.supMobileNo;
    data['SupEmailId'] = this.supEmailId;
    data['SupGSTINNo'] = this.supGSTINNo;
    data['SupLicenseNo'] = this.supLicenseNo;
    data['SupPanNo'] = this.supPanNo;
    data['SupGSTType'] = this.supGSTType;
    data['TaxIsIncluded'] = this.taxIsIncluded;
    data['CreatedUserCode'] = this.createdUserCode;
    data['SupActiveStatus'] = this.supActiveStatus;
    return data;
  }
}
