class AddPurchaseMasterModel {
  String? purchaseDate;
  String? invoiceNo;
  String? invoiceDate;
  dynamic paymentType;
  dynamic supCode;
  String? supName;
  String? purchaseOrderNo;
  String? purchaseOrderDate;
  dynamic purchaseTaxableAmount;
  dynamic purchaseGstAmount;
  dynamic purchaseNetAmount;
  dynamic subTotalBeforeDiscount;
  dynamic sGSTAmount;
  dynamic cGSTAmount;
  dynamic iGSTAmount;
  double? roundOffAmount;
  dynamic supDueDays;
  dynamic purchaseEntryType;
  dynamic purchaseEntryMode;
  dynamic paidAmount;
  dynamic taxType;
  dynamic supGstType;
  dynamic createUserCode;
  String? createDateTime;
  String? computerName;
  String? vehicleNo;
  String? finYearCode;
  dynamic coCode;
  String? purchaseNotes;
  dynamic purchaseAccCode;
  dynamic purchaseDiscoutPercentage;
  dynamic purchaseDiscountValue;
  dynamic cashDiscountPercentage;
  dynamic cashDiscountValue;
  dynamic frieghtChargesAddWithTotal;
  dynamic frieghtChargesAddWithoutTotal;
  List<Items>? items;

  AddPurchaseMasterModel(
      {this.purchaseDate,
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
      this.items});

  AddPurchaseMasterModel.fromJson(Map<String, dynamic> json) {
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
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  dynamic itemCode;
  String? itemID;
  String? itemName;
  dynamic itemGroupCode;
  dynamic itemMakeCode;
  dynamic itemGenericCode;
  String? barCodeId;
  String? batchNo;
  String? mFGDate;
  String? expiryDate;
  dynamic hsnCode;
  dynamic gstPercentage;
  dynamic itemQuantity;
  dynamic freeQuantity;
  dynamic itemUnitCode;
  dynamic subQuantity;
  dynamic subQtyUnitCode;
  dynamic subQtyPurchaseRate;
  dynamic itemPurchaseRate;
  double? purchaseRateBeforeTax;
  dynamic itemDiscountPercentage;
  dynamic itemDiscountValue;
  dynamic itemGstValue;
  dynamic itemValue;
  double? actualPurchaseRate;
  dynamic itemSaleRate;
  dynamic itemMRPRate;
  dynamic itemSGSTPercentage;
  dynamic itemCGSTPercentage;
  dynamic itemIGSTPercentage;
  dynamic itemSGSTAmount;
  dynamic itemCGSTAmount;
  dynamic itemIGSTAmount;
  dynamic purchaseEntryMode;
  dynamic purchaseEntryType;
  dynamic createdUserCode;
  String? createdDate;
  Null? updatedUserCode;
  Null? updatedDate;
  dynamic coCode;
  String? computerName;
  String? finYearCode;
  dynamic stockRequiredEffect;

  Items(
      {this.itemCode,
      this.itemID,
      this.itemName,
      this.itemGroupCode,
      this.itemMakeCode,
      this.itemGenericCode,
      this.barCodeId,
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

  Items.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemID = json['ItemID'];
    itemName = json['ItemName'];
    itemGroupCode = json['ItemGroupCode'];
    itemMakeCode = json['ItemMakeCode'];
    itemGenericCode = json['ItemGenericCode'];
    barCodeId = json['BarCodeId'];
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
    data['ItemCode'] = this.itemCode;
    data['ItemID'] = this.itemID;
    data['ItemName'] = this.itemName;
    data['ItemGroupCode'] = this.itemGroupCode;
    data['ItemMakeCode'] = this.itemMakeCode;
    data['ItemGenericCode'] = this.itemGenericCode;
    data['BarCodeId'] = this.barCodeId;
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
