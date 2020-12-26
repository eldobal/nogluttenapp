import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart' as lottie;

class AlertDialogHorarios extends StatefulWidget {
  AlertDialogHorarios();

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
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              hourMinute15Interval(),/*
              Consumer<ShopsProvider>(
                  builder:(context,provider,child)=>
                  Text('horario seleccionado: ${provider.horaHastaLVT}'))*/
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
          Consumer<ShopsProvider>(
            builder: (context,provider,child)=> RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: ColorPalete.color2,
              child: Text('Si'),
              onPressed: () {
                //verificar si la hora de hasta es mayor a la de desde



                _backscreen();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _backscreen() {
    //
    /*  Navigator.of(context).pop();
  */
  }
  Widget hourMinute15Interval() {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => new TimePickerSpinner(
        time: DateTime.now(),
        spacing: 80,
        isForce2Digits: true,
        minutesInterval: 15,
        onTimeChange: (time) {
          setState(() {
            switch(provider.timepickerSeleccionado) {
              case 'desdem': {
                provider.setHoraDesdeLVM(time.hour, time.minute);
              }
              break;
              case 'hastam': {
                provider.setHoraHastaLVM(time.hour, time.minute);
              }
              break;
              case 'desdet': {
                provider.setHoraDesdeLVT(time.hour, time.minute);
              }
              break;
              case 'hastat': {
                provider.setHoraHastaLVT(time.hour, time.minute);
              }
              break;
            }
          });
        },
      ),
    );
  }
}
