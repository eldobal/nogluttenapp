import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ShopsProvider extends ChangeNotifier{

  int numero = 0;
  //se pueden declarar los controladores de textfiel en el provider para accederlos con los consumers
  final nombreTienda = TextEditingController();

  String ciudadSelecionada ='';

  void setCiudadSelecionada(String ciudad){
    ciudadSelecionada = '${ciudad.toString()}';
    notifyListeners();
  }


  void increment(){
    numero++;
    notifyListeners();}

  void decrement(){
    numero--;
    notifyListeners();}


}