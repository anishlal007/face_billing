class GetDashboardDetailModel {
  bool? status;
  String? message;
  Info? info;

  GetDashboardDetailModel({this.status, this.message, this.info});

  GetDashboardDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<Purchase>? purchase;
  Customers? customers;
  Suppliers? suppliers;
  Products? products;

  Info({this.purchase, this.customers, this.suppliers, this.products});

  Info.fromJson(Map<String, dynamic> json) {
    if (json['purchase'] != null) {
      purchase = <Purchase>[];
      json['purchase'].forEach((v) {
        purchase!.add(new Purchase.fromJson(v));
      });
    }
    customers = json['customers'] != null
        ? new Customers.fromJson(json['customers'])
        : null;
    suppliers = json['suppliers'] != null
        ? new Suppliers.fromJson(json['suppliers'])
        : null;
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchase != null) {
      data['purchase'] = this.purchase!.map((v) => v.toJson()).toList();
    }
    if (this.customers != null) {
      data['customers'] = this.customers!.toJson();
    }
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Purchase {
  int? purchaseID;
  String? purchaseNo;
  String? purchaseDate;
  String? invoiceNo;
  String? invoiceDate;
  String? paymentType;
  String? supCode;
  String? supName;
  String? purchaseOrderNo;
  String? purchaseOrderDate;
  String? purchaseTaxableAmount;
  String? purchaseGstAmount;
  String? purchaseNetAmount;
  String? subTotalBeforeDiscount;
  String? sGSTAmount;
  String? cGSTAmount;
  String? iGSTAmount;
  String? roundOffAmount;
  String? supDueDays;
  String? purchaseEntryType;
  String? purchaseEntryMode;
  String? paidAmount;
  String? taxType;
  String? supGstType;
  String? createUserCode;
  String? createDateTime;
  String? computerName;
  String? vehicleNo;
  String? finYearCode;
  String? coCode;
  String? purchaseNotes;
  String? purchaseAccCode;
  String? purchaseDiscoutPercentage;
  String? purchaseDiscountValue;
  String? cashDiscountPercentage;
  String? cashDiscountValue;
  String? frieghtChargesAddWithTotal;
  String? frieghtChargesAddWithoutTotal;

  Purchase(
      {this.purchaseID,
      this.purchaseNo,
      this.purchaseDate,
      this.invoiceNo,
      this.invoiceDate,
      this.paymentType,
      this.supCode,
      this.supName,
      this.purchaseOrderNo,
      this.purchaseOrderDate,
      this.purchaseTaxableAmount,
      this.purchaseGstAmount,
      this.purchaseNetAmount,
      this.subTotalBeforeDiscount,
      this.sGSTAmount,
      this.cGSTAmount,
      this.iGSTAmount,
      this.roundOffAmount,
      this.supDueDays,
      this.purchaseEntryType,
      this.purchaseEntryMode,
      this.paidAmount,
      this.taxType,
      this.supGstType,
      this.createUserCode,
      this.createDateTime,
      this.computerName,
      this.vehicleNo,
      this.finYearCode,
      this.coCode,
      this.purchaseNotes,
      this.purchaseAccCode,
      this.purchaseDiscoutPercentage,
      this.purchaseDiscountValue,
      this.cashDiscountPercentage,
      this.cashDiscountValue,
      this.frieghtChargesAddWithTotal,
      this.frieghtChargesAddWithoutTotal});

  Purchase.fromJson(Map<String, dynamic> json) {
    purchaseID = json['PurchaseID'];
    purchaseNo = json['PurchaseNo'];
    purchaseDate = json['PurchaseDate'];
    invoiceNo = json['InvoiceNo'];
    invoiceDate = json['InvoiceDate'];
    paymentType = json['PaymentType'];
    supCode = json['SupCode'];
    supName = json['SupName'];
    purchaseOrderNo = json['PurchaseOrderNo'];
    purchaseOrderDate = json['PurchaseOrderDate'];
    purchaseTaxableAmount = json['PurchaseTaxableAmount'];
    purchaseGstAmount = json['PurchaseGstAmount'];
    purchaseNetAmount = json['PurchaseNetAmount'];
    subTotalBeforeDiscount = json['SubTotalBeforeDiscount'];
    sGSTAmount = json['SGSTAmount'];
    cGSTAmount = json['CGSTAmount'];
    iGSTAmount = json['IGSTAmount'];
    roundOffAmount = json['RoundOffAmount'];
    supDueDays = json['SupDueDays'];
    purchaseEntryType = json['PurchaseEntryType'];
    purchaseEntryMode = json['PurchaseEntryMode'];
    paidAmount = json['PaidAmount'];
    taxType = json['TaxType'];
    supGstType = json['SupGstType'];
    createUserCode = json['CreateUserCode'];
    createDateTime = json['CreateDateTime'];
    computerName = json['ComputerName'];
    vehicleNo = json['VehicleNo'];
    finYearCode = json['FinYearCode'];
    coCode = json['CoCode'];
    purchaseNotes = json['PurchaseNotes'];
    purchaseAccCode = json['PurchaseAccCode'];
    purchaseDiscoutPercentage = json['PurchaseDiscoutPercentage'];
    purchaseDiscountValue = json['PurchaseDiscountValue'];
    cashDiscountPercentage = json['CashDiscountPercentage'];
    cashDiscountValue = json['CashDiscountValue'];
    frieghtChargesAddWithTotal = json['FrieghtChargesAddWithTotal'];
    frieghtChargesAddWithoutTotal = json['FrieghtChargesAddWithoutTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PurchaseID'] = this.purchaseID;
    data['PurchaseNo'] = this.purchaseNo;
    data['PurchaseDate'] = this.purchaseDate;
    data['InvoiceNo'] = this.invoiceNo;
    data['InvoiceDate'] = this.invoiceDate;
    data['PaymentType'] = this.paymentType;
    data['SupCode'] = this.supCode;
    data['SupName'] = this.supName;
    data['PurchaseOrderNo'] = this.purchaseOrderNo;
    data['PurchaseOrderDate'] = this.purchaseOrderDate;
    data['PurchaseTaxableAmount'] = this.purchaseTaxableAmount;
    data['PurchaseGstAmount'] = this.purchaseGstAmount;
    data['PurchaseNetAmount'] = this.purchaseNetAmount;
    data['SubTotalBeforeDiscount'] = this.subTotalBeforeDiscount;
    data['SGSTAmount'] = this.sGSTAmount;
    data['CGSTAmount'] = this.cGSTAmount;
    data['IGSTAmount'] = this.iGSTAmount;
    data['RoundOffAmount'] = this.roundOffAmount;
    data['SupDueDays'] = this.supDueDays;
    data['PurchaseEntryType'] = this.purchaseEntryType;
    data['PurchaseEntryMode'] = this.purchaseEntryMode;
    data['PaidAmount'] = this.paidAmount;
    data['TaxType'] = this.taxType;
    data['SupGstType'] = this.supGstType;
    data['CreateUserCode'] = this.createUserCode;
    data['CreateDateTime'] = this.createDateTime;
    data['ComputerName'] = this.computerName;
    data['VehicleNo'] = this.vehicleNo;
    data['FinYearCode'] = this.finYearCode;
    data['CoCode'] = this.coCode;
    data['PurchaseNotes'] = this.purchaseNotes;
    data['PurchaseAccCode'] = this.purchaseAccCode;
    data['PurchaseDiscoutPercentage'] = this.purchaseDiscoutPercentage;
    data['PurchaseDiscountValue'] = this.purchaseDiscountValue;
    data['CashDiscountPercentage'] = this.cashDiscountPercentage;
    data['CashDiscountValue'] = this.cashDiscountValue;
    data['FrieghtChargesAddWithTotal'] = this.frieghtChargesAddWithTotal;
    data['FrieghtChargesAddWithoutTotal'] = this.frieghtChargesAddWithoutTotal;
    return data;
  }
}

class Customers {
  int? activeCustomers;
  int? inactiveCustomers;
  List<CustomerList>? customerList;

  Customers({this.activeCustomers, this.inactiveCustomers, this.customerList});

  Customers.fromJson(Map<String, dynamic> json) {
    activeCustomers = json['active_customers'];
    inactiveCustomers = json['inactive_customers'];
    if (json['customer_list'] != null) {
      customerList = <CustomerList>[];
      json['customer_list'].forEach((v) {
        customerList!.add(new CustomerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_customers'] = this.activeCustomers;
    data['inactive_customers'] = this.inactiveCustomers;
    if (this.customerList != null) {
      data['customer_list'] =
          this.customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerList {
  int? custCode;
  String? custId;
  String? custName;
  String? custDOB;
  String? gender;
  String? custGroupCode;
  String? custAreaCode;
  String? custStateCode;
  String? custCountryCode;
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
  String? custGSTType;
  String? taxIsIncluded;
  String? custCreatedDate;
  String? createdUserCode;
  String? custUpdatedDate;
  String? updatedUserCode;
  String? custActiveStatus;

  CustomerList(
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

  CustomerList.fromJson(Map<String, dynamic> json) {
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

class Suppliers {
  int? activeSuppliers;
  int? inactiveSuppliers;
  List<SuppliersList>? suppliersList;

  Suppliers({this.activeSuppliers, this.inactiveSuppliers, this.suppliersList});

  Suppliers.fromJson(Map<String, dynamic> json) {
    activeSuppliers = json['active_suppliers'];
    inactiveSuppliers = json['inactive_suppliers'];
    if (json['suppliers_list'] != null) {
      suppliersList = <SuppliersList>[];
      json['suppliers_list'].forEach((v) {
        suppliersList!.add(new SuppliersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_suppliers'] = this.activeSuppliers;
    data['inactive_suppliers'] = this.inactiveSuppliers;
    if (this.suppliersList != null) {
      data['suppliers_list'] =
          this.suppliersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuppliersList {
  int? supCode;
  String? supId;
  String? supName;
  String? supGroupCode;
  String? supAreaCode;
  String? supStateCode;
  String? supCountryCode;
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
  String? supGSTType;
  String? taxIsIncluded;
  String? supCreatedDate;
  String? createdUserCode;
  String? suptUpdatedDate;
  Null? updatedUserCode;
  String? supActiveStatus;

  SuppliersList(
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

  SuppliersList.fromJson(Map<String, dynamic> json) {
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

class Products {
  int? pharmaProducts;
  int? opticalProducts;
  int? products;

  Products({this.pharmaProducts, this.opticalProducts, this.products});

  Products.fromJson(Map<String, dynamic> json) {
    pharmaProducts = json['pharmaProducts'];
    opticalProducts = json['opticalProducts'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pharmaProducts'] = this.pharmaProducts;
    data['opticalProducts'] = this.opticalProducts;
    data['products'] = this.products;
    return data;
  }
}
