class AddSalesReqModel {
  String? salesNo;
  String? salesDate;
  String? salesOrderNo;
  String? salesOrderDate;
  int? receiptType;
  int? custCode;
  int? salesTaxableAmount;
  int? salesGstAmount;
  double? sGSTAmount;
  double? iGSTAmount;
  double? cGSTAmount;
  int? salesNetAmount;
  int? subTotalBeforeDiscount;
  int? salesEntryType;
  int? salesEntryMode;
  int? createdUserCode;
  String? createdDateTime;
  String? computerName;
  String? finYearCode;
  int? coCode;
  int? salesAccCode;
  String? latitude;
  String? longtitude;
  int? basedOnEntry;
  String? basedOnEntryNo;
  String? basedOnEntryDate;
  int? cashAmount;
  int? creditAmount;
  int? chequeAmount;
  int? cardAmount;
  int? freeAmount;
  int? walletAmount;
  double? roundOffAmount;
  double? receivedAmount;
  int? advanceReceivedAmount;
  String? advanceReceiptNo;
  String? updatedUserCode;
  int? salesDiscoutPercentage;
  int? cashDiscountPercentage;
  int? cashDiscountValue;
  int? salesDiscountValue;
  int? frieghtChargesAddWithTotal;
  int? frieghtChargesAddWithoutTotal;
  String? taxType;
  List<Details>? details;

  AddSalesReqModel(
      {this.salesNo,
      this.salesDate,
      this.salesOrderNo,
      this.salesOrderDate,
      this.receiptType,
      this.custCode,
      this.salesTaxableAmount,
      this.salesGstAmount,
      this.sGSTAmount,
      this.iGSTAmount,
      this.cGSTAmount,
      this.salesNetAmount,
      this.subTotalBeforeDiscount,
      this.salesEntryType,
      this.salesEntryMode,
      this.createdUserCode,
      this.createdDateTime,
      this.computerName,
      this.finYearCode,
      this.coCode,
      this.salesAccCode,
      this.latitude,
      this.longtitude,
      this.basedOnEntry,
      this.basedOnEntryNo,
      this.basedOnEntryDate,
      this.cashAmount,
      this.creditAmount,
      this.chequeAmount,
      this.cardAmount,
      this.freeAmount,
      this.walletAmount,
      this.roundOffAmount,
      this.receivedAmount,
      this.advanceReceivedAmount,
      this.advanceReceiptNo,
      this.updatedUserCode,
      this.salesDiscoutPercentage,
      this.cashDiscountPercentage,
      this.cashDiscountValue,
      this.salesDiscountValue,
      this.frieghtChargesAddWithTotal,
      this.frieghtChargesAddWithoutTotal,
      this.taxType,
      this.details});

  AddSalesReqModel.fromJson(Map<String, dynamic> json) {
    salesNo = json['SalesNo'];
    salesDate = json['SalesDate'];
    salesOrderNo = json['SalesOrderNo'];
    salesOrderDate = json['SalesOrderDate'];
    receiptType = json['ReceiptType'];
    custCode = json['CustCode'];
    salesTaxableAmount = json['SalesTaxableAmount'];
    salesGstAmount = json['SalesGstAmount'];
    sGSTAmount = json['SGSTAmount'];
    iGSTAmount = json['IGSTAmount'];
    cGSTAmount = json['CGSTAmount'];
    salesNetAmount = json['SalesNetAmount'];
    subTotalBeforeDiscount = json['SubTotalBeforeDiscount'];
    salesEntryType = json['SalesEntryType'];
    salesEntryMode = json['SalesEntryMode'];
    createdUserCode = json['CreatedUserCode'];
    createdDateTime = json['CreatedDateTime'];
    computerName = json['ComputerName'];
    finYearCode = json['FinYearCode'];
    coCode = json['CoCode'];
    salesAccCode = json['SalesAccCode'];
    latitude = json['Latitude'];
    longtitude = json['longtitude'];
    basedOnEntry = json['BasedOnEntry'];
    basedOnEntryNo = json['BasedOnEntryNo'];
    basedOnEntryDate = json['BasedOnEntryDate'];
    cashAmount = json['CashAmount'];
    creditAmount = json['CreditAmount'];
    chequeAmount = json['ChequeAmount'];
    cardAmount = json['CardAmount'];
    freeAmount = json['FreeAmount'];
    walletAmount = json['WalletAmount'];
    roundOffAmount = json['RoundOffAmount'];
    receivedAmount = json['ReceivedAmount'];
    advanceReceivedAmount = json['AdvanceReceivedAmount'];
    advanceReceiptNo = json['AdvanceReceiptNo'];
    updatedUserCode = json['UpdatedUserCode'];
    salesDiscoutPercentage = json['SalesDiscoutPercentage'];
    cashDiscountPercentage = json['CashDiscountPercentage'];
    cashDiscountValue = json['CashDiscountValue'];
    salesDiscountValue = json['SalesDiscountValue'];
    frieghtChargesAddWithTotal = json['FrieghtChargesAddWithTotal'];
    frieghtChargesAddWithoutTotal = json['FrieghtChargesAddWithoutTotal'];
    taxType = json['TaxType'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SalesNo'] = this.salesNo;
    data['SalesDate'] = this.salesDate;
    data['SalesOrderNo'] = this.salesOrderNo;
    data['SalesOrderDate'] = this.salesOrderDate;
    data['ReceiptType'] = this.receiptType;
    data['CustCode'] = this.custCode;
    data['SalesTaxableAmount'] = this.salesTaxableAmount;
    data['SalesGstAmount'] = this.salesGstAmount;
    data['SGSTAmount'] = this.sGSTAmount;
    data['IGSTAmount'] = this.iGSTAmount;
    data['CGSTAmount'] = this.cGSTAmount;
    data['SalesNetAmount'] = this.salesNetAmount;
    data['SubTotalBeforeDiscount'] = this.subTotalBeforeDiscount;
    data['SalesEntryType'] = this.salesEntryType;
    data['SalesEntryMode'] = this.salesEntryMode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['CreatedDateTime'] = this.createdDateTime;
    data['ComputerName'] = this.computerName;
    data['FinYearCode'] = this.finYearCode;
    data['CoCode'] = this.coCode;
    data['SalesAccCode'] = this.salesAccCode;
    data['Latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['BasedOnEntry'] = this.basedOnEntry;
    data['BasedOnEntryNo'] = this.basedOnEntryNo;
    data['BasedOnEntryDate'] = this.basedOnEntryDate;
    data['CashAmount'] = this.cashAmount;
    data['CreditAmount'] = this.creditAmount;
    data['ChequeAmount'] = this.chequeAmount;
    data['CardAmount'] = this.cardAmount;
    data['FreeAmount'] = this.freeAmount;
    data['WalletAmount'] = this.walletAmount;
    data['RoundOffAmount'] = this.roundOffAmount;
    data['ReceivedAmount'] = this.receivedAmount;
    data['AdvanceReceivedAmount'] = this.advanceReceivedAmount;
    data['AdvanceReceiptNo'] = this.advanceReceiptNo;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['SalesDiscoutPercentage'] = this.salesDiscoutPercentage;
    data['CashDiscountPercentage'] = this.cashDiscountPercentage;
    data['CashDiscountValue'] = this.cashDiscountValue;
    data['SalesDiscountValue'] = this.salesDiscountValue;
    data['FrieghtChargesAddWithTotal'] = this.frieghtChargesAddWithTotal;
    data['FrieghtChargesAddWithoutTotal'] = this.frieghtChargesAddWithoutTotal;
    data['TaxType'] = this.taxType;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? itemCode;
  int? itemID;
  String? itemNotes;
  int? itemGroupCode;
  int? itemMakeCode;
  int? itemGenericCode;
  String? barCodeId;
  String? itemName;
  String? batchNo;
  String? mFGDate;
  String? expiryDate;
  String? hsnCode;
  int? gstPercentage;
  int? itemQuantity;
  int? freeQuantity;
  int? itemUnitCode;
  int? subQuantity;
  int? subQtyUnitCode;
  int? subQtySalesRate;
  int? decimalDigits;
  int? itemSalesRate;
  double? salesRateBeforeTax;
  int? itemDiscountPercentage;
  int? itemDiscountValue;
  int? itemGstValue;
  int? itemValue;
  int? actualSalesRate;
  int? itemMRPRate;
  int? itemPurchaseRate;
  int? actualPurchaseRate;
  String? purchaseNo;
  int? purchaseFinyearCode;
  int? purchaseEntryMode;
  int? itemSGSTPercentage;
  int? itemCGSTPercentage;
  int? itemIGSTPercentage;
  int? itemSGSTAmount;
  int? itemCGSTAmount;
  int? itemIGSTAmount;
  int? salesEntryMode;
  int? salesEntryType;
  int? createdUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  String? coCode;
  String? computerName;
  String? finYearCode;
  int? stockRequiredEffect;
  int? itemProfitPercentage;
  int? itemProfitValue;
  int? itemRowOrderNo;
  int? purchaseSupCode;
  int? salesPersonCode;

  Details(
      {this.itemCode,
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
      this.itemSalesRate,
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
      this.itemProfitPercentage,
      this.itemProfitValue,
      this.itemRowOrderNo,
      this.purchaseSupCode,
      this.salesPersonCode});

  Details.fromJson(Map<String, dynamic> json) {
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
    itemSalesRate = json['ItemSalesRate'];
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
    itemProfitPercentage = json['ItemProfitPercentage'];
    itemProfitValue = json['ItemProfitValue'];
    itemRowOrderNo = json['ItemRowOrderNo'];
    purchaseSupCode = json['PurchaseSupCode'];
    salesPersonCode = json['SalesPersonCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['ItemSalesRate'] = this.itemSalesRate;
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
    data['ItemProfitPercentage'] = this.itemProfitPercentage;
    data['ItemProfitValue'] = this.itemProfitValue;
    data['ItemRowOrderNo'] = this.itemRowOrderNo;
    data['PurchaseSupCode'] = this.purchaseSupCode;
    data['SalesPersonCode'] = this.salesPersonCode;
    return data;
  }
}
