class GetSalesListModel {
  bool? status;
  String? message;
  List<Info>? info;

  GetSalesListModel({this.status, this.message, this.info});

  GetSalesListModel.fromJson(Map<String, dynamic> json) {
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
  int? salesCode;
  String? salesNo;
  String? salesDate;
  String? salesOrderNo;
  String? salesOrderDate;
  String? receiptType;
  String? custCode;
  String? salesTaxableAmount;
  String? salesGstAmount;
  String? salesNetAmount;
  String? subTotalBeforeDiscount;
  String? sGSTAmount;
  String? cGSTAmount;
  String? iGSTAmount;
  String? roundOffAmount;
  Null? custCreditDays;
  String? salesEntryType;
  String? salesEntryMode;
  String? receivedAmount;
  String? advanceReceivedAmount;
  String? advanceReceiptNo;
  String? taxType;
  Null? custGstType;
  String? createdUserCode;
  String? createdDateTime;
  String? updatedUserCode;
  String? updatedDateTime;
  String? computerName;
  Null? vehicleNo;
  String? finYearCode;
  String? coCode;
  Null? salesNotes;
  String? salesAccCode;
  String? salesDiscoutPercentage;
  String? salesDiscountValue;
  String? cashDiscountPercentage;
  String? cashDiscountValue;
  String? frieghtChargesAddWithTotal;
  String? frieghtChargesAddWithoutTotal;
  Null? salesPersonCode;
  Null? doctorCode;
  String? latitude;
  String? longtitude;
  Null? nextDueDate;
  Null? holdSaveEntry;
  Null? holdSaveEntryNo;
  Null? counterCode;
  String? cashAmount;
  String? creditAmount;
  String? chequeAmount;
  String? cardAmount;
  String? freeAmount;
  String? walletAmount;
  String? basedOnEntry;
  String? basedOnEntryNo;
  String? basedOnEntryDate;
  List<Details>? details;

  Info(
      {this.salesCode,
      this.salesNo,
      this.salesDate,
      this.salesOrderNo,
      this.salesOrderDate,
      this.receiptType,
      this.custCode,
      this.salesTaxableAmount,
      this.salesGstAmount,
      this.salesNetAmount,
      this.subTotalBeforeDiscount,
      this.sGSTAmount,
      this.cGSTAmount,
      this.iGSTAmount,
      this.roundOffAmount,
      this.custCreditDays,
      this.salesEntryType,
      this.salesEntryMode,
      this.receivedAmount,
      this.advanceReceivedAmount,
      this.advanceReceiptNo,
      this.taxType,
      this.custGstType,
      this.createdUserCode,
      this.createdDateTime,
      this.updatedUserCode,
      this.updatedDateTime,
      this.computerName,
      this.vehicleNo,
      this.finYearCode,
      this.coCode,
      this.salesNotes,
      this.salesAccCode,
      this.salesDiscoutPercentage,
      this.salesDiscountValue,
      this.cashDiscountPercentage,
      this.cashDiscountValue,
      this.frieghtChargesAddWithTotal,
      this.frieghtChargesAddWithoutTotal,
      this.salesPersonCode,
      this.doctorCode,
      this.latitude,
      this.longtitude,
      this.nextDueDate,
      this.holdSaveEntry,
      this.holdSaveEntryNo,
      this.counterCode,
      this.cashAmount,
      this.creditAmount,
      this.chequeAmount,
      this.cardAmount,
      this.freeAmount,
      this.walletAmount,
      this.basedOnEntry,
      this.basedOnEntryNo,
      this.basedOnEntryDate,
      this.details});

  Info.fromJson(Map<String, dynamic> json) {
    salesCode = json['SalesCode'];
    salesNo = json['SalesNo'];
    salesDate = json['SalesDate'];
    salesOrderNo = json['SalesOrderNo'];
    salesOrderDate = json['SalesOrderDate'];
    receiptType = json['ReceiptType'];
    custCode = json['CustCode'];
    salesTaxableAmount = json['SalesTaxableAmount'];
    salesGstAmount = json['SalesGstAmount'];
    salesNetAmount = json['SalesNetAmount'];
    subTotalBeforeDiscount = json['SubTotalBeforeDiscount'];
    sGSTAmount = json['SGSTAmount'];
    cGSTAmount = json['CGSTAmount'];
    iGSTAmount = json['IGSTAmount'];
    roundOffAmount = json['RoundOffAmount'];
    custCreditDays = json['CustCreditDays'];
    salesEntryType = json['SalesEntryType'];
    salesEntryMode = json['SalesEntryMode'];
    receivedAmount = json['ReceivedAmount'];
    advanceReceivedAmount = json['AdvanceReceivedAmount'];
    advanceReceiptNo = json['AdvanceReceiptNo'];
    taxType = json['TaxType'];
    custGstType = json['CustGstType'];
    createdUserCode = json['CreatedUserCode'];
    createdDateTime = json['CreatedDateTime'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDateTime = json['UpdatedDateTime'];
    computerName = json['ComputerName'];
    vehicleNo = json['VehicleNo'];
    finYearCode = json['FinYearCode'];
    coCode = json['CoCode'];
    salesNotes = json['SalesNotes'];
    salesAccCode = json['SalesAccCode'];
    salesDiscoutPercentage = json['SalesDiscoutPercentage'];
    salesDiscountValue = json['SalesDiscountValue'];
    cashDiscountPercentage = json['CashDiscountPercentage'];
    cashDiscountValue = json['CashDiscountValue'];
    frieghtChargesAddWithTotal = json['FrieghtChargesAddWithTotal'];
    frieghtChargesAddWithoutTotal = json['FrieghtChargesAddWithoutTotal'];
    salesPersonCode = json['SalesPersonCode'];
    doctorCode = json['DoctorCode'];
    latitude = json['Latitude'];
    longtitude = json['longtitude'];
    nextDueDate = json['NextDueDate'];
    holdSaveEntry = json['HoldSaveEntry'];
    holdSaveEntryNo = json['HoldSaveEntryNo'];
    counterCode = json['CounterCode'];
    cashAmount = json['CashAmount'];
    creditAmount = json['CreditAmount'];
    chequeAmount = json['ChequeAmount'];
    cardAmount = json['CardAmount'];
    freeAmount = json['FreeAmount'];
    walletAmount = json['WalletAmount'];
    basedOnEntry = json['BasedOnEntry'];
    basedOnEntryNo = json['BasedOnEntryNo'];
    basedOnEntryDate = json['BasedOnEntryDate'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalesCode'] = this.salesCode;
    data['SalesNo'] = this.salesNo;
    data['SalesDate'] = this.salesDate;
    data['SalesOrderNo'] = this.salesOrderNo;
    data['SalesOrderDate'] = this.salesOrderDate;
    data['ReceiptType'] = this.receiptType;
    data['CustCode'] = this.custCode;
    data['SalesTaxableAmount'] = this.salesTaxableAmount;
    data['SalesGstAmount'] = this.salesGstAmount;
    data['SalesNetAmount'] = this.salesNetAmount;
    data['SubTotalBeforeDiscount'] = this.subTotalBeforeDiscount;
    data['SGSTAmount'] = this.sGSTAmount;
    data['CGSTAmount'] = this.cGSTAmount;
    data['IGSTAmount'] = this.iGSTAmount;
    data['RoundOffAmount'] = this.roundOffAmount;
    data['CustCreditDays'] = this.custCreditDays;
    data['SalesEntryType'] = this.salesEntryType;
    data['SalesEntryMode'] = this.salesEntryMode;
    data['ReceivedAmount'] = this.receivedAmount;
    data['AdvanceReceivedAmount'] = this.advanceReceivedAmount;
    data['AdvanceReceiptNo'] = this.advanceReceiptNo;
    data['TaxType'] = this.taxType;
    data['CustGstType'] = this.custGstType;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDateTime'] = this.createdDateTime;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDateTime'] = this.updatedDateTime;
    data['ComputerName'] = this.computerName;
    data['VehicleNo'] = this.vehicleNo;
    data['FinYearCode'] = this.finYearCode;
    data['CoCode'] = this.coCode;
    data['SalesNotes'] = this.salesNotes;
    data['SalesAccCode'] = this.salesAccCode;
    data['SalesDiscoutPercentage'] = this.salesDiscoutPercentage;
    data['SalesDiscountValue'] = this.salesDiscountValue;
    data['CashDiscountPercentage'] = this.cashDiscountPercentage;
    data['CashDiscountValue'] = this.cashDiscountValue;
    data['FrieghtChargesAddWithTotal'] = this.frieghtChargesAddWithTotal;
    data['FrieghtChargesAddWithoutTotal'] = this.frieghtChargesAddWithoutTotal;
    data['SalesPersonCode'] = this.salesPersonCode;
    data['DoctorCode'] = this.doctorCode;
    data['Latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['NextDueDate'] = this.nextDueDate;
    data['HoldSaveEntry'] = this.holdSaveEntry;
    data['HoldSaveEntryNo'] = this.holdSaveEntryNo;
    data['CounterCode'] = this.counterCode;
    data['CashAmount'] = this.cashAmount;
    data['CreditAmount'] = this.creditAmount;
    data['ChequeAmount'] = this.chequeAmount;
    data['CardAmount'] = this.cardAmount;
    data['FreeAmount'] = this.freeAmount;
    data['WalletAmount'] = this.walletAmount;
    data['BasedOnEntry'] = this.basedOnEntry;
    data['BasedOnEntryNo'] = this.basedOnEntryNo;
    data['BasedOnEntryDate'] = this.basedOnEntryDate;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? salesNo;
  String? salesDate;
  String? salesOrderNo;
  String? custCode;
  String? itemCode;
  String? itemID;
  String? itemNotes;
  String? itemGroupCode;
  String? itemMakeCode;
  String? itemGenericCode;
  String? barCodeId;
  String? itemName;
  String? batchNo;
  String? mFGDate;
  String? expiryDate;
  String? hsnCode;
  String? gstPercentage;
  String? itemQuantity;
  String? freeQuantity;
  String? itemUnitCode;
  String? subQuantity;
  String? subQtyUnitCode;
  String? subQtySalesRate;
  String? decimalDigits;
  String? itemSaleRate;
  String? salesRateBeforeTax;
  String? itemDiscountPercentage;
  String? itemDiscountValue;
  String? itemGstValue;
  String? itemValue;
  String? actualSalesRate;
  String? itemMRPRate;
  String? itemPurchaseRate;
  String? actualPurchaseRate;
  String? purchaseNo;
  String? purchaseFinyearCode;
  String? purchaseEntryMode;
  String? itemSGSTPercentage;
  String? itemCGSTPercentage;
  String? itemIGSTPercentage;
  String? itemSGSTAmount;
  String? itemCGSTAmount;
  String? itemIGSTAmount;
  String? salesEntryMode;
  String? salesEntryType;
  String? createdUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  String? coCode;
  String? computerName;
  String? finYearCode;
  String? stockRequiredEffect;
  Null? counterCode;
  String? itemProfitPercentage;
  String? itemProfitValue;
  String? itemRowOrderNo;
  String? purchaseSupCode;
  String? salesPersonCode;

  Details(
      {this.salesNo,
      this.salesDate,
      this.salesOrderNo,
      this.custCode,
      this.itemCode,
      this.itemID,
      this.itemNotes,
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
      this.subQtySalesRate,
      this.decimalDigits,
      this.itemSaleRate,
      this.salesRateBeforeTax,
      this.itemDiscountPercentage,
      this.itemDiscountValue,
      this.itemGstValue,
      this.itemValue,
      this.actualSalesRate,
      this.itemMRPRate,
      this.itemPurchaseRate,
      this.actualPurchaseRate,
      this.purchaseNo,
      this.purchaseFinyearCode,
      this.purchaseEntryMode,
      this.itemSGSTPercentage,
      this.itemCGSTPercentage,
      this.itemIGSTPercentage,
      this.itemSGSTAmount,
      this.itemCGSTAmount,
      this.itemIGSTAmount,
      this.salesEntryMode,
      this.salesEntryType,
      this.createdUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.coCode,
      this.computerName,
      this.finYearCode,
      this.stockRequiredEffect,
      this.counterCode,
      this.itemProfitPercentage,
      this.itemProfitValue,
      this.itemRowOrderNo,
      this.purchaseSupCode,
      this.salesPersonCode});

  Details.fromJson(Map<String, dynamic> json) {
    salesNo = json['SalesNo'];
    salesDate = json['SalesDate'];
    salesOrderNo = json['SalesOrderNo'];
    custCode = json['CustCode'];
    itemCode = json['ItemCode'];
    itemID = json['ItemID'];
    itemNotes = json['ItemNotes'];
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
    subQtySalesRate = json['SubQtySalesRate'];
    decimalDigits = json['DecimalDigits'];
    itemSaleRate = json['ItemSaleRate'];
    salesRateBeforeTax = json['SalesRateBeforeTax'];
    itemDiscountPercentage = json['ItemDiscountPercentage'];
    itemDiscountValue = json['ItemDiscountValue'];
    itemGstValue = json['ItemGstValue'];
    itemValue = json['ItemValue'];
    actualSalesRate = json['ActualSalesRate'];
    itemMRPRate = json['ItemMRPRate'];
    itemPurchaseRate = json['ItemPurchaseRate'];
    actualPurchaseRate = json['ActualPurchaseRate'];
    purchaseNo = json['PurchaseNo'];
    purchaseFinyearCode = json['PurchaseFinyearCode'];
    purchaseEntryMode = json['PurchaseEntryMode'];
    itemSGSTPercentage = json['ItemSGSTPercentage'];
    itemCGSTPercentage = json['ItemCGSTPercentage'];
    itemIGSTPercentage = json['ItemIGSTPercentage'];
    itemSGSTAmount = json['ItemSGSTAmount'];
    itemCGSTAmount = json['ItemCGSTAmount'];
    itemIGSTAmount = json['ItemIGSTAmount'];
    salesEntryMode = json['SalesEntryMode'];
    salesEntryType = json['SalesEntryType'];
    createdUserCode = json['CreatedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    coCode = json['CoCode'];
    computerName = json['ComputerName'];
    finYearCode = json['FinYearCode'];
    stockRequiredEffect = json['StockRequiredEffect'];
    counterCode = json['CounterCode'];
    itemProfitPercentage = json['ItemProfitPercentage'];
    itemProfitValue = json['ItemProfitValue'];
    itemRowOrderNo = json['ItemRowOrderNo'];
    purchaseSupCode = json['PurchaseSupCode'];
    salesPersonCode = json['SalesPersonCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalesNo'] = this.salesNo;
    data['SalesDate'] = this.salesDate;
    data['SalesOrderNo'] = this.salesOrderNo;
    data['CustCode'] = this.custCode;
    data['ItemCode'] = this.itemCode;
    data['ItemID'] = this.itemID;
    data['ItemNotes'] = this.itemNotes;
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
    data['SubQtySalesRate'] = this.subQtySalesRate;
    data['DecimalDigits'] = this.decimalDigits;
    data['ItemSaleRate'] = this.itemSaleRate;
    data['SalesRateBeforeTax'] = this.salesRateBeforeTax;
    data['ItemDiscountPercentage'] = this.itemDiscountPercentage;
    data['ItemDiscountValue'] = this.itemDiscountValue;
    data['ItemGstValue'] = this.itemGstValue;
    data['ItemValue'] = this.itemValue;
    data['ActualSalesRate'] = this.actualSalesRate;
    data['ItemMRPRate'] = this.itemMRPRate;
    data['ItemPurchaseRate'] = this.itemPurchaseRate;
    data['ActualPurchaseRate'] = this.actualPurchaseRate;
    data['PurchaseNo'] = this.purchaseNo;
    data['PurchaseFinyearCode'] = this.purchaseFinyearCode;
    data['PurchaseEntryMode'] = this.purchaseEntryMode;
    data['ItemSGSTPercentage'] = this.itemSGSTPercentage;
    data['ItemCGSTPercentage'] = this.itemCGSTPercentage;
    data['ItemIGSTPercentage'] = this.itemIGSTPercentage;
    data['ItemSGSTAmount'] = this.itemSGSTAmount;
    data['ItemCGSTAmount'] = this.itemCGSTAmount;
    data['ItemIGSTAmount'] = this.itemIGSTAmount;
    data['SalesEntryMode'] = this.salesEntryMode;
    data['SalesEntryType'] = this.salesEntryType;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['CoCode'] = this.coCode;
    data['ComputerName'] = this.computerName;
    data['FinYearCode'] = this.finYearCode;
    data['StockRequiredEffect'] = this.stockRequiredEffect;
    data['CounterCode'] = this.counterCode;
    data['ItemProfitPercentage'] = this.itemProfitPercentage;
    data['ItemProfitValue'] = this.itemProfitValue;
    data['ItemRowOrderNo'] = this.itemRowOrderNo;
    data['PurchaseSupCode'] = this.purchaseSupCode;
    data['SalesPersonCode'] = this.salesPersonCode;
    return data;
  }
}
