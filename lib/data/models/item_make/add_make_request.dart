class AddMakeRequest {
  String countryId;
  String countryName;
  int createdUserCode;
  int activeStatus;

  AddMakeRequest({
    required this.countryId,
    required this.countryName,
    required this.createdUserCode,
    required this.activeStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "CountryId": countryId,
      "CountryName": countryName,
      "CreatedUserCode": createdUserCode,
      "ActiveStatus": activeStatus,
    };
  }
}
