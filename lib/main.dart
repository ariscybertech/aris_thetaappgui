import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:thetaapp/get_info.dart';
import 'package:thetaapp/get_metadata.dart';
import 'package:thetaapp/post_state.dart';
import 'package:thetaapp/take_picture.dart';
import 'package:thetaapp/list_files.dart';
import 'package:thetaapp/get_options.dart';
import 'package:thetaapp/get_last_image_url.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String textResponse;

  int maxResponseLength = 3000;

  void setResponse(response) {
    setState(() {
      String stringResponse = response.body.toString();
      if (stringResponse.length > maxResponseLength - 1) {
        textResponse = stringResponse.substring(0, maxResponseLength);
      } else {
        textResponse = stringResponse;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("THETA App"),
          backgroundColor: Color(0xfff0cf85),
        ),
        backgroundColor: Colors.blueGrey[50],
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Image(image: AssetImage("doc/museum.jpg")),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xffa4d4ae),
                    label: Text("listFiles"),
                    onPressed: () {
                      print('list files');
                      listFiles().then((response) {
                        setResponse(response);
                      });
                    },
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xffa4d4ae),
                    label: Text("getOptions"),
                    onPressed: () {
                      print('get options');
                      getOptions().then((response) {
                        setResponse(response);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xff32afa9),
                    label: Text("downloadFile"),
                    onPressed: () {},
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xff32afa9),
                    label: Text("getMetadata"),
                    onPressed: () {
                      getLastImageUrl().then((url) {
                        getMetadata(url).then((response) {
                          setResponse(response);
                        });
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xffe7f0c3),
                    label: Text("Info",
                        style: TextStyle(color: Colors.blueGrey[200])),
                    onPressed: () {
                      print("get info");
                      getInfo().then((response) {
                        setState(() {
                          if (response.length > maxResponseLength - 1) {
                            textResponse =
                                response.substring(0, maxResponseLength);
                          } else {
                            textResponse = response;
                          }
                        });
                      });
                    },
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xffe7f0c3),
                    label: Text("State",
                        style: TextStyle(color: Colors.blueGrey[200])),
                    onPressed: () {
                      print('show camera state');
                      postState().then((response) {
                        setResponse(response);
                      });
                    },
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: Color(0xffe7f0c3),
                    label: Text("takePicture",
                        style: TextStyle(color: Colors.blueGrey[200])),
                    onPressed: () {
                      print('take picture');
                      takePicture().then((response) {
                        setResponse(response);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Text('$textResponse'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
