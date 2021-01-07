import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/constantes/Products.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:nogluttenapp/src/widgets/addShopsWidgets/alertDialogAddProduct.dart';
import 'package:nogluttenapp/src/widgets/addShopsWidgets/widgetProduct.dart';
import 'package:provider/provider.dart';

class addProductWidget extends StatefulWidget {
  @override
  _addProductWidgetState createState() => _addProductWidgetState();
}

class _addProductWidgetState extends State<addProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bottomAddProducts(),
        _galeryProducts()
      ],
    );
  }

  Widget _bottomAddProducts() {
    return Consumer<ShopsProvider>(
      builder: (context,provider,child)=> RaisedButton(
        color: ColorPalete.color4,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text('Agragar un Producto'),
          onPressed: () {
          //metodo para agregar un producto e invocar al alert Dialog
            provider.setImageProductClear();
            _alertDialogAddProduct();
          }),
    );
  }

  Widget _galeryProducts() {
    return WidgetProduct();
  }

  Future<void> _alertDialogAddProduct() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return AlertDialogAddProduct();
      },
    );
  }
}
