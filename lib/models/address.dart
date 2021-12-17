
part of models;

class AddressModel {
  int id;
  String title;
  String address;
  LatLng coordinates;
  String description;
  String receiverName;
  String receiverPhone;

  AddressModel({
    this.id,
    @required this.title,
    @required this.address,
    @required this.receiverName,
    @required this.receiverPhone,
    this.coordinates,
    this.description,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      title: json['title'] == null ? " " : json['title'],
      address: json['address'] == null ? " " : json['address'],
      coordinates: json['coordinates'] == null
          ? null
          : coordinatesFromJson(json['coordinates']),
      description: json['description'] == null ? " " : json['description'],
      receiverName: json['receiver_name'] == null ? " " : json['receiver_name'],
      receiverPhone:
          json['receiver_phone'] == null ? " " : json['receiver_phone'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "address": address == null ? null : address,
        "coordinates": coordinates == null
            ? null
            : '${coordinates.latitude},${coordinates.longitude}',
        "description": description == null ? null : description,
        "receiver_name": receiverName == null ? null : receiverName,
        "receiver_phone": receiverPhone == null ? null : receiverPhone,
      };
  static LatLng coordinatesFromJson(String str) {
    List<String> list = str.split(',');
    return LatLng(double.parse(list[0]), double.parse(list[1]));
  }
}
class LocationAddress{
  String address;
  LatLng coordinates;
  LocationAddress({@required this.address,@required this.coordinates});
}
