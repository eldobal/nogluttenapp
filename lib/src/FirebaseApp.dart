import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:nogluttenapp/src/listabandas.dart';


void main() {
  runApp(iniciofirebase());
}

class iniciofirebase extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {return Text('Ta malo');}

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ListaBandas();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}