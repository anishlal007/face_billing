class GetSerialNoModel {
  bool? status;
  String? message;
  Info? info;

  GetSerialNoModel({this.status, this.message, this.info});

  GetSerialNoModel.fromJson(Map<String, dynamic> json) {
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
  String? productNextId;
  String? purchaseNextId;
  String? salesNextId;

  Info({this.productNextId, this.purchaseNextId, this.salesNextId});

  Info.fromJson(Map<String, dynamic> json) {
    productNextId = json['product_next_id'];
    purchaseNextId = json['purchase_next_id'];
    salesNextId = json['sales_next_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_next_id'] = this.productNextId;
    data['purchase_next_id'] = this.purchaseNextId;
    data['sales_next_id'] = this.salesNextId;
    return data;
  }
}
