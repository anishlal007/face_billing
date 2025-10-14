class AddNumberInitializeModel {
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
  String? quoNo2Suffix;
  String? quoNo2FormalDigit;
  String? salesNo2Prefix;
  String? salesNo2;
  String? salesNo2Suffix;
  String? salesNo2FormalDigit;
  String? salesOrderNoPrefix;
  String? salesOrderNo;
  String? salesOrderNoFormalDigit;
  String? salesOrderNoSuffix;

  AddNumberInitializeModel(
      {this.coCode,
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
      this.quoNo2Suffix,
      this.quoNo2FormalDigit,
      this.salesNo2Prefix,
      this.salesNo2,
      this.salesNo2Suffix,
      this.salesNo2FormalDigit,
      this.salesOrderNoPrefix,
      this.salesOrderNo,
      this.salesOrderNoFormalDigit,
      this.salesOrderNoSuffix});

  AddNumberInitializeModel.fromJson(Map<String, dynamic> json) {
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
    quoNo2Suffix = json['QuoNo2Suffix'];
    quoNo2FormalDigit = json['QuoNo2FormalDigit'];
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
    data['QuoNo2Suffix'] = this.quoNo2Suffix;
    data['QuoNo2FormalDigit'] = this.quoNo2FormalDigit;
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
