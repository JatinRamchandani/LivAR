import 'dart:convert';
import 'package:ar_flutter_dynamic2/album/album.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:http/http.dart' as http;


class RemoteObject extends StatefulWidget {

  String endpoint;

  RemoteObject({this.endpoint});


  @override
  _RemoteObjectState createState() => _RemoteObjectState();
}

class _RemoteObjectState extends State<RemoteObject> {

  @override
  Widget build(BuildContext context) {
    String src = 'http://192.168.43.183:3000/raw/' + widget.endpoint ;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Model Viewer")),
        body:
            ModelViewer(
              src: src,
              alt: "A 3D model of an astronaut",
              ar: true,
              autoRotate: true,
              cameraControls: true,

            )
        )
      );
  }
}

