import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopsProvider extends ChangeNotifier{

  int numero = 0;
  double latitud = 0;
  double longitud =0;
  //se pueden declarar los controladores de textfiel en el provider para accederlos con los consumers
  final nombreTienda = TextEditingController();

  String ciudadSelecionada ='';

  void setCiudadSelecionada(String ciudad){
    ciudadSelecionada = '${ciudad.toString()}';
    notifyListeners();
  }


  void setUbicationShop(double latitudU, double longitudU){
    latitud = latitudU;
    longitud = longitudU;
    notifyListeners();
  }

  void increment(){
    numero++;
    notifyListeners();}

  void decrement(){
    numero--;
    notifyListeners();}




}