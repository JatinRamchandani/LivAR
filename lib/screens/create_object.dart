import 'dart:async';
import 'dart:convert';
import 'package:ar_flutter_dynamic2/album/album.dart';
import 'package:ar_flutter_dynamic2/album/specs.dart';
import 'package:ar_flutter_dynamic2/screens/remote_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter_spinkit/flutter_spinkit.dart';


Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('http://192.168.43.183:3000/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CreateObj extends StatefulWidget {
  @override
  _CreateObjState createState() => _CreateObjState();
}

class _CreateObjState extends State<CreateObj> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                developer.log(snapshot.data.endpoint, name: 'EEEEEEEEEEEEEEEEEEEEEE');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemoteObject(endpoint : snapshot.data.endpoint),
                ));
                return Text(snapshot.data.endpoint);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Scaffold(
                backgroundColor: Colors.blue,
                body: Center(
                  child: SpinKitCubeGrid(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
