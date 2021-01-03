import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:nogluttenapp/src/widgets/dropdawnField.dart';
import 'package:provider/provider.dart';
import 'constantes/constantes.dart';

class addShops extends StatefulWidget {
  @override
  _addShopsState createState() => _addShopsState();
}

class _addShopsState extends State<addShops> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarAddShops(),
      body: _addShopData(),
    );
  }

  Widget _appbarAddShops() {
    return AppBar(
        title: Consumer<ShopsProvider>(
            builder: (context, provider, child) =>
                Text('Agregar tiendas en una ciudad')));
  }

  Widget _addShopData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _seleccionarCiudad(),
          Divider(
            color: ColorPalete.color5,
          ),
          _agregarNombreTienda(),
          Divider(
            color: ColorPalete.color5,
          ),
          _agregarUbicacion(),
          Divider(
            color: ColorPalete.color5,
          ),
          _agregarHorarioTienda(),
          Divider(
            color: ColorPalete.color5,
          ),
          _agregarImage(),
          Divider(
            color: ColorPalete.color5,
          ),
          _agregarProductos(),
         // viewImage()
        ],
      ),
    );
  }

  Widget _seleccionarCiudad() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Consumer<ShopsProvider>(
                  builder: (context, provider, child) =>
                      Text('Seleccione la ciudad donde reside la tienda')),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: dropdawnWidget(),
              )
            ],
          )),
    );
  }

  Widget _agregarNombreTienda() {
    return Card(
      color: ColorPalete.color4,
      child: Column(
        children: <Widget>[
          Text('Ingrese el nombre de la tienda ',
              style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Consumer<ShopsProvider>(
              builder: (context, provider, child) => TextField(
                //se necesita un controller para poder setear los datos en la variable de datoprueba
                controller: provider.nombreTienda,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  final shop = ShopsProvider();

  //metodo para ir a seleccionar la ubicacion de la tienda
  Widget _agregarUbicacion() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) =>
          //se verifica de que se halla seleccionado una ciudad valida antes de ingresar la direccion
          provider.ciudadSelecionada == ('Seleccione una Ciudad') ||
                  provider.ciudadSelecionada.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('SELECCCIONE UNA CIUDAD'),
                )
              : Column(
                  children: [
                    Text(
                        'Agregar ubicacion de la tienda ${provider.ciudadSelecionada}'),
                    RaisedButton(
                        child: Text('Agregar Ubicacion'),
                        onPressed: () {
                          Provider.of<ShopsProvider>(context, listen: false)
                              .setUbicationShop(0.0, 0.0);
                          final ubicacion = Constantes().addubicacionShop;
                          Navigator.pushNamed(context, ubicacion.toString());
                        }),
                    provider.longitud == 0 && provider.latitud == 0
                        ? Text('')
                        : Center(
                            child: Text(
                            ' Ha selecionado la ubicacion',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorPalete.color5),
                          ))
                  ],
                ),
    );
  }

  Widget _agregarHorarioTienda() {
    return Column(
      children: [
        Text('Seleccione los horarios establecidos de la tienda'),
        Consumer<ShopsProvider>(
          builder: (context, provider, child) => RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text('Seleccionar Horarios'),
            onPressed: () {
              provider.clearTimers();
              final horarios = Constantes().addHorarios;
              Navigator.pushNamed(context, horarios.toString());
            },
          ),
        ),
        Center(
          child: Consumer<ShopsProvider>(
              builder: (context, provider, child) =>
                  provider.horarioDesdeM.hour != 0 &&
                          provider.horarioDesdeM.minute != 0 &&
                          provider.horarioHastaM.hour != 0 &&
                          provider.horarioHastaM.minute != 0 &&
                          provider.horarioDesdeT.hour != 0 &&
                          provider.horarioDesdeT.minute != 0 &&
                          provider.horarioHastaT.hour != 0 &&
                          provider.horarioHastaT.minute != 0
                      ? textCustomStyle(
                          'Se han seleccionado los horarios correctamente')
                      : Text('')),
        ),
      ],
    );
  }

  final imgprueba = Constantes().imagenprueba;
  List<int> list = [1,2,3,4,5];
  //widget para seleccionar 3 fotos del dispositivo y visualizarlas
  Widget _agregarImage() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Pick images"),
            onPressed: (){
              final constantes = Constantes().addImages;
              //metodo para obtener las 3 fotos del local
              Navigator.pushNamed(context, constantes);
            },
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child:CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.5,
                    enlargeCenterPage: true,
                  ),
                  carouselController: _controller,
                  items: provider.images.map((item) => Container(
                    child: Center(
                        child: AssetThumb(
                          asset: item,
                          width: 800,
                          height: 800,
                        )
                    ),
                  )).toList(),
                )
            ),
        ],
      ),
    );
  }

  Widget _agregarProductos(){
    return RaisedButton(onPressed:(){});
  }

  Widget _fabAddDataFirestore() {
    Firebase.initializeApp();
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //ad data to firebasw
            String addnombretienda = provider.nombreTienda.text;
            //se crea un mapa de strings a dinamicos para poder ser agregados a la coleccion
            /* Map<String, dynamic> dataaddfirebase = {
              'name': '$uwu',
              'telefono': '$uwu'
            };
           */ //se identifica a la coleccion y se agrega a firebase
            /*  CollectionReference collectionReference =
                FirebaseFirestore.instance.collection("datosprueba");
            collectionReference.add(dataaddfirebase);
          */
          }),
    );
  }

  Widget textCustomStyle(String texto) {
    return Column(
      children: [
        Text(
          "$texto",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: ColorPalete.color2),
        ),
      ],
    );
  }
}
