import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/constantes/Products.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

class AlertDialogAddProduct extends StatefulWidget {
  @override
  _AlertDialogAddProductState createState() => _AlertDialogAddProductState();
}

class _AlertDialogAddProductState extends State<AlertDialogAddProduct> {
  //clave para validar el formulario
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => AlertDialog(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Center(
          child: Column(
            children: [
              Text(
                'Agregar un Producto',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorPalete.color5),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buttomAddImage(context),
              //imagen List
              provider.imageProductProvider.length != 0
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AssetThumb(
                        asset: provider.imageProductProvider[0],
                        width: 500,
                        height: 500,
                      ),
                    )
                  : Text(''),
              _formProduct()
            ],
          ),
        ),
        actions: <Widget>[
          _buttomCancelDialog(),
          _buttomConfirmProduct(),
        ],
      ),
    );
  }

  List<Asset> imageProduct = List<Asset>();

  Widget _buttomAddImage(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => RaisedButton(
        color: ColorPalete.color1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Text('Agregar Imagen del producto'),
        onPressed: () async {
          //metodo para agregar Una fotografia del producto
          provider.setImageProductClear();
          List<Asset> resultList = List<Asset>();
          //  String error = 'No Error Dectected';
          try {
            resultList = await MultiImagePicker.pickImages(
              maxImages: 1,
              enableCamera: true,
              selectedAssets: imageProduct,
              cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
              materialOptions: MaterialOptions(
                actionBarColor: "#abcdef",
                actionBarTitle: "Example App",
                allViewTitle: "All Photos",
                useDetailsView: true,
                selectCircleStrokeColor: "#000000",
              ),
            );
          } on Exception catch (e) {}
          if (!mounted) return;
          setState(() {
            provider.setImageProduct(resultList);
            print(provider.imageProductProvider.length);
            // _error = error;
          });
        },
      ),
    );
  }

  Widget _formProduct() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => Form(
          key: _formKey,
          child: Column(children: <Widget>[
            // Add TextFormFields and ElevatedButton here.
            _textNameProduct(),
            _textDescripcionProduct()
          ])),
    );
  }

  Widget _textNameProduct() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text('Nombre del Producto'),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese un nombre de producto';
              }
              return null;
            },
            controller: provider.nameProduct,
          ),
        ],
      ),
    );
  }

  Widget _textDescripcionProduct() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text('Descripcion del Producto'),
          ),
          TextFormField(
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese la descripcion del producto';
              }
              return null;
            },
            controller: provider.descripcionProduct,
          ),
        ],
      ),
    );
  }

  Widget _buttomCancelDialog() {
    return RaisedButton(
      color: ColorPalete.color4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Text('Cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buttomConfirmProduct() {
    return Consumer<ShopsProvider>(
        builder: (context, provider, child) => RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: ColorPalete.color2,
              child: Text('Agregar producto'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //metodo para guardar el producto en el provider
                  final producto = Product(
                      provider.nameProduct.text,
                      provider.descripcionProduct.text,
                      provider.imageProductProvider);

                  provider.setProducts(producto);

                  print('${producto.nameProduct}, ${producto.descriptionProduct} , ${provider.imageProductProvider.last.identifier}');

                  Navigator.of(context).pop();
                }
              },
            ));
  }
}
