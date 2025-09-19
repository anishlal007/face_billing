class AddLocationMasterReq {
  String? itemLocationName;
  String? cratedUserCode; // must stay "CratedUserCode"
  String? createdDate;
  int? updatedUserCode;
  String? updatedDate;
  int? activeStatus;

  AddLocationMasterReq({
    this.itemLocationName,
    this.cratedUserCode,
    this.createdDate,
    this.updatedUserCode,
    this.updatedDate,
    this.activeStatus,
  });

  factory AddLocationMasterReq.fromJson(Map<String, dynamic> json) {
    return AddLocationMasterReq(
      itemLocationName: json['ItemLocationName'],
      cratedUserCode: json['CratedUserCode'],
      createdDate: json['CreatedDate'],
      updatedUserCode: json['UpdatedUserCode'],
      updatedDate: json['UpdatedDate'],
      activeStatus: json['ActiveStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ItemLocationName": itemLocationName,
      "CratedUserCode": cratedUserCode,
      "CreatedDate": createdDate,
      "UpdatedUserCode": updatedUserCode,
      "UpdatedDate": updatedDate,
      "ActiveStatus": activeStatus,
    };
  }
}