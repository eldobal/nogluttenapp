import 'dart:async';

import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nogluttenapp/main.dart';
import 'package:nogluttenapp/src/ejemplos/listabandas.dart';


void main() {
  runApp(iniciofirebase());
}

class iniciofirebase extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //se añade el controlador de google maps
  GoogleMapController newGoogleMapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();


  //se declara una pariable de posicion actual
  Position currentPosition;
  void _locatePosition() async {
    //se solicita el permiso de ubicacion
    LocationPermission permission = await Geolocator.checkPermission();
    //se solicita y espera la ubicacion actual del dispocitibo
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    //se crea una variable latlong en la cual se rescate la ubicacion actual
    LatLng latlangPositionInitial =
    LatLng(position.latitude, position.longitude);
    //se crea una nueva posiccion de la camara y se le inserta la posicion actual y el zoom
    CameraPosition cameraPosition =
    new CameraPosition(target: latlangPositionInitial, zoom: 16);
    //se anima la camara y la tranalada hacia la posicion acutal
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    //print(latlangPositionInitial);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {return Text('Ta malo');}

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Container(
              child:
              GoogleMap(
                myLocationButtonEnabled: true,

                tiltGesturesEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: defaultPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
                  _locatePosition();
                },

              ),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }



  //camapa por defecto en Puerto Montt
  static final CameraPosition defaultPosition = CameraPosition(
    target: LatLng(-41.46574, -72.94289),
    zoom: 14.4746,
  );



}