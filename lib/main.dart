import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/ejemplos/FirebaseApp.dart';
import 'package:nogluttenapp/src/UI/horariosShop.dart';
import 'package:nogluttenapp/src/ejemplos/selectImage.dart';
import 'package:nogluttenapp/src/UI/ubicacionShop.dart';

import 'package:provider/provider.dart';

import 'src/UI/addShops.dart';
import 'src/constantes/constantes.dart';
import 'src/ejemplos/tabs/home_page.dart';
import 'src/provider/shopsProvider.dart';

void main() {runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final addshop = Constantes().addShops;
  final routeEjemplos = Constantes().ejemplos;
  final ubicacionshop = Constantes().addubicacionShop;
  final horariosshop = Constantes().addHorarios;
  final selectImage = Constantes().addImages;

  @override
  Widget build(BuildContext context) {
    //se añade el widget del provider a la aplicacion
    return ChangeNotifierProvider(
      create: (context) => ShopsProvider(),
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
            routes: {
              'paginicial' : (context) => MyApp(),
              '$addshop' : (context) => addShops(),
              '$routeEjemplos' : (context) => HomePage(),
              '$ubicacionshop' : (context) => ubicacionShop(),
              '$horariosshop' : (context) => HorariosShop(),
              '$selectImage' : (context) => SelectImage()
            },
          )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(markerId: MarkerId('MyMarker'),
        draggable: false,
      onTap: (){
      print('Marcador añadido');
      },
      position: LatLng( -40.915837, -73.157223)
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: iniciofirebase(),
      floatingActionButton: _floatingActionButton(), // This trailing
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,// comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _floatingActionButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FloatingActionButton(
            backgroundColor: ColorPalete.color5,
            onPressed: _addShops,
            tooltip: 'Increment',
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }

  Widget _mostrarEjemplos(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FloatingActionButton(
            onPressed: _showejemplos,
            tooltip: 'Increment',
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }


  void _addShops() {
    Navigator.pushNamed(context, Constantes().addShops.toString());
  }

  void _showejemplos() {
    Navigator.pushNamed(context, Constantes().ejemplos.toString());
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_home));
  }

  static final CameraPosition _home = CameraPosition(
      target: LatLng( -40.915837, -73.157223),
      zoom: 17
  );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

}

