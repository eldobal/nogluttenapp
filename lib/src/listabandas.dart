import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nogluttenapp/src/provider/shopsProvider.dart';
import 'package:provider/provider.dart';

class ListaBandas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //  final shopsprovider = Provider.of<ShopsProvider>(context,listen: false);
    return  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bandnames').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          List<DocumentSnapshot> docs = snapshot.data.docs;
          return ListView.builder(
              itemExtent: 80.0,
              itemCount: docs.length,
              itemBuilder: (context, index){
                Map<String, dynamic> data = docs[index].data();
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Center(
                        child: Text(
                            data['name']
                        ),
                      )),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffddddff),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data['vote'].toString(),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      Consumer<ShopsProvider>(
                        builder: (context,provider, child) => Text('${provider.numero}')
                      ),

                    ],
                  ),
                );
              }
          );
        },

    );
  }
}