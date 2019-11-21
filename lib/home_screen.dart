import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mensa_app/canteen_screen.dart';
import 'package:mensa_app/canteen_service.dart';
import 'package:mensa_app/rss_service.dart';

class MensaHomeScreen extends StatefulWidget {
  @override
  State createState() => new MensaHomeScreenState();
}

class MensaHomeScreenState extends State<MensaHomeScreen> {
  List<String> _result;
  Map<String, int> canteenMap;

  final canteenService = CanteenService();
  final rssService = CanteenRssService();

  void initState() {
    super.initState();

    canteenService.getCanteenMap().then((canteenMap) {
      setState(() {
        _result = canteenMap.keys.toList();
        this.canteenMap = canteenMap;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_result == null) {
      return new Container();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Hannover Mensa App'),
        ),
        body: ListView.builder(
            itemCount: _result.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(
                  child: new InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CanteenScreen(_result[index],
                            canteenMap[_result[index]], rssService)),
                  );
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(_result[index]),
                    ),
                    new Flexible(
                      child: new Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ));
            }));
  }
}
