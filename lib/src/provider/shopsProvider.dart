import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopsProvider extends ChangeNotifier {
  double latitud = 0;
  double longitud = 0;

  TimeOfDay horarioDesdeM = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioHastaM = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioDesdeT = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioHastaT = TimeOfDay(hour: 0, minute: 0);

  //se pueden declarar los controladores de textfiel en el provider para accederlos con los consumers
  final nombreTienda = TextEditingController();

  String ciudadSelecionada = '';

  void setCiudadSelecionada(String ciudad) {
    ciudadSelecionada = '${ciudad.toString()}';
    notifyListeners();
  }

  void setHorarios(TimeOfDay timeStartMorning, TimeOfDay timeEndMorning,TimeOfDay timeStartEvening, TimeOfDay timeEndEvening) {
    horarioDesdeM = timeStartMorning;
    horarioHastaM = timeEndMorning;
    horarioDesdeT = timeStartEvening;
    horarioHastaT = timeEndEvening;
    notifyListeners();
  }


  void clearTimers(){
    horarioDesdeM=TimeOfDay(hour:0,minute: 0);
    horarioHastaM=TimeOfDay(hour:0,minute: 0);
    horarioDesdeT=TimeOfDay(hour:0,minute: 0);
    horarioHastaT=TimeOfDay(hour:0,minute: 0);
    notifyListeners();
  }

  void setUbicationShop(double latitudU, double longitudU) {
    latitud = latitudU;
    longitud = longitudU;
    notifyListeners();
  }
}
