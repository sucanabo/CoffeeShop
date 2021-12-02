import 'package:coffee_shop/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  //Position
  Position currentLocation;
  String currentAddrses;
  List<Marker> markers = [];
  LocationProvider() {
    print('location provider create ');
    setCurrentLocation();
  }
  setCurrentAddress (String address){
    currentAddrses = address;
    notifyListeners();
  }
  setCurrentLocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   showToast('Please keep your location on', toastLength: Toast.LENGTH_LONG);
    // }
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     showToast('Location permission is denied.',
    //         toastLength: Toast.LENGTH_LONG);
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   showToast('Location permission is denied forever');
    // }
    Position position = await geolocatorService.getCureentLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    currentAddrses =
        '${place.street} ${place.subLocality} ${place.locality} ${place.country}';
    currentLocation = position;
    setMarker(LatLng(currentLocation.latitude, currentLocation.longitude));

    notifyListeners();
  }

  setMarker(LatLng latlong) {
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId('Your location'),
      position: latlong,
    ));
    notifyListeners();
  }
}
