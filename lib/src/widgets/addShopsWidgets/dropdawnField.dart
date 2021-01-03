import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/constantes/ColorPalete.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

/// This is the stateful widget that the main application instantiates.
class dropdawnWidget extends StatefulWidget {
  dropdawnWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<dropdawnWidget> {
  String dropdownValue = 'Seleccione una ciudad';
  List<Ciudad> _companies = Ciudad.getCiudades();
  List<DropdownMenuItem<Ciudad>> _dropdownMenuItems;
  Ciudad _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    //onChangeDropdownItem(_selectedCompany);
    super.initState();
  }

  //metodo en el cual se recorre la lista de ciudades y le setea en el dropdawn
  List<DropdownMenuItem<Ciudad>> buildDropdownMenuItems(List ciudades) {
    List<DropdownMenuItem<Ciudad>> items = List();
    for (Ciudad ciudad in ciudades) {
      items.add(
        DropdownMenuItem(
          value: ciudad,
          child: Center(child: textCustomStyle(ciudad.name)),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Ciudad selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
      Provider.of<ShopsProvider>(context, listen: false)
          .setCiudadSelecionada(_selectedCompany.name);

      //provider.setCiudadSelecionada(_selectedCompany.name);
      //setiar el valor del dropdawn en el provider
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem),
          ),
          textCustomStyle('Has seleccionado: ${_selectedCompany.name}'),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }


  Widget textCustomStyle(String texto) {
    return Column(
      children: [
        Text(
          "$texto",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: ColorPalete.color5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}



class Ciudad {
  int id;
  String name;

  Ciudad(this.id, this.name);

  static List<Ciudad> getCiudades() {
    return <Ciudad>[
      Ciudad(1, 'Seleccione una Ciudad'),
      Ciudad(2, 'Puerto Montt'),
      Ciudad(3, 'Puerto Varas'),
      Ciudad(4, 'Osorno'),
      Ciudad(5, 'Valdivia'),
      Ciudad(6, 'Temuco'),
    ];
  }
}
