import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nogluttenapp/src/horariosShop.dart';
import 'package:nogluttenapp/src/ubicacionShop.dart';

import 'package:provider/provider.dart';

import 'src/addShops.dart';
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
              '$horariosshop' : (context) => HorariosShop()
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
      body: //iniciofirebase(),
      Center(
        child: Container(
          child:
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set.from(allMarkers),
          ),
        ),
      ),
      floatingActionButton: _floatingActionButton(), // This trailing
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,// comma makes auto-formatting nicer for build methods.
    );


  }

  Widget _floatingActionButton(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          FloatingActionButton(
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

/*
  Widget _floatingActionButton2(){
    //se ocupa el consumer para obtener los datos del provider
    return Consumer<ShopsProvider>(
      builder: (context,provider,child){
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {provider.increment();
                print(provider.numero);
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {provider.decrement();
                print(provider.numero);
                },
                tooltip: 'Increment',
                child: Icon(Icons.wash_sharp),
              ),
              FloatingActionButton(
                onPressed: _goToHome,
                tooltip: 'Increment',
                child:Text('${provider.numero}'),
              ),
            ],
          ),
        );
      }
    );
  }
*/

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

