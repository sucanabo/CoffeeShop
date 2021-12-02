import 'dart:convert';

import 'package:coffee_shop/models/tomtom_location_suggestion.dart';
import 'package:coffee_shop/models/tomtom_routes.dart';
import 'package:coffee_shop/models/vietmap_location_suggestion.dart';
import 'package:coffee_shop/untils/app_information.dart';
import 'package:coffee_shop/values/api_end_point.dart';
// import 'package:coffee_shop/models/vietmap_location_suggestion.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GeolocatorService {
  Future<Position> getCureentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<List<TomtomLocationSuggestion>> getTomtomLocationSuggestion(
      String query) async {
    final url = Uri.parse(tomtomAutoComplete(query));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List locations = json.decode(response.body)['results'];

      print(response.body);
      List<TomtomLocationSuggestion> list = locations
          .map((json) => TomtomLocationSuggestion.fromJson(json))
          .toList();

      return list;
    } else {
      throw Exception();
    }
  }

  Future<List<VietmapLocationSuggestion>> getVietmapLocationSuggestion(
      String query) async {
    final url = Uri.parse(mapvietAutoComlete(query));
    print(url);
    final response =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final List locations =
          json.decode(utf8.decode(response.bodyBytes))['data']['features'];
      print(response.body);
      List<VietmapLocationSuggestion> list = locations
          .map((json) => VietmapLocationSuggestion.fromJson(json))
          .toList();

      return list;
    } else {
      throw Exception();
    }
  }

  Future<TomtomRoutes> getTomtomRoutes(LatLng destination) async {
    final url =
        Uri.parse(tomtomDistance(AppInformation.storeLocation, destination));
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return TomtomRoutes.fromJson(json.decode(response.body));
    } else {
      throw Exception();
    }
  }
}
