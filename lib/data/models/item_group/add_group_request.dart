class AddGroupRequest {
  String itemGroupName;
  String? createdUserCode;
  String? updatedUserCode;
  String? createdDate;
  int activeStatus;

  AddGroupRequest({
    required this.itemGroupName,
    this.createdUserCode,
    this.updatedUserCode,
    this.createdDate,
    required this.activeStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "ItemGroupName": itemGroupName,
      "CreatedUserCode": createdUserCode,
      "UpdatedUserCode": updatedUserCode,
      "CreatedDate": createdDate,
      "ActiveStatus": activeStatus,
    };
  }
}
