class AddAreaMasterModel {
  String? areaId;
  String? areaName;
  int? stateCode;
  int? createdUserCode;
  int? activeStatus;

  AddAreaMasterModel(
      {this.areaId,
      this.areaName,
      this.stateCode,
      this.createdUserCode,
      this.activeStatus});

  AddAreaMasterModel.fromJson(Map<String, dynamic> json) {
    areaId = json['AreaId'];
    areaName = json['AreaName'];
    stateCode = json['StateCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AreaId'] = this.areaId;
    data['AreaName'] = this.areaName;
    data['StateCode'] = this.stateCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
