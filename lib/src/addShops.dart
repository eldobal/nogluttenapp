import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
        _seleccionarCiudad(),
        _agregarNombreTienda(),
        _agregarUbicacion()
      ],
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
                      Text('seleccione el lugar donde reside la tienda')),
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
                        : Center(child: Text(' Ha selecionado la ubicacion',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: ColorPalete.color5),))
                  ],
                ),
    );
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
}
