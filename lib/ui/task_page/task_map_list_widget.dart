import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:almaty_app/ui/question_form/choose_place_screen.dart';

class TaskMapList extends StatefulWidget {
  @override
  _TaskMapListState createState() => _TaskMapListState();
}

class _TaskMapListState extends State<TaskMapList> {
  GoogleMapController _controller;
  UserLocation _currentLocation;
  Location location = new Location();
  final List<Marker> markers = [];
  List<List<dynamic>> listData = [[43.257516, 76.949634, 'Шагабутдинова дом 4,выше Макатаева',],[43.238535, 76.928401, 'Республика Казахстан, г.Алматы, ул.Байтурсынова,100',],[43.238305, 76.828646, 'Республика Казахстан, г. Алматы, ул. Макатаева, дом 158, н.п. 69',],[43.855936, 77.057313, 'Республика Казахстан, Алматинская обл, г.Капчагай, мкр.18  Рынок Алга',],[43.247499, 76.868552, 'Республика Казахстан, г. Алматы, ул. Толе би, д. 286/8',],[43.254177, 76.940987, 'Республика Казахстан, г.Алматы, ул. Желтоксан, дом № 77',],[43.232137, 76.920645, 'Республика Казахстан, г.Алматы, ул. Бухар Жырау, дом №35, офис № 366',],];


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
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
    print(_currentLocation.latitude);
    return _currentLocation;
  }

  Future _initMarkers() async {
    try{
      for (int i = 0; i < listData.length; i++) {
        final Uint8List markerIcon = await getBytesFromAsset('assets/images/mapIcon.png', 150);
        print('test');
        markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(
              listData[i][0],
              listData[i][1],
            ),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: "Test",
              snippet: listData[i][2],
              onTap: () {
                print('press');
              },
            ),
          ),
        );
      }
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h,
      child: Stack(
        children: [
          FutureBuilder(
            future: _initMarkers(),
            builder: (context, snapshot) {
              return GoogleMap(
                mapToolbarEnabled: false,
                rotateGesturesEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                markers: markers.toSet(),
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      43.238949,
                      76.889709,
                    ),
                    zoom: 13),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              );
            }
          ),
          Positioned(
            top: 0,
            child: Container(
              width: w,
              height: 72,
              padding: EdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w * 0.65,
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://img.promoavon.ru/goodpics/ru/medium/1146773.jpg')),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          width: w * 0.65 - 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'На сегодня',
                                maxLines: 1,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Выполнено 2 из 30',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: w * 0.25,
                    alignment: Alignment.topRight,
                    child: Text(
                      '07.12.20',
                      maxLines: 1,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 16,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
              child: IconButton(
                icon: Icon(
                  Icons.my_location_outlined,
                  size: 24,
                ),
                onPressed: () async {
                  _initMarkers();
                  UserLocation userPosition = await getLocation();
                  _controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          userPosition.latitude,
                          userPosition.longitude,
                        ),
                        zoom: 15,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
