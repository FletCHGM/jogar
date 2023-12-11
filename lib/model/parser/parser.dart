import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Parser {
  final _applicationID = 'sdGMR2xxn4Cza11DI2S9aHLK5FLGwBcT6F8qawgD';
  final _key = 'G18hAVdYQfLsQVxnI2C6VW41WRnpdXJ4kh9u2m3K';
  final _className = 'jogar_name';
  final _varName = 'three_name';
  final _objectID = 'HtfgdFo6Gc';

  initParser() async {
    await Parse().initialize(_applicationID, 'https://parseapi.back4app.com/',
        clientKey: _key);
  }

  parseObject() async {
    var parsedObject = await ParseObject(_className).getObject(_objectID);

    return parsedObject.result[_varName];
  }

  checkExistance(String parsedValue) async {
    final client = HttpClient();
    var uri = Uri.parse(parsedValue);
    var clientRequest = await client.getUrl(uri);
    clientRequest.followRedirects = false;
    var response = await clientRequest.close();
    var code = response.statusCode;
    return code;
  }
}
