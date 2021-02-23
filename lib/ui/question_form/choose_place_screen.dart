import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChoosePlace extends StatefulWidget {
  @override
  _ChoosePlaceState createState() => _ChoosePlaceState();
}

class _ChoosePlaceState extends State<ChoosePlace> {
  GoogleMapController _controller;
  UserLocation _currentLocation;
  Location location = new Location();
  double currentZoomLevel = 12.0;
  final Geocoding geocoding = Geocoder.local;
  String userAddressString = '';

  Marker centerMarker = Marker(
    position: LatLng(
      43.238949,
      76.889709,
    ),
    markerId: MarkerId('1'),
  );

  Future getAddressFromCoordinates(double latitude, double longitude) async {
    var results = await geocoding
        .findAddressesFromCoordinates(Coordinates(latitude, longitude));
    userAddressString = results.first.addressLine;
    return results.first;
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    print(_currentLocation.longitude);
    return _currentLocation;
  }

  void selectAdders(LatLng location) async {
    //var addressFromLatLong = await getAddressFromCoordinates(location.latitude, location.longitude);
    getAddressFromCoordinates(location.latitude, location.longitude)
        .then((value) {
      setState(() {
        centerMarker = Marker(
          markerId: MarkerId('1'),
          position: LatLng(
            location.latitude,
            location.longitude,
          ),
          infoWindow: InfoWindow(title: 'Адрес', snippet: value.addressLine),
        );
      });
    });
  }

  @override
  void initState() {
    getAddressFromCoordinates(43.238949, 76.889709);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Выберите локацию'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, userAddressString);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Container(
        height: h,
        width: w,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              rotateGesturesEnabled: false,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              markers: {centerMarker},
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    43.238949,
                    76.889709,
                  ),
                  zoom: currentZoomLevel),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              onTap: (latLong) {
                selectAdders(latLong);
              },
            ),
            Positioned(
                top: 40,
                right: 16,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xff2C98F0).withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Color(0xff2C98F0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      UserLocation userPosition = await getLocation();
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              userPosition.latitude,
                              userPosition.longitude,
                            ),
                            zoom: currentZoomLevel,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.my_location_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                )),
            Positioned(
                top: 200,
                right: 16,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: Color(0xff2C98F0).withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Color(0xff2C98F0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      currentZoomLevel = await _controller.getZoomLevel();
                      currentZoomLevel -= 2;
                      if (currentZoomLevel < 0) currentZoomLevel = 0;
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              43.238949,
                              76.889709,
                            ),
                            zoom: currentZoomLevel,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                )),
            Positioned(
                top: 254,
                right: 16,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: Color(0xff2C98F0).withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Color(0xff2C98F0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      var currentZoomLevel = await _controller.getZoomLevel();

                      currentZoomLevel = currentZoomLevel + 2;
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                              43.238949,
                              76.889709,
                            ),
                            zoom: currentZoomLevel,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              child: Container(
                width: w,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.01,
                      0.5,
                      1.0,
                    ],
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Color(0xff2C98F0).withOpacity(0.5),
                      Color(0xff2C98F0)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 16,
              right: 16,
              child: Container(
                width: w,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context, userAddressString);
                    });
                  },
                  child: Center(
                    child: Text(
                      'выбрать место на карте'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff2C98F0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({this.latitude, this.longitude});
}
