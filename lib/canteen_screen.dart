import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mensa_app/canteen_service.dart';
import 'package:mensa_app/rss_service.dart';

import 'day_menu_screen.dart';

class CanteenScreen extends StatefulWidget {
  final String canteenName;
  final int canteenId;
  final CanteenRssService canteenRssService;

  CanteenScreen(this.canteenName, this.canteenId, this.canteenRssService);

  @override
  State createState() =>
      new CanteenScreenState(canteenName, canteenId, canteenRssService);
}

class CanteenScreenState extends State<CanteenScreen> {
  String canteenName;
  int canteenId;
  CanteenRssService canteenRssService;

  List<DayEntry> today;
  List<DayEntry> thisWeek;
  List<DayEntry> nextWeek;

  CanteenScreenState(this.canteenName, this.canteenId, this.canteenRssService);

  void initState() {
    super.initState();

    if (menuThisWeek.contains(canteenName)) {
      //debugPrint("Loading: $canteenName $canteenId ${MenuDate.this_week.toString()}");
      canteenRssService
          .getMenu(canteenId, MenuDate.this_week)
          .then((dayEntries) {
        setState(() => thisWeek = dayEntries);
      });
    } else {
      if (menuToday.contains(canteenName)) {
        //debugPrint("Loading: $canteenName $canteenId ${MenuDate.today.toString()}");
        canteenRssService.getMenu(canteenId, MenuDate.today).then((dayEntries) {
          setState(() => today = dayEntries);
        });
      }
    }

    if (menuNextWeek.contains(canteenName)) {
      //debugPrint("Loading: $canteenName $canteenId ${MenuDate.next_week.toString()}");
      canteenRssService
          .getMenu(canteenId, MenuDate.next_week)
          .then((dayEntries) {
        setState(() => nextWeek = dayEntries);
      });
    }
  }

  List<Card> _buildDayMenuCards(List<DayEntry> dayEntries) {
    List<Card> cards = [];

    var today = DateTime.now();

    for (var dayEntry in dayEntries) {
      cards.add(
        Card(
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new DayMenuScreen(dayEntry)),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(dayEntry.day),
                      ),
                      ("${today.day}" == dayEntry.date.split('.')[0])
                          ? Text(
                              "Heute",
                              style: TextStyle(color: Colors.lightBlue),
                            )
                          : Text(dayEntry.date),
                    ],
                  ),
                  new Flexible(child: new Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return cards;
  }

  Container _createSeperator(var title) {
    return new Container(
      height: 40,
      color: Colors.lightBlue.shade100,
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 18.0),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();

    if (menuThisWeek.contains(canteenName)) {
      children.add(_createSeperator("Diese Woche"));

      if (thisWeek != null) {
        //debugPrint("Creating\n${thisWeek.toString()}");
        children.addAll(_buildDayMenuCards(thisWeek));
      }
    } else {
      if (menuToday.contains(canteenName)) {
        children.add(_createSeperator("Heute"));

        if (today != null) {
          //debugPrint("Creating\n${today.toString()}");
          children.addAll(_buildDayMenuCards(today));
        }
      }
    }

    if (menuNextWeek.contains(canteenName)) {
      children.add(_createSeperator("Nächste Woche"));
      if (nextWeek != null) {
        //debugPrint("Creating\n${nextWeek.toString()}");
        children.addAll(_buildDayMenuCards(nextWeek));
      }
    }

    return new Scaffold(
        appBar: new AppBar(
          title: Text(canteenName),
        ),
        body: new ListView(
          children: children,
        ));
  }
}
