import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopsProvider extends ChangeNotifier {

  double latitud = 0;
  double longitud = 0;

  int horaDesdelvm = 0;
  int minutoDesdelvm = 0;
  int horaHastalvtm = 0;
  int minutoHastalvm = 0;
  int horaDesdelvt = 0;
  int minutoDesdelvt = 0;
  int horaHastalvt = 0;
  int minutoHastalvt = 0;
  String horaDesdeLVM = '';
  String horaHastaLVM = '';
  String horaDesdeLVT = '';
  String horaHastaLVT = '';

  String timepickerSeleccionado = '';

  //se pueden declarar los controladores de textfiel en el provider para accederlos con los consumers
  final nombreTienda = TextEditingController();

  String ciudadSelecionada = '';

  void setCiudadSelecionada(String ciudad) {
    ciudadSelecionada = '${ciudad.toString()}';
    notifyListeners();
  }

  void setTimePickerSeleccionado(String timepicker) {
    timepickerSeleccionado = timepicker;
  }

  void setHoraDesdeLVM(int hora, int minutos) {
    horaDesdeLVM = '${hora}:${minutos}';
    horaDesdelvm = hora;
    minutoDesdelvm = minutos;
    notifyListeners();
  }

  void setHoraHastaLVM(int hora, int minutos) {
    horaHastaLVM = '${hora}:${minutos}';
    horaDesdelvm = hora;
    minutoHastalvm = minutos;
    notifyListeners();
  }
  void setHoraDesdeLVT(int hora, int minutos) {
    horaDesdeLVT = '${hora}:${minutos}';
    horaDesdelvt = hora;
    minutoDesdelvt = minutos;
    notifyListeners();
  }
  void setHoraHastaLVT(int hora, int minutos) {
    horaHastaLVT = '${hora}:${minutos}';
    horaHastalvt = hora;
    minutoHastalvt = minutos;
    notifyListeners();
  }

  void setTimeClear(){
    horaDesdelvm=0;
    minutoDesdelvm=0;
    horaHastalvtm=0;
    minutoHastalvm=0;
    horaDesdelvt=0;
    minutoDesdelvt=0;
    horaHastalvt=0;
    minutoHastalvt=0;
    notifyListeners();
  }


  void setUbicationShop(double latitudU, double longitudU) {
    latitud = latitudU;
    longitud = longitudU;
    notifyListeners();
  }

}
