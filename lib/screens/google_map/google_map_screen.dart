part of screens;
class GoogleMapScreen extends StatefulWidget {
  static String routeName = '/map';
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController googleMapController;
  bool isMapCreated = false;
  TextEditingController _searchController = TextEditingController();
  TomtomLocationSuggestion locationSelected;
  CameraPosition initCamera;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void changeMapMode() {
    getJSONFile('assets/mapstyles/map_style.json').then(setStyle);
  }

  Future<String> getJSONFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setStyle(String mapStyle) {
    googleMapController.setMapStyle(mapStyle);
  }

  setLocation(TomtomLocationSuggestion suggestion) async {
    final LatLng newLatLong =
        LatLng(suggestion.position.lat, suggestion.position.lon);
    gotoLocation(newLatLong);
    setState(() {
      locationSelected = suggestion;
    });

    Provider.of<LocationProvider>(context, listen: false).setMarker(newLatLong);
  }

  gotoLocation(LatLng latlong) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition cameraPosition =
        CameraPosition(target: latlong, zoom: 16);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  gotoVietmapLocation(VietmapLocationSuggestion suggestion) async {
    final LatLng newLatLong = LatLng(
        suggestion.geometry.coordinates[0], suggestion.geometry.coordinates[1]);
    final GoogleMapController controller = await _controller.future;
    final CameraPosition cameraPosition =
        CameraPosition(target: newLatLong, zoom: 16);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    Provider.of<LocationProvider>(context, listen: false).setMarker(newLatLong);
  }

  confirmLocation() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    LatLng resultLatLng = locationSelected != null
        ? LatLng(locationSelected.position.lat, locationSelected.position.lon)
        : LatLng(provider.currentLocation.latitude,
            provider.currentLocation.longitude);
    String addressResult = locationSelected != null
        ? '${locationSelected.poi.name ?? ''} - ${locationSelected.address.freeformAddress}'
        : provider.currentAddrses;
    Navigator.pop(context,
        LocationAddress(coordinates: resultLatLng, address: addressResult));
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    return Consumer<LocationProvider>(builder: (context, provider, child) {
      return new Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        body: (provider.currentLocation == null &&
                provider.currentAddrses == null)
            ? Center(
                child: Loading(),
              )
            : SafeArea(
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      Expanded(
                        child: Stack(children: <Widget>[
                          GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    provider.currentLocation.latitude,
                                    provider.currentLocation.longitude),
                                zoom: 16),
                            myLocationButtonEnabled: true,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            markers: provider.markers.toSet(),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              googleMapController = controller;
                              final agrs = ModalRoute.of(context)
                                  .settings
                                  .arguments as LocationAddress;
                              if (agrs != null) {
                                gotoLocation(agrs.coordinates);
                                provider.setMarker(agrs.coordinates);
                                provider.setCurrentAddress(agrs.address);
                              } else {
                                provider.setCurrentLocation();
                              }
                            },
                          ),
                          Positioned(
                            top: 10,
                            right: 15,
                            left: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(3, 5),
                                        color: AppColors.blackColor
                                            .withOpacity(0.3))
                                  ],
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TypeAheadField<TomtomLocationSuggestion>(
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${LocaleKeys.search.tr()}...',
                                        prefixIcon: Icon(Icons.search),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              _searchController.clear();
                                            },
                                            icon: SvgPicture.asset(
                                              Res.ic_close_circle,
                                              color: AppColors.blackColor
                                                  .withOpacity(0.6),
                                            )))),
                                debounceDuration: Duration(milliseconds: 500),
                                suggestionsCallback: provider.geolocatorService
                                    .getTomtomLocationSuggestion,
                                itemBuilder: (context,
                                    TomtomLocationSuggestion suggestion) {
                                  if (suggestion != null) {
                                    final location = suggestion;
                                    String title = location.type == 'POI'
                                        ? '${location.poi.name} - ${location.address.municipalitySubdivision ?? ''} - ${location.address.freeformAddress}'
                                        : '${location.address.municipalitySubdivision ?? ''} - ${location.address.freeformAddress}';
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(title),
                                          leading: SvgPicture.asset(
                                            Res.ic_location,
                                            color: AppColors.primaryMediumColor,
                                          ),
                                        ),
                                        DividerCustom()
                                      ],
                                    );
                                  }
                                  return Center(child: Text(LocaleKeys.no_item_found.tr()));
                                },
                                hideOnError: true,
                                onSuggestionSelected:
                                    (TomtomLocationSuggestion suggestion) {
                                  setLocation(suggestion);
                                },
                                noItemsFoundBuilder: (context) => Container(
                                    height: 100.0,
                                    child: Center(
                                      child: Text(LocaleKeys.no_item_found.tr()),
                                    )),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      BottomSheet(
                        enableDrag: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onClosing: () {},
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                LocaleKeys.delivery_to.tr(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(locationSelected == null
                                  ? provider.currentAddrses
                                  : '${locationSelected.poi.name ?? ''} - ${locationSelected.address.freeformAddress}'),
                              SizedBox(
                                height: getHeight(10.0),
                              ),
                              PillButton(
                                child: Text(LocaleKeys.confirm.tr()),
                                onPressed: confirmLocation,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
      );
    });
  }
}
