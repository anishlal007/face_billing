class ItemGroupInfo {
  int? itemGroupCode;
  String? itemGroupName;
  String? cratedUserCode;
  String? createdDate;
  String? updatedUserCode;
  String? updatedDate;
  int? activeStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  ItemGroupInfo({
    this.itemGroupCode,
    this.itemGroupName,
    this.cratedUserCode,
    this.createdDate,
    this.updatedUserCode,
    this.updatedDate,
    this.activeStatus,
    this.createdAt,
    this.updatedAt,
  });

  ItemGroupInfo.fromJson(Map<String, dynamic> json) {
    itemGroupCode = json['ItemGroupCode'];
    itemGroupName = json['ItemGroupName'];
    cratedUserCode = json['CratedUserCode'];
    createdDate = json['CreatedDate'];
    updatedUserCode = json['UpdatedUserCode'];
    updatedDate = json['UpdatedDate'];
    activeStatus = json['ActiveStatus'];

    // ✅ Parse String -> DateTime safely
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.tryParse(json['updated_at'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ItemGroupCode'] = itemGroupCode;
    data['ItemGroupName'] = itemGroupName;
    data['CratedUserCode'] = cratedUserCode;
    data['CreatedDate'] = createdDate;
    data['UpdatedUserCode'] = updatedUserCode;
    data['UpdatedDate'] = updatedDate;
    data['ActiveStatus'] = activeStatus;

    // ✅ Convert DateTime -> String
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();

    return data;
  }
}

class ItemGroupResponse {
  bool? status;
  String? message;
  List<ItemGroupInfo?>? info;

  ItemGroupResponse({this.status, this.message, this.info});

  ItemGroupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['info'] != null) {
      info = <ItemGroupInfo>[];
      json['info'].forEach((v) {
        info!.add(ItemGroupInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['info'] = info != null ? info!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
