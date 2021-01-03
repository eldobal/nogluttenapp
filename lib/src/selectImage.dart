import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(new SelectImage());

class SelectImage extends StatefulWidget {
  @override
  _SelectImageState createState() => new _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';




  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopsProvider>(context);
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Ejemplo de seleccion de imagenes'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Seleccione las fotos del local"),
              onPressed: () async {
                List<Asset> resultList = List<Asset>();
                String error = 'No Error Dectected';

                try {
                  resultList = await MultiImagePicker.pickImages(
                    maxImages: 3,
                    enableCamera: true,
                    selectedAssets: images,
                    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                    materialOptions: MaterialOptions(
                      actionBarColor: "#abcdef",
                      actionBarTitle: "Example App",
                      allViewTitle: "All Photos",
                      useDetailsView: false,
                      selectCircleStrokeColor: "#000000",
                    ),
                  );
                } on Exception catch (e) {
                  error = e.toString();
                }

                // If the widget was removed from the tree while the asynchronous platform
                // message was in flight, we want to discard the reply rather than calling
                // setState to update our non-existent appearance.
                if (!mounted) return;

                setState(() {
                  provider.setImages(resultList);
                  print(provider.images.length);
                  _error = error;
                });
              },
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  );
                }),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //metodo para cargar la foto en firebase //prueba01
            UploadImage(images.first);
          },
        ),
      ),
    );

  }


  Future UploadImage(Asset asset) async {
    //inicializacion de la intancia de firebase
    final _storage  = firebase_storage.FirebaseStorage.instance;

    //extraccion de la informacion y data de la fotografia
    ByteData byteData = await asset.getByteData(); // requestOriginal is being deprecated

    //se convierte la informacion a data de tipo int
    List<int> imageData = byteData.buffer.asUint8List();

    //metodo para cargar la foto en el Storage
    await _storage.ref().child("TiendN1/${asset.name}").putData(imageData); // To be aligned with the latest firebase API(4.0)

  }

}
