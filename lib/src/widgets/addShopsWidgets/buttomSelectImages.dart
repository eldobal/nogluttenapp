import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

class buttomSelectImages extends StatefulWidget {


  @override
  _buttomSelectImagesState createState() => _buttomSelectImagesState();
}

class _buttomSelectImagesState extends State<buttomSelectImages> {
  List<Asset> images = List<Asset>();

  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
        builder: (context, provider, child) => RaisedButton(
          color: ColorPalete.color3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text("Seleccione las fotos del local"),
          onPressed: () async {
            provider.setImagesClear();
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
                  useDetailsView: true,
                  selectCircleStrokeColor: "#000000",
                ),
              );
            } on Exception catch (e) {
              error = e.toString();
            }
            if (!mounted) return;

            setState(() {
              provider.setImages(resultList);
              print(provider.images.length);
              _error = error;
            });
          },
        ));
  }
}
