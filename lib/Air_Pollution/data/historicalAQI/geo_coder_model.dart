class GeoCoderModel {
  List<Data>? data;

  GeoCoderModel({this.data});

  GeoCoderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  double? latitude;
  double? longitude;
  String? type;
  String? name;
  String? number;
  String? postalCode;
  String? street;
  num? confidence;
  String? region;
  String? regionCode;
  String? county;
  String? locality;
  String? administrativeArea;
  String? neighbourhood;
  String? country;
  String? countryCode;
  String? continent;
  String? label;

  Data(
      {this.latitude,
      this.longitude,
      this.type,
      this.name,
      this.number,
      this.postalCode,
      this.street,
      this.confidence,
      this.region,
      this.regionCode,
      this.county,
      this.locality,
      this.administrativeArea,
      this.neighbourhood,
      this.country,
      this.countryCode,
      this.continent,
      this.label});

  Data.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    name = json['name'];
    number = json['number'];
    postalCode = json['postal_code'];
    street = json['street'];
    confidence = json['confidence'];
    region = json['region'];
    regionCode = json['region_code'];
    county = json['county'];
    locality = json['locality'];
    administrativeArea = json['administrative_area'];
    neighbourhood = json['neighbourhood'];
    country = json['country'];
    countryCode = json['country_code'];
    continent = json['continent'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['name'] = this.name;
    data['number'] = this.number;
    data['postal_code'] = this.postalCode;
    data['street'] = this.street;
    data['confidence'] = this.confidence;
    data['region'] = this.region;
    data['region_code'] = this.regionCode;
    data['county'] = this.county;
    data['locality'] = this.locality;
    data['administrative_area'] = this.administrativeArea;
    data['neighbourhood'] = this.neighbourhood;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['continent'] = this.continent;
    data['label'] = this.label;
    return data;
  }
}
