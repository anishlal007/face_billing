class AddUnitRequest {
  String unitId;
  String unitName;
  int activeStatus;

  AddUnitRequest({
    required this.unitId,
    required this.unitName,
    required this.activeStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "UnitId": unitId,
      "UnitName": unitName,
      "ActivStatus": activeStatus,
    };
  }
}
