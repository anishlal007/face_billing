class UnitInfo {
  int? unitCode;
  String? unitId;
  String? unitName;
  int? activeStatus;

  UnitInfo({this.unitCode, this.unitId, this.unitName, this.activeStatus});

  UnitInfo.fromJson(Map<String, dynamic> json) {
    unitCode = json['UnitCode'];
    unitId = json['UnitId'];
    unitName = json['UnitName'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['UnitCode'] = unitCode;
    data['UnitId'] = unitId;
    data['UnitName'] = unitName;
    data['ActiveStatus'] = activeStatus;
    return data;
  }
}

class UnitResponse {
  bool? status;
  String? message;
  List<UnitInfo?>? info;

  UnitResponse({this.status, this.message, this.info});

  UnitResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['info'] != null) {
      info = <UnitInfo>[];
      json['info'].forEach((v) {
        info!.add(UnitInfo.fromJson(v));
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
