class AddProductMasterModel {
  String? itemID;
  String? itemName;
  int? itemType;
  int? itemGroupCode;
  int? itemUnitCode;
  int? itemMakeCode;
  int? itemGenericCode;
  int? nonScheduleItem;
  int? scheduledH1Item;
  int? narcoticItem;
  String? expiryDateFormat;
  String? expiryDateRequired;
  int? subUnitCode;
  int? subQty;
  int? batchNoRequired;
  int? minimumStockQty;
  int? maximumStockQty;
  int? reOrderLevel;
  int? reOrderQty;
  int? priceTakenFrom;
  double? itemDiscountPercentage;
  int? itemDiscountRequired;
  double? itemDiscountValue;
  double? purchaseRateWTax;
  int? purchaseRate;
  int? salesRate;
  int? mRPRate;
  int? gstPercentage;
  String? createdDate;
  int? createdUserCode;
  int? updatedUserCode;

  AddProductMasterModel(
      {this.itemID,
      this.itemName,
      this.itemType,
      this.itemGroupCode,
      this.itemUnitCode,
      this.itemMakeCode,
      this.itemGenericCode,
      this.nonScheduleItem,
      this.scheduledH1Item,
      this.narcoticItem,
      this.expiryDateFormat,
      this.expiryDateRequired,
      this.subUnitCode,
      this.subQty,
      this.batchNoRequired,
      this.minimumStockQty,
      this.maximumStockQty,
      this.reOrderLevel,
      this.reOrderQty,
      this.priceTakenFrom,
      this.itemDiscountPercentage,
      this.itemDiscountRequired,
      this.itemDiscountValue,
      this.purchaseRateWTax,
      this.purchaseRate,
      this.salesRate,
      this.mRPRate,
      this.gstPercentage,
      this.createdDate,
      this.createdUserCode,
      this.updatedUserCode});

  AddProductMasterModel.fromJson(Map<String, dynamic> json) {
    itemID = json['ItemID'];
    itemName = json['ItemName'];
    itemType = json['ItemType'];
    itemGroupCode = json['ItemGroupCode'];
    itemUnitCode = json['ItemUnitCode'];
    itemMakeCode = json['ItemMakeCode'];
    itemGenericCode = json['ItemGenericCode'];
    nonScheduleItem = json['NonScheduleItem'];
    scheduledH1Item = json['ScheduledH1Item'];
    narcoticItem = json['NarcoticItem'];
    expiryDateFormat = json['ExpiryDateFormat'];
    expiryDateRequired = json['ExpiryDateRequired'];
    subUnitCode = json['SubUnitCode'];
    subQty = json['SubQty'];
    batchNoRequired = json['BatchNoRequired'];
    minimumStockQty = json['MinimumStockQty'];
    maximumStockQty = json['MaximumStockQty'];
    reOrderLevel = json['ReOrderLevel'];
    reOrderQty = json['ReOrderQty'];
    priceTakenFrom = json['PriceTakenFrom'];
    itemDiscountPercentage = json['ItemDiscountPercentage'];
    itemDiscountRequired = json['ItemDiscountRequired'];
    itemDiscountValue = json['ItemDiscountValue'];
    purchaseRateWTax = json['PurchaseRateWTax'];
    purchaseRate = json['PurchaseRate'];
    salesRate = json['SalesRate'];
    mRPRate = json['MRPRate'];
    gstPercentage = json['GstPercentage'];
    createdDate = json['CreatedDate'];
    createdUserCode = json['CreatedUserCode'];
    updatedUserCode = json['UpdatedUserCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemID'] = this.itemID;
    data['ItemName'] = this.itemName;
    data['ItemType'] = this.itemType;
    data['ItemGroupCode'] = this.itemGroupCode;
    data['ItemUnitCode'] = this.itemUnitCode;
    data['ItemMakeCode'] = this.itemMakeCode;
    data['ItemGenericCode'] = this.itemGenericCode;
    data['NonScheduleItem'] = this.nonScheduleItem;
    data['ScheduledH1Item'] = this.scheduledH1Item;
    data['NarcoticItem'] = this.narcoticItem;
    data['ExpiryDateFormat'] = this.expiryDateFormat;
    data['ExpiryDateRequired'] = this.expiryDateRequired;
    data['SubUnitCode'] = this.subUnitCode;
    data['SubQty'] = this.subQty;
    data['BatchNoRequired'] = this.batchNoRequired;
    data['MinimumStockQty'] = this.minimumStockQty;
    data['MaximumStockQty'] = this.maximumStockQty;
    data['ReOrderLevel'] = this.reOrderLevel;
    data['ReOrderQty'] = this.reOrderQty;
    data['PriceTakenFrom'] = this.priceTakenFrom;
    data['ItemDiscountPercentage'] = this.itemDiscountPercentage;
    data['ItemDiscountRequired'] = this.itemDiscountRequired;
    data['ItemDiscountValue'] = this.itemDiscountValue;
    data['PurchaseRateWTax'] = this.purchaseRateWTax;
    data['PurchaseRate'] = this.purchaseRate;
    data['SalesRate'] = this.salesRate;
    data['MRPRate'] = this.mRPRate;
    data['GstPercentage'] = this.gstPercentage;
    data['CreatedDate'] = this.createdDate;
    data['CreatedUserCode'] = this.createdUserCode;
    data['UpdatedUserCode'] = this.updatedUserCode;
    return data;
  }
}
