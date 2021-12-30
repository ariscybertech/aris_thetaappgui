import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thetaapp/pretty_print.dart';


Future<http.Response> getOptions () async {
  var url ='http://192.168.1.1/osc/commands/execute';

  /// example 1 for iso and iso support
  // Map data = {
  //   'name': 'camera.getOptions',
  //   'parameters': {
  //     'optionNames': [
  //       "iso",
  //       "isoSupport"
  //     ]
  //   }
  // };

  Map data = {
    'name': 'camera.getOptions',
    'parameters': {
      'optionNames': [
        "offDelay",
        "sleepDelay",
        "remainingSpace",
        "_colorTemperature",
        "previewFormat"
      ]
    }
  };

  //encode Map to JSON
  var body = jsonEncode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json;charset=utf-8"},
      body: body
  );
  print("${response.statusCode}");
  prettyPrint("${response.body}");
  return response;
}