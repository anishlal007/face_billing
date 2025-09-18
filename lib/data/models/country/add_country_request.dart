class AddCountryRequest {
  String countryId;
  String countryName;
  int createdUserCode;
  int activeStatus;

  AddCountryRequest({
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
