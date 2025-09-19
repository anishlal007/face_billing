class AddStateModel {
  String? stateId;
  String? stateName;
  int? countryCode;
  int? createdUserCode;
  int? activeStatus;

  AddStateModel({
    this.stateId,
    this.stateName,
    this.countryCode,
    this.createdUserCode,
    this.activeStatus,
  });

  AddStateModel.fromJson(Map<String, dynamic> json) {
    stateId = json['StateId'];
    stateName = json['StateName'];
    countryCode = json['CountryCode'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['StateId'] = stateId;
    data['StateName'] = stateName;
    data['CountryCode'] = countryCode;
    data['CreatedUserCode'] = createdUserCode;
    data['ActiveStatus'] = activeStatus;
    return data;
  }
}