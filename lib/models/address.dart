import 'package:flutter/cupertino.dart';

class AddressModel {
  int id;
  String title;
  String address;
  String coordinates;
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
      coordinates: json['coordinates'] == null ? " " : json['coordinates'],
      description: json['description'] == null ? " " : json['description'],
      receiverName: json['receiver_name'] == null ? " " : json['receiver_name'],
      receiverPhone:
          json['receiver_phone'] == null ? " " : json['receiver_phone'],
    );
  }
}
