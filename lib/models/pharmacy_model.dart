class Pharmacy {
  int? id;
  String? name;
  String? watchDate;
  String? address;
  String? neighborhood;
  String? district;
  String? phone;
  String? watchType;
  String? eWatchType;
  double? latitude;
  double? longitude;
  String? distance;
  String? distanceKm;
  Null? message;
  Null? category;
  Null? subCategory;

  Pharmacy(
      {this.id,
      this.name,
      this.watchDate,
      this.address,
      this.neighborhood,
      this.district,
      this.phone,
      this.watchType,
      this.eWatchType,
      this.latitude,
      this.longitude,
      this.distance,
      this.distanceKm,
      this.message,
      this.category,
      this.subCategory});
      
  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    watchDate = json['watchDate'];
    address = json['address'];
    neighborhood = json['neighborhood'];
    district = json['district'];
    phone = json['phone'];
    watchType = json['watchType'];
    eWatchType = json['eWatchType'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    distanceKm = json['distanceKm'];
    message = json['message'];
    category = json['category'];
    subCategory = json['subCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['watchDate'] = this.watchDate;
    data['address'] = this.address;
    data['neighborhood'] = this.neighborhood;
    data['district'] = this.district;
    data['phone'] = this.phone;
    data['watchType'] = this.watchType;
    data['eWatchType'] = this.eWatchType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    data['distanceKm'] = this.distanceKm;
    data['message'] = this.message;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    return data;
  }
}