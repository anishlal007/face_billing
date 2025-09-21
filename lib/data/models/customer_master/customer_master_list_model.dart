class CustomerMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  CustomerMasterListModel({this.status, this.message, this.info});

  CustomerMasterListModel.fromJson(Map<String, dynamic> json) {
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
  int? custCode;
  String? custId;
  String? custName;
  String? custDOB;
  int? gender;
  int? custGroupCode;
  int? custAreaCode;
  int? custStateCode;
  int? custCountryCode;
  String? custaddress1;
  String? custAddress2;
  String? custAddress3;
  String? custAddress4;
  String? custAddress5;
  String? custPinCode;
  String? custMobileNo;
  String? custPhoneNo;
  String? custWhatsappNo;
  String? custEmailId;
  String? custPanNo;
  String? custGSTINNo;
  int? custGSTType;
  int? taxIsIncluded;
  String? custCreatedDate;
  int? createdUserCode;
  String? custUpdatedDate;
  int? updatedUserCode;
  int? custActiveStatus;
  Group? group;
  Area? area;
  Country? country;

  Info(
      {this.custCode,
      this.custId,
      this.custName,
      this.custDOB,
      this.gender,
      this.custGroupCode,
      this.custAreaCode,
      this.custStateCode,
      this.custCountryCode,
      this.custaddress1,
      this.custAddress2,
      this.custAddress3,
      this.custAddress4,
      this.custAddress5,
      this.custPinCode,
      this.custMobileNo,
      this.custPhoneNo,
      this.custWhatsappNo,
      this.custEmailId,
      this.custPanNo,
      this.custGSTINNo,
      this.custGSTType,
      this.taxIsIncluded,
      this.custCreatedDate,
      this.createdUserCode,
      this.custUpdatedDate,
      this.updatedUserCode,
      this.custActiveStatus,
      this.group,
      this.area,
      this.country});

  Info.fromJson(Map<String, dynamic> json) {
    custCode = json['CustCode'];
    custId = json['CustId'];
    custName = json['CustName'];
    custDOB = json['CustDOB'];
    gender = json['Gender'];
    custGroupCode = json['CustGroupCode'];
    custAreaCode = json['CustAreaCode'];
    custStateCode = json['CustStateCode'];
    custCountryCode = json['CustCountryCode'];
    custaddress1 = json['Custaddress1'];
    custAddress2 = json['CustAddress2'];
    custAddress3 = json['CustAddress3'];
    custAddress4 = json['CustAddress4'];
    custAddress5 = json['CustAddress5'];
    custPinCode = json['CustPinCode'];
    custMobileNo = json['CustMobileNo'];
    custPhoneNo = json['CustPhoneNo'];
    custWhatsappNo = json['CustWhatsappNo'];
    custEmailId = json['CustEmailId'];
    custPanNo = json['CustPanNo'];
    custGSTINNo = json['CustGSTINNo'];
    custGSTType = json['CustGSTType'];
    taxIsIncluded = json['TaxIsIncluded'];
    custCreatedDate = json['CustCreatedDate'];
    createdUserCode = json['CreatedUserCode'];
    custUpdatedDate = json['CustUpdatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    custActiveStatus = json['CustActiveStatus'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustCode'] = this.custCode;
    data['CustId'] = this.custId;
    data['CustName'] = this.custName;
    data['CustDOB'] = this.custDOB;
    data['Gender'] = this.gender;
    data['CustGroupCode'] = this.custGroupCode;
    data['CustAreaCode'] = this.custAreaCode;
    data['CustStateCode'] = this.custStateCode;
    data['CustCountryCode'] = this.custCountryCode;
    data['Custaddress1'] = this.custaddress1;
    data['CustAddress2'] = this.custAddress2;
    data['CustAddress3'] = this.custAddress3;
    data['CustAddress4'] = this.custAddress4;
    data['CustAddress5'] = this.custAddress5;
    data['CustPinCode'] = this.custPinCode;
    data['CustMobileNo'] = this.custMobileNo;
    data['CustPhoneNo'] = this.custPhoneNo;
    data['CustWhatsappNo'] = this.custWhatsappNo;
    data['CustEmailId'] = this.custEmailId;
    data['CustPanNo'] = this.custPanNo;
    data['CustGSTINNo'] = this.custGSTINNo;
    data['CustGSTType'] = this.custGSTType;
    data['TaxIsIncluded'] = this.taxIsIncluded;
    data['CustCreatedDate'] = this.custCreatedDate;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CustUpdatedDate'] = this.custUpdatedDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['CustActiveStatus'] = this.custActiveStatus;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Group {
  int? custGroupCode;
  String? custGroupName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  int? activeStatus;

  Group(
      {this.custGroupCode,
      this.custGroupName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Group.fromJson(Map<String, dynamic> json) {
    custGroupCode = json['CustGroupCode'];
    custGroupName = json['CustGroupName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustGroupCode'] = this.custGroupCode;
    data['CustGroupName'] = this.custGroupName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class Area {
  int? areaCode;
  String? areaId;
  String? areaName;
  int? stateCode;
  int? createdUserCode;
  int? activeStatus;

  Area(
      {this.areaCode,
      this.areaId,
      this.areaName,
      this.stateCode,
      this.createdUserCode,
      this.activeStatus});

  Area.fromJson(Map<String, dynamic> json) {
    areaCode = json['AreaCode'];
    areaId = json['AreaId'];
    areaName = json['AreaName'];
    stateCode = json['StateCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AreaCode'] = this.areaCode;
    data['AreaId'] = this.areaId;
    data['AreaName'] = this.areaName;
    data['StateCode'] = this.stateCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class Country {
  int? countryCode;
  String? countryId;
  String? countryName;
  int? createdUserCode;
  int? activeStatus;

  Country(
      {this.countryCode,
      this.countryId,
      this.countryName,
      this.createdUserCode,
      this.activeStatus});

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['CountryCode'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryCode'] = this.countryCode;
    data['CountryId'] = this.countryId;
    data['CountryName'] = this.countryName;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
