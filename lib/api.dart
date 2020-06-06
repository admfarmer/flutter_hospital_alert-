import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class Api {
  Api();

//  String apiUrl = 'http://localhost:3000';


  Future doInsert(String Description) async {
    final LocalStorage storage = new LocalStorage('todo_app');

    String apiUrl = storage.getItem('Urlapi');

    String _url = '$apiUrl/v1/insert';

    print(_url);

    var body = {
      "hos_name": storage.getItem('Hosname'),
      "hcode": storage.getItem('Hcode'),
      "amphur": storage.getItem('Amphur'),
      "province": storage.getItem('Province'),
      "type": 'mobile',
      "remark": Description.toString()
    };

    return await http.post(_url, body: body);
  }

}
