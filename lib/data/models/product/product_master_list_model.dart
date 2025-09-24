class ProductMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  ProductMasterListModel({this.status, this.message, this.info});

  ProductMasterListModel.fromJson(Map<String, dynamic> json) {
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
  int? itemCode;
  String? itemID;
  String? itemName;
  int? itemType;
  int? itemGroupCode;
  int? itemMakeCode;
  int? itemGenericCode;
  int? batchNoRequired;
  String? expiryDateRequired;
  String? expiryDateFormat;
  int? mFGDateRequired;
  int? narcoticItem;
  int? nonScheduleItem;
  int? scheduledH1Item;
  int? itemUnitCode;
  int? subUnitCode;
  int? subQty;
  Null? subQtyFormalDigits;
  int? stockRequired;
  int? minimumStockQty;
  int? maximumStockQty;
  int? reOrderLevel;
  int? reOrderQty;
  String? hSNCode;
  int? gstPercentage;
  int? priceTakenFrom;
  int? purchaseRate;
  double? purchaseRateWTax;
  int? salesRate;
  int? mRPRate;
  int? itemDiscountRequired;
  double? itemDiscountPercentage;
  double? itemDiscountValue;
  String? itemImage;
  String? createdDate;
  int? createdUserCode;
  String? updatedDate;
  int? updatedUserCode;
  Null? itemRackNo;
  Null? itemSelfNo;
  Null? itemBoxNo;
  Null? group;
  Null? make;

  Info(
      {this.itemCode,
      this.itemID,
      this.itemName,
      this.itemType,
      this.itemGroupCode,
      this.itemMakeCode,
      this.itemGenericCode,
      this.batchNoRequired,
      this.expiryDateRequired,
      this.expiryDateFormat,
      this.mFGDateRequired,
      this.narcoticItem,
      this.nonScheduleItem,
      this.scheduledH1Item,
      this.itemUnitCode,
      this.subUnitCode,
      this.subQty,
      this.subQtyFormalDigits,
      this.stockRequired,
      this.minimumStockQty,
      this.maximumStockQty,
      this.reOrderLevel,
      this.reOrderQty,
      this.hSNCode,
      this.gstPercentage,
      this.priceTakenFrom,
      this.purchaseRate,
      this.purchaseRateWTax,
      this.salesRate,
      this.mRPRate,
      this.itemDiscountRequired,
      this.itemDiscountPercentage,
      this.itemDiscountValue,
      this.itemImage,
      this.createdDate,
      this.createdUserCode,
      this.updatedDate,
      this.updatedUserCode,
      this.itemRackNo,
      this.itemSelfNo,
      this.itemBoxNo,
      this.group,
      this.make});

  Info.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemID = json['ItemID'];
    itemName = json['ItemName'];
    itemType = json['ItemType'];
    itemGroupCode = json['ItemGroupCode'];
    itemMakeCode = json['ItemMakeCode'];
    itemGenericCode = json['ItemGenericCode'];
    batchNoRequired = json['BatchNoRequired'];
    expiryDateRequired = json['ExpiryDateRequired'];
    expiryDateFormat = json['ExpiryDateFormat'];
    mFGDateRequired = json['MFGDateRequired'];
    narcoticItem = json['NarcoticItem'];
    nonScheduleItem = json['NonScheduleItem'];
    scheduledH1Item = json['ScheduledH1Item'];
    itemUnitCode = json['ItemUnitCode'];
    subUnitCode = json['SubUnitCode'];
    subQty = json['SubQty'];
    subQtyFormalDigits = json['SubQtyFormalDigits'];
    stockRequired = json['StockRequired'];
    minimumStockQty = json['MinimumStockQty'];
    maximumStockQty = json['MaximumStockQty'];
    reOrderLevel = json['ReOrderLevel'];
    reOrderQty = json['ReOrderQty'];
    hSNCode = json['HSNCode'];
    gstPercentage = json['GstPercentage'];
    priceTakenFrom = json['PriceTakenFrom'];
    purchaseRate = json['PurchaseRate'];
    purchaseRateWTax = json['PurchaseRateWTax'];
    salesRate = json['SalesRate'];
    mRPRate = json['MRPRate'];
    itemDiscountRequired = json['ItemDiscountRequired'];
    itemDiscountPercentage = json['ItemDiscountPercentage'];
    itemDiscountValue = json['ItemDiscountValue'];
    itemImage = json['ItemImage'];
    createdDate = json['CreatedDate'];
    createdUserCode = json['CreatedUserCode'];
    updatedDate = json['UpdatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    itemRackNo = json['ItemRackNo'];
    itemSelfNo = json['ItemSelfNo'];
    itemBoxNo = json['ItemBoxNo'];
    group = json['group'];
    make = json['make'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data['ItemID'] = this.itemID;
    data['ItemName'] = this.itemName;
    data['ItemType'] = this.itemType;
    data['ItemGroupCode'] = this.itemGroupCode;
    data['ItemMakeCode'] = this.itemMakeCode;
    data['ItemGenericCode'] = this.itemGenericCode;
    data['BatchNoRequired'] = this.batchNoRequired;
    data['ExpiryDateRequired'] = this.expiryDateRequired;
    data['ExpiryDateFormat'] = this.expiryDateFormat;
    data['MFGDateRequired'] = this.mFGDateRequired;
    data['NarcoticItem'] = this.narcoticItem;
    data['NonScheduleItem'] = this.nonScheduleItem;
    data['ScheduledH1Item'] = this.scheduledH1Item;
    data['ItemUnitCode'] = this.itemUnitCode;
    data['SubUnitCode'] = this.subUnitCode;
    data['SubQty'] = this.subQty;
    data['SubQtyFormalDigits'] = this.subQtyFormalDigits;
    data['StockRequired'] = this.stockRequired;
    data['MinimumStockQty'] = this.minimumStockQty;
    data['MaximumStockQty'] = this.maximumStockQty;
    data['ReOrderLevel'] = this.reOrderLevel;
    data['ReOrderQty'] = this.reOrderQty;
    data['HSNCode'] = this.hSNCode;
    data['GstPercentage'] = this.gstPercentage;
    data['PriceTakenFrom'] = this.priceTakenFrom;
    data['PurchaseRate'] = this.purchaseRate;
    data['PurchaseRateWTax'] = this.purchaseRateWTax;
    data['SalesRate'] = this.salesRate;
    data['MRPRate'] = this.mRPRate;
    data['ItemDiscountRequired'] = this.itemDiscountRequired;
    data['ItemDiscountPercentage'] = this.itemDiscountPercentage;
    data['ItemDiscountValue'] = this.itemDiscountValue;
    data['ItemImage'] = this.itemImage;
    data['CreatedDate'] = this.createdDate;
    data['CreatedUserCode'] = this.createdUserCode;
    data['UpdatedDate'] = this.updatedDate;
    data['UpdatedUserCode'] = this.updatedUserCode;
    data['ItemRackNo'] = this.itemRackNo;
    data['ItemSelfNo'] = this.itemSelfNo;
    data['ItemBoxNo'] = this.itemBoxNo;
    data['group'] = this.group;
    data['make'] = this.make;
    return data;
  }
}
