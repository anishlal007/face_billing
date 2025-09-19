class StateMasterListModel {
  bool? status;
  String? message;
  List<Info>? info;

  StateMasterListModel({this.status, this.message, this.info});

  StateMasterListModel.fromJson(Map<String, dynamic> json) {
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
  int? stateCode;
  String? stateId;
  String? stateName;
  int? countryCode;
  int? createdUserCode;
  int? activeStatus;

  Info(
      {this.stateCode,
      this.stateId,
      this.stateName,
      this.countryCode,
      this.createdUserCode,
      this.activeStatus});

  Info.fromJson(Map<String, dynamic> json) {
    stateCode = json['StateCode'];
    stateId = json['StateId'];
    stateName = json['StateName'];
    countryCode = json['CountryCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.stateCode;
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    data['CountryCode'] = this.countryCode;
    data['CreatedUserCode'] = this.createdUserCode;
    data['ActiveStatus'] = this.activeStatus;
    return data;
  }
}
