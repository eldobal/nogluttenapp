import 'dart:async';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';
import 'constantes/constantes.dart';

class ubicacionShop extends StatefulWidget {
  @override
  _ubicacionShopState createState() => _ubicacionShopState();
}

class _ubicacionShopState extends State<ubicacionShop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;



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

    print(latlangPositionInitial);
  }

  //mapa de marcadores para guardar los marcadores
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    Future<LocationPermission> requestPermission() =>
        GeolocatorPlatform.instance.requestPermission();



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }




  List<Marker> Mymarker = [];

  final costantes = Constantes();
  final provider = ShopsProvider();

  final controller = TextEditingController(text: "");



  TextEditingController originCtrl;
  TextEditingController destCtrl;
  Coords initialCoords;

  @override
  Widget build(BuildContext context) {


    final provider = Provider.of<ShopsProvider>(context);
    final color = ColorPalete();
    //builder con las configuraciones del plguin de busqueda
    final geoMethods = GeoMethods(
        googleApiKey: '${costantes.appiKeyGoogleMaps}',
        language: 'es-419',
        countryCode: 'cl',
        country: 'Chile',
        city: '${provider.ciudadSelecionada}');

    //componente principal del la pantalla
    return Scaffold(
      body: SafeArea(
        child: RouteSearchBox(
          geoMethods: geoMethods,
          originCtrl: originCtrl,
          destinationCtrl: destCtrl,
          builder: (
            BuildContext context,
            AddressSearchBuilder originBuilder,
            AddressSearchBuilder destinationBuilder, {
            Future<Directions> Function() getDirections,
            void Function(AddressId addrId, Coords coords) relocate,
            AddressSearchBuilder waypointBuilder,
            WaypointsManager waypointsMgr,
          }) {
            if (controller.text.isEmpty)
              relocate(AddressId.origin, initialCoords);
            return Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    onTap: _handleTap,
                    initialCameraPosition: defaultPosition,
                    markers: Set.from(Mymarker),
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      _locatePosition();
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 12,
                  right: 55,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black45,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: originCtrl,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => originBuilder.buildDefault(
                            builder: AddressDialogBuilder(),
                            onDone: (Address address) {
                              //ubicar el punto seleccionado en el mapa y zacerle zoom
                              positionSelected(address.coords);
                              print(
                                  'los puntos latlang del punto seleecionado son ${address.coords.latitude}');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: _fabAddLocation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //metodo agregar marcador al mapa
  _handleTap(LatLng tappedPoint) {
    setState(() {
      Mymarker.clear();
      Mymarker.add(Marker(

          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            //  print(dragEndPosition);
          }));
      Provider.of<ShopsProvider>(context, listen: false).setUbicationShop(tappedPoint.latitude, tappedPoint.longitude);
    print("${tappedPoint.latitude}");
    });

    final CameraPosition positionSelectedMarker = CameraPosition(
      target: LatLng(tappedPoint.latitude, tappedPoint.longitude),
      zoom: 16,
    );

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(positionSelectedMarker));
  }

  //camapa por defecto en Puerto Montt
  static final CameraPosition defaultPosition = CameraPosition(
    target: LatLng(-41.46574, -72.94289),
    zoom: 14.4746,
  );

  //metodo para desplazar la camara y poner un marcado en el latlang especificado
  void positionSelected(LatLng latLng) {
    //se configura la posicion de la camara
   /* final CameraPosition positionSelected = CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 17,
    );
    *///añadir marcado al mapa
    _handleTap(latLng);
    //animacion de la camara al punto
   //
    }

  Widget _fabAddLocation() {
    final snackBar = SnackBar(content: Text('Seleccione una ubicacion!'));
    return Consumer<ShopsProvider>(
      builder: (context,provider,child) =>
       FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Añardir Direccion',
          onPressed: () {
            //capturar el punto seleccionado por el usuario y guardarlo en el provider
            provider.longitud ==0 || provider.latitud ==0? Scaffold.of(context).showSnackBar(snackBar):
            _alertDialogAddLocation();
          }),
    );
  }

  Future<void> _alertDialogAddLocation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return Consumer<ShopsProvider>(
          builder: (context,provider, child)=>
          AlertDialog(
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Center(
              child: Column(
                children: [
                  lottie.Lottie.asset('assets/ubication.json',width: 75,height: 75,repeat: false
                  ),
                  Text(
                    'Confirmacion Ubicacion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: ColorPalete.color5),
                  ),
                ],
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    '¿Esta es la ubicacion la cual desea selccionar para ubicar la tienda en la aplicacion? coordenadas seleccionadas: ',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16,color: ColorPalete.color2),
                  ),Text(
                    '${provider.latitud} , ${provider.longitud}',
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 14,color: ColorPalete.color2),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: ColorPalete.color4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: ColorPalete.color2,
                child: Text('Si'),
                onPressed: () {
                  //Metodo para guardar las cordenadas en el provider

                  _backscreen();

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void _backscreen(){

    Navigator.of(context).pop();
  }

  //funcion para determinar la locacion del dispocitivo
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
