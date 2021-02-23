import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:almaty_app/ui/question_form/choose_place_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  UserLocation _currentLocation;
  Location location = new Location();
  bool _startSearch = false;
  final List<Marker> markers = [];
  String dropdownValue;

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
    try {
      for (int i = 0; i < listData.length; i++) {
        final Uint8List markerIcon =
            await getBytesFromAsset('assets/images/mapIcon.png', 150);
        final Uint8List markerIconBlue =
            await getBytesFromAsset('assets/images/mapIconBlue.png', 150);
        markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(
              listData[i][0],
              listData[i][1],
            ),
            icon: i == 2
                ? BitmapDescriptor.fromBytes(markerIconBlue)
                : BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(
              title: listData[i][2],
              snippet: listData[i][2],
              onTap: () {
                print('press');
              },
            ),
          ),
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _startSearch
          ? AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                width: w * 0.8,
                height: 40,
                padding: EdgeInsets.only(left: 18, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Поиск',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.38),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Color(0xff2C98F0),
                      size: 24,
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _startSearch = false;
                  });
                },
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset('assets/svg/filter_icon.svg',
                      color: Colors.white),
                  onPressed: () {
                    _onOpenMore(context);
                  },
                ),
              ],
            )
          : AppBar(
              automaticallyImplyLeading: false,
              title: Text('На карте'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _startSearch = true;
                    });
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/svg/filter_icon.svg',
                      color: Colors.white),
                  onPressed: () {
                    _onOpenMore(context);
                  },
                ),
              ],
            ),
      body: Container(
        width: w,
        height: h,
        child: FutureBuilder(
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
            }),
      ),
      floatingActionButton: Container(
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
    );
  }

  void _onOpenMore(BuildContext context, {String content, String title}) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: w,
            height: h,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                      ),
                      Text(
                        'Фильтр',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          dropdownValue = null;
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: w,
                  height: h * 0.9,
                  //height: h * 0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 38, left: 16, right: 16),
                        width: w,
                        height: 35,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down_sharp),
                          itemHeight: 100.0,
                          hint: Text(
                            'Выберите категорию',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.42)),
                          ),
                          isExpanded: true,
                          isDense: true,
                          iconSize: 24,
                          elevation: 1,
                          underline: Container(
                            height: 1,
                            color: dropdownValue == null
                                ? Colors.black.withOpacity(0.42)
                                : Color(0xff2C98F0),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[
                            'Простаивающие здания',
                            'Стихийные свалки',
                            'Земли самозахвата',
                            'Другое'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: w,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 24),
                        child: Text(
                          'Выбранные категории',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff2C98F0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        width: w,
                        margin: EdgeInsets.only(left: 16, right: 16, top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.5),
                                border: Border.all(
                                    color: Color(0xff2C98F0), width: 1),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Торговля non-food',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff474747)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Color(0xff474747),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.5),
                                border: Border.all(
                                    color: Color(0xff2C98F0), width: 1),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Торговля non-food',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff474747)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Color(0xff474747),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
