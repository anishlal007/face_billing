class SupplierMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  SupplierMasterListModel({this.status, this.message, this.info});

  SupplierMasterListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic supCode;
  String? supId;
  String? supName;
  dynamic supGroupCode;
  dynamic supAreaCode;
  dynamic supStateCode;
  dynamic supCountryCode;
  String? supAddress1;
  dynamic supAddress2;
  dynamic supAddress3;
  dynamic supAddress4;
  dynamic supAddress5;
  String? supPinCode;
  String? supMobileNo;
  dynamic supPhoneNo;
  dynamic supWhatsappNo;
  String? supEmailId;
  String? supLicenseNo;
  String? supPanNo;
  String? supGSTINNo;
  dynamic supGSTType;
  dynamic taxIsIncluded;
  String? supCreatedDate;
  dynamic createdUserCode;
  String? suptUpdatedDate;
  dynamic updatedUserCode;
  dynamic supActiveStatus;

  Info(
      {this.supCode,
      this.supId,
      this.supName,
      this.supGroupCode,
      this.supAreaCode,
      this.supStateCode,
      this.supCountryCode,
      this.supAddress1,
      this.supAddress2,
      this.supAddress3,
      this.supAddress4,
      this.supAddress5,
      this.supPinCode,
      this.supMobileNo,
      this.supPhoneNo,
      this.supWhatsappNo,
      this.supEmailId,
      this.supLicenseNo,
      this.supPanNo,
      this.supGSTINNo,
      this.supGSTType,
      this.taxIsIncluded,
      this.supCreatedDate,
      this.createdUserCode,
      this.suptUpdatedDate,
      this.updatedUserCode,
      this.supActiveStatus});

  Info.fromJson(Map<String, dynamic> json) {
    supCode = json['SupCode'];
    supId = json['SupId'];
    supName = json['SupName'];
    supGroupCode = json['SupGroupCode'];
    supAreaCode = json['SupAreaCode'];
    supStateCode = json['SupStateCode'];
    supCountryCode = json['SupCountryCode'];
    supAddress1 = json['SupAddress1'];
    supAddress2 = json['SupAddress2'];
    supAddress3 = json['SupAddress3'];
    supAddress4 = json['SupAddress4'];
    supAddress5 = json['SupAddress5'];
    supPinCode = json['SupPinCode'];
    supMobileNo = json['SupMobileNo'];
    supPhoneNo = json['SupPhoneNo'];
    supWhatsappNo = json['SupWhatsappNo'];
    supEmailId = json['SupEmailId'];
    supLicenseNo = json['SupLicenseNo'];
    supPanNo = json['SupPanNo'];
    supGSTINNo = json['SupGSTINNo'];
    supGSTType = json['SupGSTType'];
    taxIsIncluded = json['TaxIsIncluded'];
    supCreatedDate = json['SupCreatedDate'];
    createdUserCode = json['CreatedUserCode'];
    suptUpdatedDate = json['SuptUpdatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    supActiveStatus = json['SupActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SupCode'] = this.supCode;
    data['SupId'] = this.supId;
    data['SupName'] = this.supName;
    data['SupGroupCode'] = this.supGroupCode;
    data['SupAreaCode'] = this.supAreaCode;
    data['SupStateCode'] = this.supStateCode;
    data['SupCountryCode'] = this.supCountryCode;
    data['SupAddress1'] = this.supAddress1;
    data['SupAddress2'] = this.supAddress2;
    data['SupAddress3'] = this.supAddress3;
    data['SupAddress4'] = this.supAddress4;
    data['SupAddress5'] = this.supAddress5;
    data['SupPinCode'] = this.supPinCode;
    data['SupMobileNo'] = this.supMobileNo;
    data['SupPhoneNo'] = this.supPhoneNo;
    data['SupWhatsappNo'] = this.supWhatsappNo;
    data['SupEmailId'] = this.supEmailId;
    data['SupLicenseNo'] = this.supLicenseNo;
    data['SupPanNo'] = this.supPanNo;
    data['SupGSTINNo'] = this.supGSTINNo;
    data['SupGSTType'] = this.supGSTType;
    data['TaxIsIncluded'] = this.taxIsIncluded;
    data['SupCreatedDate'] = this.supCreatedDate;
    data['CreatedUserCode'] = this.createdUserCode;
    data['SuptUpdatedDate'] = this.suptUpdatedDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['SupActiveStatus'] = this.supActiveStatus;
    return data;
  }
}
