class CompanyMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  CompanyMasterListModel({this.status, this.message, this.info});

  CompanyMasterListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic coCode;
  String? coName;
  String? coShortName;
  String? coAddress1;
  String? coAddress2;
  String? coAddress3;
  String? coAddress4;
  String? coAddress5;
  dynamic areaCode;
  dynamic cityCode;
  String? coPinCode;
  dynamic stateCode;
  dynamic countryCode;
  String? coMobileNo1;
  String? coMobileNo2;
  String? coPhoneNo1;
  String? coPhoneNo2;
  String? coMailId;
  String? coWebsite;
  String? coGstinNo;
  String? coPanNo;
  String? coLicenseNo1;
  String? coLicenseNo2;
  String? coFSSAINo;
  String? coBankName;
  String? coAccNo;
  String? coIFSCCode;
  String? coBranchName;
  String? coBankAdd1;
  String? coBankAdd2;
  String? coBankAdd3;
  String? coLogo;
  dynamic coActiveStatus;
  String? softwareVersion;
  String? softwareInstalledDt;

  Info(
      {this.coCode,
      this.coName,
      this.coShortName,
      this.coAddress1,
      this.coAddress2,
      this.coAddress3,
      this.coAddress4,
      this.coAddress5,
      this.areaCode,
      this.cityCode,
      this.coPinCode,
      this.stateCode,
      this.countryCode,
      this.coMobileNo1,
      this.coMobileNo2,
      this.coPhoneNo1,
      this.coPhoneNo2,
      this.coMailId,
      this.coWebsite,
      this.coGstinNo,
      this.coPanNo,
      this.coLicenseNo1,
      this.coLicenseNo2,
      this.coFSSAINo,
      this.coBankName,
      this.coAccNo,
      this.coIFSCCode,
      this.coBranchName,
      this.coBankAdd1,
      this.coBankAdd2,
      this.coBankAdd3,
      this.coLogo,
      this.coActiveStatus,
      this.softwareVersion,
      this.softwareInstalledDt});

  Info.fromJson(Map<String, dynamic> json) {
    coCode = json['CoCode'];
    coName = json['CoName'];
    coShortName = json['CoShortName'];
    coAddress1 = json['CoAddress1'];
    coAddress2 = json['CoAddress2'];
    coAddress3 = json['CoAddress3'];
    coAddress4 = json['CoAddress4'];
    coAddress5 = json['CoAddress5'];
    areaCode = json['AreaCode'];
    cityCode = json['CityCode'];
    coPinCode = json['CoPinCode'];
    stateCode = json['StateCode'];
    countryCode = json['CountryCode'];
    coMobileNo1 = json['CoMobileNo1'];
    coMobileNo2 = json['CoMobileNo2'];
    coPhoneNo1 = json['CoPhoneNo1'];
    coPhoneNo2 = json['CoPhoneNo2'];
    coMailId = json['CoMailId'];
    coWebsite = json['CoWebsite'];
    coGstinNo = json['CoGstinNo'];
    coPanNo = json['CoPanNo'];
    coLicenseNo1 = json['CoLicenseNo1'];
    coLicenseNo2 = json['CoLicenseNo2'];
    coFSSAINo = json['CoFSSAINo'];
    coBankName = json['CoBankName'];
    coAccNo = json['CoAccNo'];
    coIFSCCode = json['CoIFSCCode'];
    coBranchName = json['CoBranchName'];
    coBankAdd1 = json['CoBankAdd1'];
    coBankAdd2 = json['CoBankAdd2'];
    coBankAdd3 = json['CoBankAdd3'];
    coLogo = json['CoLogo'];
    coActiveStatus = json['CoActiveStatus'];
    softwareVersion = json['SoftwareVersion'];
    softwareInstalledDt = json['SoftwareInstalledDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CoCode'] = this.coCode;
    data['CoName'] = this.coName;
    data['CoShortName'] = this.coShortName;
    data['CoAddress1'] = this.coAddress1;
    data['CoAddress2'] = this.coAddress2;
    data['CoAddress3'] = this.coAddress3;
    data['CoAddress4'] = this.coAddress4;
    data['CoAddress5'] = this.coAddress5;
    data['AreaCode'] = this.areaCode;
    data['CityCode'] = this.cityCode;
    data['CoPinCode'] = this.coPinCode;
    data['StateCode'] = this.stateCode;
    data['CountryCode'] = this.countryCode;
    data['CoMobileNo1'] = this.coMobileNo1;
    data['CoMobileNo2'] = this.coMobileNo2;
    data['CoPhoneNo1'] = this.coPhoneNo1;
    data['CoPhoneNo2'] = this.coPhoneNo2;
    data['CoMailId'] = this.coMailId;
    data['CoWebsite'] = this.coWebsite;
    data['CoGstinNo'] = this.coGstinNo;
    data['CoPanNo'] = this.coPanNo;
    data['CoLicenseNo1'] = this.coLicenseNo1;
    data['CoLicenseNo2'] = this.coLicenseNo2;
    data['CoFSSAINo'] = this.coFSSAINo;
    data['CoBankName'] = this.coBankName;
    data['CoAccNo'] = this.coAccNo;
    data['CoIFSCCode'] = this.coIFSCCode;
    data['CoBranchName'] = this.coBranchName;
    data['CoBankAdd1'] = this.coBankAdd1;
    data['CoBankAdd2'] = this.coBankAdd2;
    data['CoBankAdd3'] = this.coBankAdd3;
    data['CoLogo'] = this.coLogo;
    data['CoActiveStatus'] = this.coActiveStatus;
    data['SoftwareVersion'] = this.softwareVersion;
    data['SoftwareInstalledDt'] = this.softwareInstalledDt;
    return data;
  }
}
