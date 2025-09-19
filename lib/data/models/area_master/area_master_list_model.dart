class AreaMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  AreaMasterListModel({this.status, this.message, this.info});

  AreaMasterListModel.fromJson(Map<String, dynamic> json) {
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
  int? areaCode;
  String? areaId;
  String? areaName;
  int? stateCode;
  int? createdUserCode;
  int? activeStatus;

  Info(
      {this.areaCode,
      this.areaId,
      this.areaName,
      this.stateCode,
      this.createdUserCode,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    areaCode = json['AreaCode'];
    areaId = json['AreaId'];
    areaName = json['AreaName'];
    stateCode = json['StateCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AreaCode'] = this.areaCode;
    data['AreaId'] = this.areaId;
    data['AreaName'] = this.areaName;
    data['StateCode'] = this.stateCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
