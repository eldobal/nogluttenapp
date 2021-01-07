import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

class WidgetProduct extends StatefulWidget {
  @override
  _WidgetProductState createState() => _WidgetProductState();
}

class _WidgetProductState extends State<WidgetProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Consumer<ShopsProvider>(
          builder: (context, provider, child) => provider.ListProducts.length != 0
              ? CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 450,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: provider.ListProducts.length,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      _bodyWidgetProducts(itemIndex))
              : Text('')),
    );
  }

  Widget _bodyWidgetProducts(int item) {
    return SingleChildScrollView(
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<ShopsProvider>(
            builder: (context, provider, child) => Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AssetThumb(
                      asset: provider.ListProducts[item].imageProduct.last,
                      width: 400,
                      height: 400,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${provider.ListProducts[item].nameProduct.toUpperCase()}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: ColorPalete.color5),
                    textAlign: TextAlign.center,
                  ),
                ),
                textCustomStyle(
                    '${provider.ListProducts[item].descriptionProduct}', 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textCustomStyle(String texto, double fontSize) {
    return Column(
      children: [
        Text(
          "$texto",
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: ColorPalete.color3),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
