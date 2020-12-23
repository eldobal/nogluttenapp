import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/constantes/constantes.dart';




class ejemplosWidget extends StatefulWidget {
  @override
  _ejemplosWidgetState createState() => _ejemplosWidgetState();
}

class _ejemplosWidgetState extends State<ejemplosWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;



  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(15, (index){
        return OpenContainer(closedBuilder: (context,action){
          return buildListTile(index);
        }, openBuilder: (context,action,){
          return SelectedItemPage(seletedItem: index);
        });
      }
      ),
    );
  }

}


class SelectedItemPage extends StatelessWidget{

  final constantes = Constantes();

  SelectedItemPage({
    Key key,
    @required this.seletedItem,
  }) : super(key: key);

  final int seletedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected item page"),
      ),
      body: Container(
        child: Image.network('${constantes.imagenprueba}'),
      ),

    );
  }
}


Widget buildListTile(int index) {
  return ListTile(
    title:Text(
      index.toString(),
    ),
  );
}
