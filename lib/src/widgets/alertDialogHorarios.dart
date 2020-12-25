import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart' as lottie;

class AlertDialogHorarios extends StatefulWidget {
  @override
  _AlertDialogHorariosState createState() => _AlertDialogHorariosState();
}

class _AlertDialogHorariosState extends State<AlertDialogHorarios> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => AlertDialog(
        elevation: 30,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: Center(
          child: Column(
            children: [
              lottie.Lottie.asset('assets/lotties/calendar.json',
                  width: 75, height: 75, repeat: false),
              Text(
                'Confirmacion Ubicacion',
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
              Text(
                '¿Esta es la ubicacion la cual desea selccionar para ubicar la tienda en la aplicacion? coordenadas seleccionadas:',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: ColorPalete.color2),
              ),
              Text(
                '${provider.latitud} , ${provider.longitud}',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: ColorPalete.color2),
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
          ),
          RaisedButton(
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
  }

  void _backscreen() {
    Navigator.of(context).pop();
  }
}
