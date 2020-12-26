import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:nogluttenapp/src/widgets/alertDialogHorarios.dart';
import 'package:provider/provider.dart';

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
                    builder: (context,provider,child)=>Text('Mañana: ${provider.horaDesdeLVM} - ${provider.horaHastaLVM}' )),

                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<ShopsProvider>(
                            builder: (context, provider, child) => RaisedButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text('Desde'),
                                onPressed: () {
                                  //se llama al picker de horas
                                  provider.setTimePickerSeleccionado('desdem');
                                  _alertDialogAddHorario();
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<ShopsProvider>(
                            builder: (context, provider, child) =>



                                RaisedButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text('Hasta'),
                                onPressed: () {
                                  //se llama al picker de horas
                                  provider.setTimePickerSeleccionado('hastam');
                                  _alertDialogAddHorario();
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text('Tarde'),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<ShopsProvider>(
                            builder: (context, provider, child) => RaisedButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text('Desde'),
                                onPressed: () {
                                  //se llama al picker de horas
                                  provider.setTimePickerSeleccionado('desdet');
                                  _alertDialogAddHorario();
                                }),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<ShopsProvider>(
                            builder: (context, provider, child) => RaisedButton(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text('Hasta'),
                                onPressed: () {
                                  //se llama al picker de horas


                                  provider.setTimePickerSeleccionado('hastat');
                                  _alertDialogAddHorario();
                                }),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),

    );
  }

  //alertdialog de confimacion de la ubicacion
  Future<void> _alertDialogAddHorario() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return AlertDialogHorarios();
      },
    );
  }
}
