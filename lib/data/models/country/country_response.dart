// class Country {
//   final String id;
//   final String name;
//   final String code;

//   Country({
//     required this.id,
//     required this.name,
//     required this.code,
//   });

//   factory Country.fromJson(Map<String, dynamic> json) {
//     return Country(
//       id: json["id"].toString(),
//       name: json["name"] ?? "",
//       code: json["code"] ?? "",
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "name": name,
//       "code": code,
//     };
//   }
// }

class CountryInfo {
  dynamic countryCode;
  String? countryId;
  String? countryName;
  dynamic createdUserCode;
  dynamic activeStatus;

  CountryInfo(
      {this.countryCode,
      this.countryId,
      this.countryName,
      this.createdUserCode,
      this.activeStatus});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    countryCode = json['CountryCode'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    createdUserCode = json['CreatedUserCode'];
    activeStatus = json['ActiveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CountryCode'] = countryCode;
    data['CountryId'] = countryId;
    data['CountryName'] = countryName;
    data['CreatedUserCode'] = createdUserCode;
    data['ActiveStatus'] = activeStatus;
    return data;
  }
}

class Country {
  bool? status;
  String? message;
  List<CountryInfo?>? info;

  Country({this.status, this.message, this.info});

  Country.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['info'] != null) {
      info = <CountryInfo>[];
      json['info'].forEach((v) {
        info!.add(CountryInfo.fromJson(v));
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
