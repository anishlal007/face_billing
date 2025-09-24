class PurchaseMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  PurchaseMasterListModel({this.status, this.message, this.info});

  PurchaseMasterListModel.fromJson(Map<String, dynamic> json) {
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
  String? purchaseNo;
  String? purchaseDate;
  String? invoiceNo;
  String? invoiceDate;
  int? paymentType;
  String? supCode;
  String? supName;
  String? purchaseOrderNo;
  String? purchaseOrderDate;
  int? purchaseTaxableAmount;
  int? purchaseGstAmount;
  int? purchaseNetAmount;
  int? subTotalBeforeDiscount;
  int? sGSTAmount;
  int? cGSTAmount;
  int? iGSTAmount;
  double? roundOffAmount;
  int? supDueDays;
  int? purchaseEntryType;
  int? purchaseEntryMode;
  int? paidAmount;
  int? taxType;
  int? supGstType;
  int? createUserCode;
  String? createDateTime;
  String? computerName;
  String? vehicleNo;
  String? finYearCode;
  int? coCode;
  String? purchaseNotes;
  int? purchaseAccCode;
  int? purchaseDiscoutPercentage;
  int? purchaseDiscountValue;
  int? cashDiscountPercentage;
  int? cashDiscountValue;
  int? frieghtChargesAddWithTotal;
  int? frieghtChargesAddWithoutTotal;
  List<Details>? details;

  Info(
      {this.purchaseNo,
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
      this.frieghtChargesAddWithoutTotal,
      this.details});

  Info.fromJson(Map<String, dynamic> json) {
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
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? purchaseNo;
  String? purchaseDate;
  String? purchaseOrderNo;
  int? supCode;
  int? itemCode;
  String? itemID;
  int? itemGroupCode;
  int? itemMakeCode;
  int? itemGenericCode;
  String? barCodeId;
  String? itemName;
  Null? batchNo;
  String? mFGDate;
  String? expiryDate;
  int? hsnCode;
  int? gstPercentage;
  int? itemQuantity;
  int? freeQuantity;
  int? itemUnitCode;
  int? subQuantity;
  int? subQtyUnitCode;
  int? subQtyPurchaseRate;
  Null? decimalDigits;
  int? itemPurchaseRate;
  double? purchaseRateBeforeTax;
  int? itemDiscountPercentage;
  int? itemDiscountValue;
  int? itemGstValue;
  int? itemValue;
  double? actualPurchaseRate;
  int? itemSaleRate;
  int? itemMRPRate;
  int? itemSGSTPercentage;
  int? itemCGSTPercentage;
  int? itemIGSTPercentage;
  int? itemSGSTAmount;
  int? itemCGSTAmount;
  int? itemIGSTAmount;
  int? purchaseEntryMode;
  int? purchaseEntryType;
  int? createdUserCode;
  String? createdDate;
  Null? updatedUserCode;
  Null? updatedDate;
  int? coCode;
  String? computerName;
  String? finYearCode;
  int? stockRequiredEffect;

  Details(
      {this.purchaseNo,
      this.purchaseDate,
      this.purchaseOrderNo,
      this.supCode,
      this.itemCode,
      this.itemID,
      this.itemGroupCode,
      this.itemMakeCode,
      this.itemGenericCode,
      this.barCodeId,
      this.itemName,
      this.batchNo,
      this.mFGDate,
      this.expiryDate,
      this.hsnCode,
      this.gstPercentage,
      this.itemQuantity,
      this.freeQuantity,
      this.itemUnitCode,
      this.subQuantity,
      this.subQtyUnitCode,
      this.subQtyPurchaseRate,
      this.decimalDigits,
      this.itemPurchaseRate,
      this.purchaseRateBeforeTax,
      this.itemDiscountPercentage,
      this.itemDiscountValue,
      this.itemGstValue,
      this.itemValue,
      this.actualPurchaseRate,
      this.itemSaleRate,
      this.itemMRPRate,
      this.itemSGSTPercentage,
      this.itemCGSTPercentage,
      this.itemIGSTPercentage,
      this.itemSGSTAmount,
      this.itemCGSTAmount,
      this.itemIGSTAmount,
      this.purchaseEntryMode,
      this.purchaseEntryType,
      this.createdUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.coCode,
      this.computerName,
      this.finYearCode,
      this.stockRequiredEffect});

  Details.fromJson(Map<String, dynamic> json) {
    purchaseNo = json['PurchaseNo'];
    purchaseDate = json['PurchaseDate'];
    purchaseOrderNo = json['PurchaseOrderNo'];
    supCode = json['SupCode'];
    itemCode = json['ItemCode'];
    itemID = json['ItemID'];
    itemGroupCode = json['ItemGroupCode'];
    itemMakeCode = json['ItemMakeCode'];
    itemGenericCode = json['ItemGenericCode'];
    barCodeId = json['BarCodeId'];
    itemName = json['ItemName'];
    batchNo = json['BatchNo'];
    mFGDate = json['MFGDate'];
    expiryDate = json['ExpiryDate'];
    hsnCode = json['HsnCode'];
    gstPercentage = json['GstPercentage'];
    itemQuantity = json['ItemQuantity'];
    freeQuantity = json['FreeQuantity'];
    itemUnitCode = json['ItemUnitCode'];
    subQuantity = json['SubQuantity'];
    subQtyUnitCode = json['SubQtyUnitCode'];
    subQtyPurchaseRate = json['SubQtyPurchaseRate'];
    decimalDigits = json['DecimalDigits'];
    itemPurchaseRate = json['ItemPurchaseRate'];
    purchaseRateBeforeTax = json['PurchaseRateBeforeTax'];
    itemDiscountPercentage = json['ItemDiscountPercentage'];
    itemDiscountValue = json['ItemDiscountValue'];
    itemGstValue = json['ItemGstValue'];
    itemValue = json['ItemValue'];
    actualPurchaseRate = json['ActualPurchaseRate'];
    itemSaleRate = json['ItemSaleRate'];
    itemMRPRate = json['ItemMRPRate'];
    itemSGSTPercentage = json['ItemSGSTPercentage'];
    itemCGSTPercentage = json['ItemCGSTPercentage'];
    itemIGSTPercentage = json['ItemIGSTPercentage'];
    itemSGSTAmount = json['ItemSGSTAmount'];
    itemCGSTAmount = json['ItemCGSTAmount'];
    itemIGSTAmount = json['ItemIGSTAmount'];
    purchaseEntryMode = json['PurchaseEntryMode'];
    purchaseEntryType = json['PurchaseEntryType'];
    createdUserCode = json['CreatedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    coCode = json['CoCode'];
    computerName = json['ComputerName'];
    finYearCode = json['FinYearCode'];
    stockRequiredEffect = json['StockRequiredEffect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PurchaseNo'] = this.purchaseNo;
    data['PurchaseDate'] = this.purchaseDate;
    data['PurchaseOrderNo'] = this.purchaseOrderNo;
    data['SupCode'] = this.supCode;
    data['ItemCode'] = this.itemCode;
    data['ItemID'] = this.itemID;
    data['ItemGroupCode'] = this.itemGroupCode;
    data['ItemMakeCode'] = this.itemMakeCode;
    data['ItemGenericCode'] = this.itemGenericCode;
    data['BarCodeId'] = this.barCodeId;
    data['ItemName'] = this.itemName;
    data['BatchNo'] = this.batchNo;
    data['MFGDate'] = this.mFGDate;
    data['ExpiryDate'] = this.expiryDate;
    data['HsnCode'] = this.hsnCode;
    data['GstPercentage'] = this.gstPercentage;
    data['ItemQuantity'] = this.itemQuantity;
    data['FreeQuantity'] = this.freeQuantity;
    data['ItemUnitCode'] = this.itemUnitCode;
    data['SubQuantity'] = this.subQuantity;
    data['SubQtyUnitCode'] = this.subQtyUnitCode;
    data['SubQtyPurchaseRate'] = this.subQtyPurchaseRate;
    data['DecimalDigits'] = this.decimalDigits;
    data['ItemPurchaseRate'] = this.itemPurchaseRate;
    data['PurchaseRateBeforeTax'] = this.purchaseRateBeforeTax;
    data['ItemDiscountPercentage'] = this.itemDiscountPercentage;
    data['ItemDiscountValue'] = this.itemDiscountValue;
    data['ItemGstValue'] = this.itemGstValue;
    data['ItemValue'] = this.itemValue;
    data['ActualPurchaseRate'] = this.actualPurchaseRate;
    data['ItemSaleRate'] = this.itemSaleRate;
    data['ItemMRPRate'] = this.itemMRPRate;
    data['ItemSGSTPercentage'] = this.itemSGSTPercentage;
    data['ItemCGSTPercentage'] = this.itemCGSTPercentage;
    data['ItemIGSTPercentage'] = this.itemIGSTPercentage;
    data['ItemSGSTAmount'] = this.itemSGSTAmount;
    data['ItemCGSTAmount'] = this.itemCGSTAmount;
    data['ItemIGSTAmount'] = this.itemIGSTAmount;
    data['PurchaseEntryMode'] = this.purchaseEntryMode;
    data['PurchaseEntryType'] = this.purchaseEntryType;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['CoCode'] = this.coCode;
    data['ComputerName'] = this.computerName;
    data['FinYearCode'] = this.finYearCode;
    data['StockRequiredEffect'] = this.stockRequiredEffect;
    return data;
  }
}
