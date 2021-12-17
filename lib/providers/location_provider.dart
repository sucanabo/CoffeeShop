part of providers;

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
  setCurrentAddress(String address) {
    currentAddrses = address;
    notifyListeners();
  }

  setCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast(LocaleKeys.keep_location.tr(), toastLength: Toast.LENGTH_LONG);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(LocaleKeys.location_denied.tr(),
            toastLength: Toast.LENGTH_LONG);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(LocaleKeys.location_denied_forever.tr());
    }
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
      markerId: MarkerId(LocaleKeys.your_location.tr()),
      position: latlong,
    ));
    notifyListeners();
  }
}
