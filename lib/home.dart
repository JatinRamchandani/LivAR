import 'dart:convert';

import 'package:ar_flutter_dynamic2/screens/create_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'album/specs.dart';
import 'screens/remote_object.dart';
import 'dart:developer' as developer;
import 'package:color_convert/color_convert.dart';

import 'package:http/http.dart' as http;



Future<Specs>  createAlbum(String color, String length, String width, String filename) async {
  final response = await http.post(
    Uri.parse('http://192.168.43.183:3000/sendargs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{

      'color': color,
      'length': length,
      'width': width,
      'filename': filename
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Specs.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }


}



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool lightTheme = true;
  Color currentColor = Colors.blue;
  String objectname = "";
  List<Color> currentColors = [Colors.limeAccent, Colors.green];
  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);

  Future<Specs> _result;
  final TextEditingController _controller = TextEditingController();



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
                  SizedBox(height: 10.00),

                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term'
                    ),

                  ),

                  Padding(
                    padding: EdgeInsets.all(16.0),
                    // child: FlatButton(
                    //   child:Text('Pick color'),
                    //   color: Colors.blue,
                    //   textColor: Colors.white,
                    //   onPressed: (){
                    //     showDialog(
                    //         context: context,
                    //         builder:(BuildContext context){
                    //           return AlertDialog(
                    //             titlePadding: const EdgeInsets.all(0.0),
                    //             contentPadding: const EdgeInsets.all(0.0),
                    //             content: SingleChildScrollView(
                    //               child: ColorPicker(
                    //                 pickerColor: currentColor,
                    //                 onColorChanged: changeColor,
                    //                 colorPickerWidth: 300.0,
                    //                 pickerAreaHeightPercent: 0.7,
                    //                 enableAlpha: true,
                    //                 displayThumbColor: true,
                    //                 showLabel: true,
                    //                 paletteType: PaletteType.hsv,
                    //                 pickerAreaBorderRadius: const BorderRadius.only(
                    //                   topLeft: const Radius.circular(2.0),
                    //                   topRight: const Radius.circular(2.0),
                    //                 ),
                    //
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //   }
                    // ),
                      child:AlertDialog(
                        elevation: 1,
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            displayThumbColor: true,
                            showLabel: true,
                            paletteType: PaletteType.hsv,
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(2.0),
                              topRight: const Radius.circular(2.0),
                            ),

                          ),
                        ),
                      )
                  ),

                  SizedBox(height: 10.00),

                  FlatButton(
                    child: Text('Send'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        _result = createAlbum(currentColor.toString().substring(10,16), _controller.text.toString() , '69', '');
                      });
                      // developer.log(currentColor.toString(), name: "THIS IS COLORRRRRRRRRRR");
                    },
                  ),

                  FutureBuilder<Specs>(
                    future: _result,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.result);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return Text('');
                    },
                  ),


                  SizedBox(height: 10.00),
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

