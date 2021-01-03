import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class HorariosShop extends StatefulWidget {
  @override
  _HorariosShopState createState() => _HorariosShopState();
}

class _HorariosShopState extends State<HorariosShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agrege el horario de la tienda',
          style:
              TextStyle(color: ColorPalete.color4, fontStyle: FontStyle.italic),
        ),
      ),
      body: _horariosBody(),
    );
  }

  TimeOfDay _horariodesdeM;
  TimeOfDay _horariohastaM;
  TimeOfDay _horariodesdeT;
  TimeOfDay _horariohastaT;
  bool tardeCorrecto = false;

  Widget _horariosBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
                child: Text(
              'Seleccione el horario de atencion al publico general',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            )),
          ),
          Card(
            color: ColorPalete.color4,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Lunes a Viernes.',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                ),
                Consumer<ShopsProvider>(
                    builder: (context, provider, child) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _horariodesdeM != null &&
                                  _horariohastaM != null
                              ? Text(
                                  'Mañana: ${_horariodesdeM.format(context)} - ${_horariohastaM.format(context)}')
                              : Center(
                                  child: Text(
                                      'Seleccione un horario de inicio y uno de fin.')),
                        )),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, right: 32.0, bottom: 16),
                        child: Consumer<ShopsProvider>(
                          builder: (context, provider, child) => RaisedButton(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Text("Seleccionar Horario mañana"),
                            onPressed: () => TimeRangePicker.show(
                              timeRangeViewType: TimeRangeViewType.start,
                              context: context,
                              autoAdjust: true,
                              onSubmitted: (TimeRangeValue value) {
                                setState(() {
                                  _horariodesdeM = value.startTime;
                                  _horariohastaM = value.endTime;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer<ShopsProvider>(
                    builder: (context, provider, child) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _horariodesdeT != null &&
                                  _horariohastaT != null &&
                                  _horariodesdeM.hour < _horariodesdeT.hour &&
                                  _horariohastaM.hour < _horariodesdeT.hour
                              ? Text(
                                  'Tarde: ${_horariodesdeT.format(context)} - ${_horariohastaT.format(context)}')
                              : Center(
                                  child: Text(
                                      'Seleccione un horario de inicio y uno de fin.')),
                        )),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left:32.0, right: 32,top: 20,bottom: 32),
                        child: Consumer<ShopsProvider>(
                          builder: (context, provider, child) => RaisedButton(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text('Seleccionar Horario Tarde'),
                              onPressed: () => TimeRangePicker.show(
                                    timeRangeViewType: TimeRangeViewType.start,
                                    context: context,
                                    autoAdjust: true,
                                    onSubmitted: (TimeRangeValue value) {
                                      setState(() {
                                        _horariodesdeT = value.startTime;
                                        _horariohastaT = value.endTime;
                                        tardeCorrecto = true;
                                      });
                                    },
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer<ShopsProvider>(
            builder: (context, provider, child) => _horariodesdeM != null &&
                    _horariohastaM != null &&
                    _horariodesdeT != null &&
                    _horariohastaT != null &&
                    _horariodesdeM.hour < _horariodesdeT.hour &&
                    _horariohastaM.hour < _horariodesdeT.hour
                ? RaisedButton(
                    color: ColorPalete.color3,
                    child: Text('Confirme los Horarios'),
                    onPressed: () {
                      //se debe mostrar un alert dialog para poder realizar la confirmacion

                      _alertDialogAddHorarios();
                    })
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Seleccione Correcamente el horario'),
                  ),
          ),
        ],
      ),
    );
  }

  //alertdialog de confimacion de la ubicacion
  Future<void> _alertDialogAddHorarios() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
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
                  Center(
                    child: Text(
                      'Horario de atencion',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Text(
                      'El horario seleccionado que se presenta a continuacion esta correcto?'),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _horariodesdeM != null && _horariohastaM != null
                          ? Text(
                              'Mañana: ${_horariodesdeM.format(context)} - ${_horariohastaM.format(context)}',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text('')),
                  Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: _horariodesdeM != null && _horariohastaM != null
                          ? Text(
                              'Tarde: ${_horariodesdeT.format(context)} - ${_horariohastaT.format(context)}',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(''))
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
                builder: (context, provider, child) => RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: ColorPalete.color2,
                  child: Text('Si'),
                  onPressed: () {
                    //verificar si la hora de hasta es mayor a la de desde
                    provider.setHorarios(_horariodesdeM, _horariohastaM,
                        _horariodesdeT, _horariohastaT);
                    print(
                        '/${provider.horarioDesdeM.format(context)}/${provider.horarioHastaM.format(context)}/${provider.horarioDesdeT.format(context)}/${provider.horarioHastaT.format(context)}/');
                    Navigator.of(context).pop();
                    backScreen();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget backScreen() {
    Navigator.pop(context);
  }
}
