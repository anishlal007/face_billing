class GetAllMasterListModel {
  bool? status;
  String? message;
  Info? info;

  GetAllMasterListModel({this.status, this.message, this.info});

  GetAllMasterListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    return data;
  }
}

class Info {
  List<Company>? company;
  List<Areas>? areas;
  List<Countries>? countries;
  List<Customers>? customers;
  List<CustomerGroups>? customerGroups;
  List<Doctors>? doctors;
  List<FinanceYears>? financeYears;
  List<Generics>? generics;
  List<HsnMasters>? hsnMasters;
  List<ItemGroups>? itemGroups;
  List<ItemLocations>? itemLocations;
  List<ItemMakes>? itemMakes;
  List<NumberInitialize>? numberInitialize;
  List<Salespersons>? salespersons;
  List<Suppliers>? suppliers;
  List<SupplierGroups>? supplierGroups;
  List<TaxMasters>? taxMasters;
  List<Units>? units;
  List<Users>? users;
  List<States>? states;

  Info(
      {this.company,
      this.areas,
      this.countries,
      this.customers,
      this.customerGroups,
      this.doctors,
      this.financeYears,
      this.generics,
      this.hsnMasters,
      this.itemGroups,
      this.itemLocations,
      this.itemMakes,
      this.numberInitialize,
      this.salespersons,
      this.suppliers,
      this.supplierGroups,
      this.taxMasters,
      this.units,
      this.users,
      this.states});

  Info.fromJson(Map<String, dynamic> json) {
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
    if (json['customerGroups'] != null) {
      customerGroups = <CustomerGroups>[];
      json['customerGroups'].forEach((v) {
        customerGroups!.add(new CustomerGroups.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    if (json['financeYears'] != null) {
      financeYears = <FinanceYears>[];
      json['financeYears'].forEach((v) {
        financeYears!.add(new FinanceYears.fromJson(v));
      });
    }
    if (json['generics'] != null) {
      generics = <Generics>[];
      json['generics'].forEach((v) {
        generics!.add(new Generics.fromJson(v));
      });
    }
    if (json['hsnMasters'] != null) {
      hsnMasters = <HsnMasters>[];
      json['hsnMasters'].forEach((v) {
        hsnMasters!.add(new HsnMasters.fromJson(v));
      });
    }
    if (json['itemGroups'] != null) {
      itemGroups = <ItemGroups>[];
      json['itemGroups'].forEach((v) {
        itemGroups!.add(new ItemGroups.fromJson(v));
      });
    }
    if (json['itemLocations'] != null) {
      itemLocations = <ItemLocations>[];
      json['itemLocations'].forEach((v) {
        itemLocations!.add(new ItemLocations.fromJson(v));
      });
    }
    if (json['itemMakes'] != null) {
      itemMakes = <ItemMakes>[];
      json['itemMakes'].forEach((v) {
        itemMakes!.add(new ItemMakes.fromJson(v));
      });
    }
    if (json['numberInitialize'] != null) {
      numberInitialize = <NumberInitialize>[];
      json['numberInitialize'].forEach((v) {
        numberInitialize!.add(new NumberInitialize.fromJson(v));
      });
    }
    if (json['salespersons'] != null) {
      salespersons = <Salespersons>[];
      json['salespersons'].forEach((v) {
        salespersons!.add(new Salespersons.fromJson(v));
      });
    }
    if (json['suppliers'] != null) {
      suppliers = <Suppliers>[];
      json['suppliers'].forEach((v) {
        suppliers!.add(new Suppliers.fromJson(v));
      });
    }
    if (json['supplierGroups'] != null) {
      supplierGroups = <SupplierGroups>[];
      json['supplierGroups'].forEach((v) {
        supplierGroups!.add(new SupplierGroups.fromJson(v));
      });
    }
    if (json['taxMasters'] != null) {
      taxMasters = <TaxMasters>[];
      json['taxMasters'].forEach((v) {
        taxMasters!.add(new TaxMasters.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    if (this.customerGroups != null) {
      data['customerGroups'] =
          this.customerGroups!.map((v) => v.toJson()).toList();
    }
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    if (this.financeYears != null) {
      data['financeYears'] = this.financeYears!.map((v) => v.toJson()).toList();
    }
    if (this.generics != null) {
      data['generics'] = this.generics!.map((v) => v.toJson()).toList();
    }
    if (this.hsnMasters != null) {
      data['hsnMasters'] = this.hsnMasters!.map((v) => v.toJson()).toList();
    }
    if (this.itemGroups != null) {
      data['itemGroups'] = this.itemGroups!.map((v) => v.toJson()).toList();
    }
    if (this.itemLocations != null) {
      data['itemLocations'] =
          this.itemLocations!.map((v) => v.toJson()).toList();
    }
    if (this.itemMakes != null) {
      data['itemMakes'] = this.itemMakes!.map((v) => v.toJson()).toList();
    }
    if (this.numberInitialize != null) {
      data['numberInitialize'] =
          this.numberInitialize!.map((v) => v.toJson()).toList();
    }
    if (this.salespersons != null) {
      data['salespersons'] = this.salespersons!.map((v) => v.toJson()).toList();
    }
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    }
    if (this.supplierGroups != null) {
      data['supplierGroups'] =
          this.supplierGroups!.map((v) => v.toJson()).toList();
    }
    if (this.taxMasters != null) {
      data['taxMasters'] = this.taxMasters!.map((v) => v.toJson()).toList();
    }
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
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

  Company(
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

  Company.fromJson(Map<String, dynamic> json) {
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

class Areas {
  dynamic areaCode;
  String? areaId;
  String? areaName;
  dynamic stateCode;
  dynamic createdUserCode;
  dynamic activeStatus;

  Areas(
      {this.areaCode,
      this.areaId,
      this.areaName,
      this.stateCode,
      this.createdUserCode,
      this.activeStatus});

  Areas.fromJson(Map<String, dynamic> json) {
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

class Countries {
  dynamic countryCode;
  String? countryId;
  String? countryName;
  dynamic createdUserCode;
  dynamic activeStatus;

  Countries(
      {this.countryCode,
      this.countryId,
      this.countryName,
      this.createdUserCode,
      this.activeStatus});

  Countries.fromJson(Map<String, dynamic> json) {
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

class Customers {
  dynamic custCode;
  String? custId;
  String? custName;
  String? custDOB;
  dynamic gender;
  dynamic custGroupCode;
  dynamic custAreaCode;
  dynamic custStateCode;
  dynamic custCountryCode;
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
  dynamic custGSTType;
  dynamic taxIsIncluded;
  String? custCreatedDate;
  dynamic createdUserCode;
  String? custUpdatedDate;
  dynamic updatedUserCode;
  dynamic custActiveStatus;

  Customers(
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
      this.custActiveStatus});

  Customers.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class CustomerGroups {
  dynamic custGroupCode;
  String? custGroupName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  CustomerGroups(
      {this.custGroupCode,
      this.custGroupName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  CustomerGroups.fromJson(Map<String, dynamic> json) {
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

class Doctors {
  dynamic doctCode;
  String? doctId;
  String? doctName;
  dynamic doctCommPercent;
  String? doctMobileNo;
  String? createdUserCode;
  String? createdDate;
  String? updatedUserCode;
  dynamic activeStatus;

  Doctors(
      {this.doctCode,
      this.doctId,
      this.doctName,
      this.doctCommPercent,
      this.doctMobileNo,
      this.createdUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.activeStatus});

  Doctors.fromJson(Map<String, dynamic> json) {
    doctCode = json['DoctCode'];
    doctId = json['DoctId'];
    doctName = json['DoctName'];
    doctCommPercent = json['DoctCommPercent'];
    doctMobileNo = json['DoctMobileNo'];
    createdUserCode = json['CreatedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctCode'] = this.doctCode;
    data['DoctId'] = this.doctId;
    data['DoctName'] = this.doctName;
    data['DoctCommPercent'] = this.doctCommPercent;
    data['DoctMobileNo'] = this.doctMobileNo;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class FinanceYears {
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

  FinanceYears(
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

  FinanceYears.fromJson(Map<String, dynamic> json) {
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

class Generics {
  dynamic genericCode;
  String? genericName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  Generics(
      {this.genericCode,
      this.genericName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Generics.fromJson(Map<String, dynamic> json) {
    genericCode = json['GenericCode'];
    genericName = json['GenericName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GenericCode'] = this.genericCode;
    data['GenericName'] = this.genericName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class HsnMasters {
  dynamic hsnCode;
  String? hsnName;
  String? hsnNo;
  dynamic gstPercentage;
  dynamic cessPercentage;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  HsnMasters(
      {this.hsnCode,
      this.hsnName,
      this.hsnNo,
      this.gstPercentage,
      this.cessPercentage,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  HsnMasters.fromJson(Map<String, dynamic> json) {
    hsnCode = json['HsnCode'];
    hsnName = json['HsnName'];
    hsnNo = json['HsnNo'];
    gstPercentage = json['GstPercentage'];
    cessPercentage = json['CessPercentage'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HsnCode'] = this.hsnCode;
    data['HsnName'] = this.hsnName;
    data['HsnNo'] = this.hsnNo;
    data['GstPercentage'] = this.gstPercentage;
    data['CessPercentage'] = this.cessPercentage;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class ItemGroups {
  dynamic itemGroupCode;
  String? itemGroupName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;
  String? createdAt;
  String? updatedAt;

  ItemGroups(
      {this.itemGroupCode,
      this.itemGroupName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus,
      this.createdAt,
      this.updatedAt});

  ItemGroups.fromJson(Map<String, dynamic> json) {
    itemGroupCode = json['ItemGroupCode'];
    itemGroupName = json['ItemGroupName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemGroupCode'] = this.itemGroupCode;
    data['ItemGroupName'] = this.itemGroupName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ItemLocations {
  dynamic itemLocationCode;
  String? itemLocationName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  ItemLocations(
      {this.itemLocationCode,
      this.itemLocationName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  ItemLocations.fromJson(Map<String, dynamic> json) {
    itemLocationCode = json['ItemLocationCode'];
    itemLocationName = json['ItemLocationName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemLocationCode'] = this.itemLocationCode;
    data['ItemLocationName'] = this.itemLocationName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class ItemMakes {
  dynamic itemMakeCode;
  String? cratedUserCode;
  String? itemMaketName;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  ItemMakes(
      {this.itemMakeCode,
      this.cratedUserCode,
      this.itemMaketName,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  ItemMakes.fromJson(Map<String, dynamic> json) {
    itemMakeCode = json['ItemMakeCode'];
    cratedUserCode = json['CratedUserCode'];
    itemMaketName = json['ItemMaketName'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemMakeCode'] = this.itemMakeCode;
    data['CratedUserCode'] = this.cratedUserCode;
    data['ItemMaketName'] = this.itemMaketName;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class NumberInitialize {
  dynamic numCode;
  String? coCode;
  String? finYearCode;
  String? custIdPrefix;
  String? custId;
  String? custIdSuffix;
  String? custIdFormalDigit;
  String? supIdPrefix;
  String? supId;
  String? supIdSuffix;
  String? supIdFormalDigit;
  String? productIdPrefix;
  String? productId;
  String? productIdFormalDigit;
  String? purNoPrefix;
  String? purchaseNo;
  String? purNoSuffix;
  String? purNoFormalDigit;
  String? salesNoPrefix;
  String? salesNo;
  String? salesNoSuffix;
  String? salesNoFormalDigit;
  String? purNo2Prefix;
  String? purchaseNo2;
  String? purNo2Suffix;
  String? purNo2FormalDigit;
  String? purOrderNoPrefix;
  String? purchaseOderNo;
  String? purOrderNoSuffix;
  String? purOrderNoFormalDigit;
  String? purOrderNo2Prefix;
  String? purchaseOrderNo2;
  String? purOrderNo2Suffix;
  String? purOrderNo2FormalDigit;
  String? quoNoPrefix;
  String? quotationNo;
  String? quoNoSuffix;
  String? quoNoFormalDigit;
  String? quoNo2Prefix;
  String? quotationNo2;
  String? quoNo2FormalDigit;
  String? quoNo2Suffix;
  String? salesNo2Prefix;
  String? salesNo2;
  String? salesNo2Suffix;
  String? salesNo2FormalDigit;
  String? salesOrderNoPrefix;
  String? salesOrderNo;
  String? salesOrderNoFormalDigit;
  String? salesOrderNoSuffix;

  NumberInitialize(
      {this.numCode,
      this.coCode,
      this.finYearCode,
      this.custIdPrefix,
      this.custId,
      this.custIdSuffix,
      this.custIdFormalDigit,
      this.supIdPrefix,
      this.supId,
      this.supIdSuffix,
      this.supIdFormalDigit,
      this.productIdPrefix,
      this.productId,
      this.productIdFormalDigit,
      this.purNoPrefix,
      this.purchaseNo,
      this.purNoSuffix,
      this.purNoFormalDigit,
      this.salesNoPrefix,
      this.salesNo,
      this.salesNoSuffix,
      this.salesNoFormalDigit,
      this.purNo2Prefix,
      this.purchaseNo2,
      this.purNo2Suffix,
      this.purNo2FormalDigit,
      this.purOrderNoPrefix,
      this.purchaseOderNo,
      this.purOrderNoSuffix,
      this.purOrderNoFormalDigit,
      this.purOrderNo2Prefix,
      this.purchaseOrderNo2,
      this.purOrderNo2Suffix,
      this.purOrderNo2FormalDigit,
      this.quoNoPrefix,
      this.quotationNo,
      this.quoNoSuffix,
      this.quoNoFormalDigit,
      this.quoNo2Prefix,
      this.quotationNo2,
      this.quoNo2FormalDigit,
      this.quoNo2Suffix,
      this.salesNo2Prefix,
      this.salesNo2,
      this.salesNo2Suffix,
      this.salesNo2FormalDigit,
      this.salesOrderNoPrefix,
      this.salesOrderNo,
      this.salesOrderNoFormalDigit,
      this.salesOrderNoSuffix});

  NumberInitialize.fromJson(Map<String, dynamic> json) {
    numCode = json['NumCode'];
    coCode = json['CoCode'];
    finYearCode = json['FinYearCode'];
    custIdPrefix = json['CustIdPrefix'];
    custId = json['CustId'];
    custIdSuffix = json['CustIdSuffix'];
    custIdFormalDigit = json['CustIdFormalDigit'];
    supIdPrefix = json['SupIdPrefix'];
    supId = json['SupId'];
    supIdSuffix = json['SupIdSuffix'];
    supIdFormalDigit = json['SupIdFormalDigit'];
    productIdPrefix = json['ProductIdPrefix'];
    productId = json['ProductId'];
    productIdFormalDigit = json['ProductIdFormalDigit'];
    purNoPrefix = json['PurNoPrefix'];
    purchaseNo = json['PurchaseNo'];
    purNoSuffix = json['PurNoSuffix'];
    purNoFormalDigit = json['PurNoFormalDigit'];
    salesNoPrefix = json['SalesNoPrefix'];
    salesNo = json['SalesNo'];
    salesNoSuffix = json['SalesNoSuffix'];
    salesNoFormalDigit = json['SalesNoFormalDigit'];
    purNo2Prefix = json['PurNo2Prefix'];
    purchaseNo2 = json['PurchaseNo2'];
    purNo2Suffix = json['PurNo2Suffix'];
    purNo2FormalDigit = json['PurNo2FormalDigit'];
    purOrderNoPrefix = json['PurOrderNoPrefix'];
    purchaseOderNo = json['PurchaseOderNo'];
    purOrderNoSuffix = json['PurOrderNoSuffix'];
    purOrderNoFormalDigit = json['PurOrderNoFormalDigit'];
    purOrderNo2Prefix = json['PurOrderNo2Prefix'];
    purchaseOrderNo2 = json['PurchaseOrderNo2'];
    purOrderNo2Suffix = json['PurOrderNo2Suffix'];
    purOrderNo2FormalDigit = json['PurOrderNo2FormalDigit'];
    quoNoPrefix = json['QuoNoPrefix'];
    quotationNo = json['QuotationNo'];
    quoNoSuffix = json['QuoNoSuffix'];
    quoNoFormalDigit = json['QuoNoFormalDigit'];
    quoNo2Prefix = json['QuoNo2Prefix'];
    quotationNo2 = json['QuotationNo2'];
    quoNo2FormalDigit = json['QuoNo2FormalDigit'];
    quoNo2Suffix = json['QuoNo2Suffix'];
    salesNo2Prefix = json['SalesNo2Prefix'];
    salesNo2 = json['SalesNo2'];
    salesNo2Suffix = json['SalesNo2Suffix'];
    salesNo2FormalDigit = json['SalesNo2FormalDigit'];
    salesOrderNoPrefix = json['SalesOrderNoPrefix'];
    salesOrderNo = json['SalesOrderNo'];
    salesOrderNoFormalDigit = json['SalesOrderNoFormalDigit'];
    salesOrderNoSuffix = json['SalesOrderNoSuffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NumCode'] = this.numCode;
    data['CoCode'] = this.coCode;
    data['FinYearCode'] = this.finYearCode;
    data['CustIdPrefix'] = this.custIdPrefix;
    data['CustId'] = this.custId;
    data['CustIdSuffix'] = this.custIdSuffix;
    data['CustIdFormalDigit'] = this.custIdFormalDigit;
    data['SupIdPrefix'] = this.supIdPrefix;
    data['SupId'] = this.supId;
    data['SupIdSuffix'] = this.supIdSuffix;
    data['SupIdFormalDigit'] = this.supIdFormalDigit;
    data['ProductIdPrefix'] = this.productIdPrefix;
    data['ProductId'] = this.productId;
    data['ProductIdFormalDigit'] = this.productIdFormalDigit;
    data['PurNoPrefix'] = this.purNoPrefix;
    data['PurchaseNo'] = this.purchaseNo;
    data['PurNoSuffix'] = this.purNoSuffix;
    data['PurNoFormalDigit'] = this.purNoFormalDigit;
    data['SalesNoPrefix'] = this.salesNoPrefix;
    data['SalesNo'] = this.salesNo;
    data['SalesNoSuffix'] = this.salesNoSuffix;
    data['SalesNoFormalDigit'] = this.salesNoFormalDigit;
    data['PurNo2Prefix'] = this.purNo2Prefix;
    data['PurchaseNo2'] = this.purchaseNo2;
    data['PurNo2Suffix'] = this.purNo2Suffix;
    data['PurNo2FormalDigit'] = this.purNo2FormalDigit;
    data['PurOrderNoPrefix'] = this.purOrderNoPrefix;
    data['PurchaseOderNo'] = this.purchaseOderNo;
    data['PurOrderNoSuffix'] = this.purOrderNoSuffix;
    data['PurOrderNoFormalDigit'] = this.purOrderNoFormalDigit;
    data['PurOrderNo2Prefix'] = this.purOrderNo2Prefix;
    data['PurchaseOrderNo2'] = this.purchaseOrderNo2;
    data['PurOrderNo2Suffix'] = this.purOrderNo2Suffix;
    data['PurOrderNo2FormalDigit'] = this.purOrderNo2FormalDigit;
    data['QuoNoPrefix'] = this.quoNoPrefix;
    data['QuotationNo'] = this.quotationNo;
    data['QuoNoSuffix'] = this.quoNoSuffix;
    data['QuoNoFormalDigit'] = this.quoNoFormalDigit;
    data['QuoNo2Prefix'] = this.quoNo2Prefix;
    data['QuotationNo2'] = this.quotationNo2;
    data['QuoNo2FormalDigit'] = this.quoNo2FormalDigit;
    data['QuoNo2Suffix'] = this.quoNo2Suffix;
    data['SalesNo2Prefix'] = this.salesNo2Prefix;
    data['SalesNo2'] = this.salesNo2;
    data['SalesNo2Suffix'] = this.salesNo2Suffix;
    data['SalesNo2FormalDigit'] = this.salesNo2FormalDigit;
    data['SalesOrderNoPrefix'] = this.salesOrderNoPrefix;
    data['SalesOrderNo'] = this.salesOrderNo;
    data['SalesOrderNoFormalDigit'] = this.salesOrderNoFormalDigit;
    data['SalesOrderNoSuffix'] = this.salesOrderNoSuffix;
    return data;
  }
}

class Salespersons {
  dynamic salPersonCode;
  String? salPersonId;
  String? salPersonName;
  dynamic salPersonCommPercent;
  String? salPersonMobileNo;
  String? createdUserCode;
  String? createdDate;
  String? updatedUserCode;
  dynamic activeStatus;

  Salespersons(
      {this.salPersonCode,
      this.salPersonId,
      this.salPersonName,
      this.salPersonCommPercent,
      this.salPersonMobileNo,
      this.createdUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.activeStatus});

  Salespersons.fromJson(Map<String, dynamic> json) {
    salPersonCode = json['SalPersonCode'];
    salPersonId = json['SalPersonId'];
    salPersonName = json['SalPersonName'];
    salPersonCommPercent = json['SalPersonCommPercent'];
    salPersonMobileNo = json['SalPersonMobileNo'];
    createdUserCode = json['CreatedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalPersonCode'] = this.salPersonCode;
    data['SalPersonId'] = this.salPersonId;
    data['SalPersonName'] = this.salPersonName;
    data['SalPersonCommPercent'] = this.salPersonCommPercent;
    data['SalPersonMobileNo'] = this.salPersonMobileNo;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class Suppliers {
  dynamic supCode;
  String? supId;
  String? supName;
  dynamic supGroupCode;
  dynamic supAreaCode;
  dynamic supStateCode;
  dynamic supCountryCode;
  String? supAddress1;
  Null? supAddress2;
  Null? supAddress3;
  Null? supAddress4;
  Null? supAddress5;
  String? supPinCode;
  String? supMobileNo;
  Null? supPhoneNo;
  Null? supWhatsappNo;
  String? supEmailId;
  String? supLicenseNo;
  String? supPanNo;
  String? supGSTINNo;
  dynamic supGSTType;
  dynamic taxIsIncluded;
  String? supCreatedDate;
  dynamic createdUserCode;
  String? suptUpdatedDate;
  Null? updatedUserCode;
  dynamic supActiveStatus;

  Suppliers(
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

  Suppliers.fromJson(Map<String, dynamic> json) {
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

class SupplierGroups {
  dynamic supGroupCode;
  String? supGroupName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  SupplierGroups(
      {this.supGroupCode,
      this.supGroupName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  SupplierGroups.fromJson(Map<String, dynamic> json) {
    supGroupCode = json['SupGroupCode'];
    supGroupName = json['SupGroupName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SupGroupCode'] = this.supGroupCode;
    data['SupGroupName'] = this.supGroupName;
    data['CratedUserCode'] = this.cratedUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}

class TaxMasters {
  dynamic taxCode;
  String? taxId;
  String? taxName;
  dynamic taxPercentage;
  dynamic taxType;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  dynamic activeStatus;

  TaxMasters(
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

  TaxMasters.fromJson(Map<String, dynamic> json) {
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

class Units {
  dynamic unitCode;
  String? unitId;
  String? unitName;
  dynamic activStatus;

  Units({this.unitCode, this.unitId, this.unitName, this.activStatus});

  Units.fromJson(Map<String, dynamic> json) {
    unitCode = json['UnitCode'];
    unitId = json['UnitId'];
    unitName = json['UnitName'];
    activStatus = json['ActivStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UnitCode'] = this.unitCode;
    data['UnitId'] = this.unitId;
    data['UnitName'] = this.unitName;
    data['ActivStatus'] = this.activStatus;
    return data;
  }
}

class Users {
  dynamic userCode;
  String? userId;
  String? userName;
  String? userPassword;
  dynamic userType;
  dynamic activeStatus;
  String? userCreateDate;
  String? userLoginDate;

  Users(
      {this.userCode,
      this.userId,
      this.userName,
      this.userPassword,
      this.userType,
      this.activeStatus,
      this.userCreateDate,
      this.userLoginDate});

  Users.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    userId = json['UserId'];
    userName = json['UserName'];
    userPassword = json['UserPassword'];
    userType = json['UserType'];
    activeStatus = json['ActiveStatus'];
    userCreateDate = json['UserCreateDate'];
    userLoginDate = json['UserLoginDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserCode'] = this.userCode;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['UserPassword'] = this.userPassword;
    data['UserType'] = this.userType;
    data['ActiveStatus'] = this.activeStatus;
    data['UserCreateDate'] = this.userCreateDate;
    data['UserLoginDate'] = this.userLoginDate;
    return data;
  }
}

class States {
  dynamic stateCode;
  String? stateId;
  String? stateName;
  dynamic countryCode;
  dynamic createdUserCode;
  dynamic activeStatus;

  States(
      {this.stateCode,
      this.stateId,
      this.stateName,
      this.countryCode,
      this.createdUserCode,
      this.activeStatus});

  States.fromJson(Map<String, dynamic> json) {
    stateCode = json['StateCode'];
    stateId = json['StateId'];
    stateName = json['StateName'];
    countryCode = json['CountryCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.stateCode;
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    data['CountryCode'] = this.countryCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
