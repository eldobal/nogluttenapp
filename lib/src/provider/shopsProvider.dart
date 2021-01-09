import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/constantes/Products.dart';

class ShopsProvider extends ChangeNotifier {
  double latitud = 0;
  double longitud = 0;

  TimeOfDay horarioDesdeM = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioHastaM = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioDesdeT = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay horarioHastaT = TimeOfDay(hour: 0, minute: 0);

  //se pueden declarar los controladores de textfiel en el provider para accederlos con los consumers
  TextEditingController nombreTienda = TextEditingController();

  TextEditingController nameProduct = TextEditingController();

  TextEditingController descripcionProduct = TextEditingController();


  String ciudadSelecionada = '';


  List<Asset> images = List<Asset>();

  //productos

  List<Asset> imageProductProvider = List<Asset>();



  List<Product> ListProducts =List<Product>();

  void setImageProduct(List<Asset> image){
    imageProductProvider = image;
    notifyListeners();
  }

  void deleteProductFromList(Product product){
    ListProducts.remove(product);
    notifyListeners();
  }

  void setImageProductClear(){
    imageProductProvider = List<Asset>();
    nameProduct.clear();
    descripcionProduct.clear();
    notifyListeners();
  }

  //setear los productos a la lista del provider
  void setProducts(Product product){
    ListProducts.add(product);
    notifyListeners();
  }
 /* void setProductsClear(){
    imageProductProvider.clear();
    ListProducts.clear();
    notifyListeners();
  }*/

  void setImages(List<Asset> setimages){
    images = setimages;
    notifyListeners();
  }

  void setImagesClear(){
    images.clear();
    notifyListeners();
  }

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
