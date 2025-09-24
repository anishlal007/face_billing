class AddCompanyMasterModel {
  String? coName;
  String? coShortName;
  String? coAddress1;
  String? coAddress2;
  String? coAddress3;
  String? coAddress4;
  String? coAddress5;
  int? areaCode;
  int? cityCode;
  String? coPinCode;
  int? stateCode;
  int? countryCode;
  String? coMobileNo1;
  String? coPhoneNo1;
  String? coMailId;
  String? coWebsite;
  String? coGstinNo;
  String? coPanNo;
  String? coLicenseNo1;
  String? coFSSAINo;
  String? coBankName;
  String? coAccNo;
  String? coIFSCCode;
  String? coBranchName;
  String? coBankAdd1;
  String? coLogo;
  int? coActiveStatus;
  String? softwareVersion;
  String? softwareInstalledDt;

  AddCompanyMasterModel(
      {this.coName,
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
      this.coPhoneNo1,
      this.coMailId,
      this.coWebsite,
      this.coGstinNo,
      this.coPanNo,
      this.coLicenseNo1,
      this.coFSSAINo,
      this.coBankName,
      this.coAccNo,
      this.coIFSCCode,
      this.coBranchName,
      this.coBankAdd1,
      this.coLogo,
      this.coActiveStatus,
      this.softwareVersion,
      this.softwareInstalledDt});

  AddCompanyMasterModel.fromJson(Map<String, dynamic> json) {
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
    coPhoneNo1 = json['CoPhoneNo1'];
    coMailId = json['CoMailId'];
    coWebsite = json['CoWebsite'];
    coGstinNo = json['CoGstinNo'];
    coPanNo = json['CoPanNo'];
    coLicenseNo1 = json['CoLicenseNo1'];
    coFSSAINo = json['CoFSSAINo'];
    coBankName = json['CoBankName'];
    coAccNo = json['CoAccNo'];
    coIFSCCode = json['CoIFSCCode'];
    coBranchName = json['CoBranchName'];
    coBankAdd1 = json['CoBankAdd1'];
    coLogo = json['CoLogo'];
    coActiveStatus = json['CoActiveStatus'];
    softwareVersion = json['SoftwareVersion'];
    softwareInstalledDt = json['SoftwareInstalledDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['CoPhoneNo1'] = this.coPhoneNo1;
    data['CoMailId'] = this.coMailId;
    data['CoWebsite'] = this.coWebsite;
    data['CoGstinNo'] = this.coGstinNo;
    data['CoPanNo'] = this.coPanNo;
    data['CoLicenseNo1'] = this.coLicenseNo1;
    data['CoFSSAINo'] = this.coFSSAINo;
    data['CoBankName'] = this.coBankName;
    data['CoAccNo'] = this.coAccNo;
    data['CoIFSCCode'] = this.coIFSCCode;
    data['CoBranchName'] = this.coBranchName;
    data['CoBankAdd1'] = this.coBankAdd1;
    data['CoLogo'] = this.coLogo;
    data['CoActiveStatus'] = this.coActiveStatus;
    data['SoftwareVersion'] = this.softwareVersion;
    data['SoftwareInstalledDt'] = this.softwareInstalledDt;
    return data;
  }
}
