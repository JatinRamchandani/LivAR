import 'package:ar_flutter_dynamic2/screens/create_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'screens/remote_object.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Dynamo',
                    textScaleFactor: 5.0,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 150.00),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FlatButton(
                      child:Text('Create Model'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CreateObj()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
