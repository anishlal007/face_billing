class ProductMasterListModel {
  bool? status;
  dynamic message;
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
  dynamic itemCode;
  dynamic itemID;
  dynamic itemName;
  dynamic itemType;
  dynamic itemGroupCode;
  dynamic itemMakeCode;
  dynamic itemGenericCode;
  dynamic batchNoRequired;
  dynamic expiryDateRequired;
  dynamic expiryDateFormat;
  dynamic mFGDateRequired;
  dynamic narcoticItem;
  dynamic nonScheduleItem;
  dynamic scheduledH1Item;
  dynamic itemUnitCode;
  dynamic subUnitCode;
  dynamic subQty;
  dynamic subQtyFormalDigits;
  dynamic stockRequired;
  dynamic minimumStockQty;
  dynamic maximumStockQty;
  dynamic reOrderLevel;
  dynamic reOrderQty;
  dynamic hSNCode;
  dynamic gstPercentage;
  dynamic priceTakenFrom;
  dynamic purchaseRate;
  dynamic purchaseRateWTax;
  dynamic salesRate;
  dynamic mRPRate;
  dynamic itemDiscountRequired;
  dynamic itemDiscountPercentage;
  dynamic itemDiscountValue;
  dynamic itemImage;
  dynamic createdDate;
  dynamic createdUserCode;
  dynamic updatedDate;
  dynamic updatedUserCode;
  dynamic itemRackNo;
  dynamic itemSelfNo;
  dynamic itemBoxNo;
  Group? group;
  Make? make;

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
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    make = json['make'] != null ? new Make.fromJson(json['make']) : null;
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
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.make != null) {
      data['make'] = this.make!.toJson();
    }
    return data;
  }
}

class Group {
  dynamic itemGroupCode;
  dynamic itemGroupName;
  dynamic cratedUserCode;
  dynamic createdDate;
  dynamic updatedUserCode;
  dynamic updatedDate;
  dynamic activeStatus;
  dynamic createdAt;
  dynamic updatedAt;

  Group(
      {this.itemGroupCode,
      this.itemGroupName,
      this.cratedUserCode,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus,
      this.createdAt,
      this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
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

class Make {
  dynamic itemMakeCode;
  dynamic cratedUserCode;
  dynamic itemMaketName;
  dynamic createdDate;
  dynamic updatedUserCode;
  dynamic updatedDate;
  dynamic activeStatus;

  Make(
      {this.itemMakeCode,
      this.cratedUserCode,
      this.itemMaketName,
      this.createdDate,
      this.updatedUserCode,
      this.updatedDate,
      this.activeStatus});

  Make.fromJson(Map<String, dynamic> json) {
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
