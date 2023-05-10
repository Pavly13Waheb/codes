import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';

// My Home Location (30.1315057, 31.3485607)
// Florida Mall Work (30.100753, 31.370570)
// Google Platform Key (AIzaSyCPgmWAXQ2AsI8290sWmHSmH-T8EbKJmnY)

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Position? cl;
  var cll;
  var lat;
  var long;
  late CameraPosition _kGooglePlex;
  late StreamSubscription<Position> positionStream;
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCPgmWAXQ2AsI8290sWmHSmH-T8EbKJmnY";

  Future getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    {
      if (services == false) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Location services disabled',
          btnOkOnPress: () {},
        ).show();
      }
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per == await Geolocator.requestPermission();
      }
      return per;
    }
  }

  Future<void> getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    cll = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl?.latitude;
    long = cl?.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 20,
    );
    myMarker.add(Marker(
        markerId: MarkerId("My Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: LatLng(lat, long)));
    setState(() {});
  }

  @override
  void initState() {
    getPolyline();
    getPer();
    getLatAndLong();
    super.initState();
  }

  GoogleMapController? gmc;

  Set<Marker> myMarker = {
    Marker(
        markerId: MarkerId("Home"),
        position: LatLng(30.1315057, 31.3485607),
        infoWindow: InfoWindow(title: "Home"),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)),
    Marker(
        markerId: MarkerId("Work"),
        position: LatLng(30.100753, 31.370570),
        infoWindow: InfoWindow(title: "Work"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
    Marker(
        markerId: MarkerId("Tap"),
        position: LatLng(30.1315057, 31.3485607),
        infoWindow: InfoWindow(title: "Tap"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        visible: false),
  };

  changeMarker(newlat, newlong) {
    myMarker.remove(Marker(markerId: MarkerId("My Location")));
    myMarker.add(Marker(
        markerId: MarkerId("My Location"),
        position: LatLng(newlat, newlong),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        visible: true));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            actions: [
              IconButton(
                onPressed: () async {
                  cll = getLatAndLong();
                  List<Placemark> placeMarks =
                      await placemarkFromCoordinates(lat, long);
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: "My Location",
                          desc: '${placeMarks[0].street}',
                          btnOkOnPress: () {},
                          btnOkColor: Colors.green)
                      .show();
                },
                icon: Icon(Icons.location_on_outlined,
                    color: Colors.red, size: 30),
              )
            ],
            title: const Text("Maps")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 700,
                child: cl == null
                    ? CircularProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.yellow,
                      )
                    : GoogleMap(
                        markers: myMarker,
                        myLocationEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        mapToolbarEnabled: true,
                        buildingsEnabled: true,
                        trafficEnabled: true,
                        polylines: Set<Polyline>.of(polyLines.values),
                        mapType: MapType.hybrid,
                        onMapCreated: (GoogleMapController controller) {
                          gmc = controller;
                        },
                        initialCameraPosition: _kGooglePlex,
                        onTap: (latLng) {
                          myMarker.add(Marker(
                              markerId: MarkerId("Tap"), position: latLng));
                          setState(() {});
                        },
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(2),
                      width: 102,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          LatLng latLng = LatLng(30.1315057, 31.3485607);
                          gmc?.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: latLng,
                                  zoom: 20,
                                  tilt: 30,
                                  bearing: -30)));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(Icons.home, color: Colors.blue, size: 30),
                              Text(
                                "Go To Home",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 102,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          LatLng latLng = LatLng(30.100753, 31.370570);
                          gmc?.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: latLng,
                                  zoom: 20,
                                  tilt: 30,
                                  bearing: -30)));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.work, color: Colors.red, size: 30),
                            Text(
                              "Go To Work",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          positionStream = Geolocator.getPositionStream()
                              .listen((Position position) {
                            changeMarker(position.latitude, position.longitude);
                            gmc?.animateCamera(CameraUpdate.newCameraPosition(
                                CameraPosition(
                                    target: LatLng(
                                        position.latitude, position.longitude),
                                    zoom: 20,
                                    tilt: 30,
                                    bearing: -30)));
                          });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.my_location,
                                color: Colors.red, size: 30),
                            Text(
                              "MY Location",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polyLines[id] = polyline;
    setState(() {});
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(30.1315057, 31.3485607),
        PointLatLng(30.100753, 31.370570),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    addPolyLine();
  }
}
