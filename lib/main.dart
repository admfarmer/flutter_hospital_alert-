import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hospital_alert/api.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alart System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hospital Alart System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = new LocalStorage('todo_app');

  TextEditingController ctrlDescription = TextEditingController();
  TextEditingController ctrlHosname = TextEditingController();
  TextEditingController ctrlAmphur = TextEditingController();
  TextEditingController ctrlProvince = TextEditingController();
  TextEditingController ctrlHcode = TextEditingController();
  TextEditingController ctrlUrlapi = TextEditingController();
  Api api = Api();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future<void> showEntryDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Description'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: ctrlDescription,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      fillColor: Colors.white10,
                      filled: true,
                      helperText: 'รายละเอียดการขอความช่วยเหลือ'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () async {
                var Description = ctrlDescription.text;
                try {
                  var rs = await api.doInsert(Description);
                  if (rs.statusCode == 200) {
                    Navigator.of(context).pop();
                  } else {
                    print('Connection error!');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showHospitalInfo() async {

    print(storage.getItem('Hosname'));
    print(storage.getItem('Hcode'));
    print(storage.getItem('Amphur'));
    print(storage.getItem('Province'));
    print(storage.getItem('Urlapi'));

    ctrlHosname.text = storage.getItem('Hosname');
    ctrlHcode.text = storage.getItem('Hcode');
    ctrlAmphur.text = storage.getItem('Amphur');
    ctrlProvince.text = storage.getItem('Province');
    ctrlUrlapi.text = storage.getItem('Urlapi');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hospital Info'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: ctrlHosname,
                  decoration: InputDecoration(
                      labelText: 'Hosname',
                      fillColor: Colors.white10,
                      filled: true),
                ),
                TextFormField(
                  controller: ctrlHcode,
                  decoration: InputDecoration(
                      labelText: 'Hcode',
                      fillColor: Colors.white10,
                      filled: true),
                ),
                TextFormField(
                  controller: ctrlAmphur,
                  decoration: InputDecoration(
                      labelText: 'Amphur',
                      fillColor: Colors.white10,
                      filled: true),
                ),
                TextFormField(
                  controller: ctrlProvince,
                  decoration: InputDecoration(
                      labelText: 'Province',
                      fillColor: Colors.white10,
                      filled: true),
                ),
                TextFormField(
                  controller: ctrlUrlapi,
                  decoration: InputDecoration(
                      labelText: 'Urlapi',
                      fillColor: Colors.white10,
                      filled: true),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () async {
                var Hosname = ctrlHosname.text;
                var Hcode = ctrlHcode.text;
                var Amphur = ctrlAmphur.text;
                var Province = ctrlProvince.text;
                var Urlapi = ctrlUrlapi.text;

                storage.setItem('Hosname', Hosname);
                storage.setItem('Hcode', Hcode);
                storage.setItem('Amphur', Amphur);
                storage.setItem('Province', Province);
                storage.setItem('Urlapi', Urlapi);

                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Center(
        child: new GestureDetector(
          onTap: () {
            showEntryDialog();
          },
          child: new Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                border: Border.all(color: Colors.red[900], width: 10)),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Help Me!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showHospitalInfo();
          },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


