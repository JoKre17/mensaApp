import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mensa_app/google_image_search_service.dart';
import 'package:mensa_app/ingredients.dart';
import 'package:mensa_app/rss_service.dart';
import 'package:transparent_image/transparent_image.dart';

class DayMenuScreen extends StatefulWidget {
  DayEntry dayEntry;

  DayMenuScreen(this.dayEntry);

  @override
  State<StatefulWidget> createState() {
    return DayMenuScreenState(dayEntry);
  }
}

class DayMenuScreenState extends State<DayMenuScreen> {
  static final GoogleImageSearchService _googleImageSearchService =
      new GoogleImageSearchService();

  DayEntry dayEntry;

  DayMenuScreenState(this.dayEntry);

  Map<Choice, bool> activatedSettings = {choices[0]: true};

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      activatedSettings.putIfAbsent(choice, () => false);

      activatedSettings[choice] = !activatedSettings[choice];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List<Widget>();

    var currentCategory = "";
    var currentType = "";

    for (var mealEntry in dayEntry.entries) {
      // include logic, if containing multiple entries or is main entry
      if (mealEntry.type != null) {
        // has shared title
        if (currentType != mealEntry.type) {
          currentType = mealEntry.type;
          children.add(new Container(
            padding: EdgeInsets.only(left: 8.0),
            height: 30,
            color: Colors.lightBlue.shade100,
            alignment: Alignment.centerLeft,
            child: Text(
              currentType,
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      } else {
        if (currentCategory != mealEntry.category) {
          currentCategory = mealEntry.category;
          children.add(new Container(
            padding: EdgeInsets.only(left: 8.0),
            height: 30,
            color: Colors.lightBlue.shade100,
            alignment: Alignment.centerLeft,
            child: Text(
              mealEntry.category,
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }

      children.add(new MealCard(mealEntry, _googleImageSearchService, activatedSettings[choices[0]]));
    }

    return new Scaffold(
        appBar: new AppBar(
          title: Text(dayEntry.day),
          actions: <Widget>[
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(choice.icon),
                        ),
                        Text(choice.title),
                        (activatedSettings.containsKey(choice) && activatedSettings[choice]) ? Icon(Icons.check, size: 20,) : Container(width: 20,)
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: ListView(
          children: children,
        ));
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Bildvorschlag', icon: Icons.image),
];

class MealCard extends StatelessWidget {
  MealEntry mealEntry;
  GoogleImageSearchService googleImageSearchService;
  var activatedImageSuggestions = true;

  MealCard(this.mealEntry, this.googleImageSearchService, this.activatedImageSuggestions);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientHints = new List<Widget>();
    for (var i in mealEntry.ingredients) {
      ingredientHints.add(Text(Ingredient.ingredientsToShortString(i)));
    }

    return new Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          activatedImageSuggestions ? FutureBuilder(
            future: googleImageSearchService
                .getImageSuggestion(mealEntry.description),
            builder: (BuildContext context, AsyncSnapshot<FadeInImage> image) {
              if (image.hasData) {
                return image.data; // image is ready
              } else {
                return Image.memory(
                  kTransparentImage,
                  width: 80,
                  height: 80,
                ); // placeholder
              }
            },
          ) : Container(),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Text(
                    mealEntry.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 8.0),
            child: Column(
              children: ingredientHints,
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

/*
class MealCard extends StatefulWidget {

  var _extended = false;

  MealEntry mealEntry;
  GoogleImageSearchService googleImageSearchService;

  MealCard(this.mealEntry, this.googleImageSearchService);

  @override
  State<StatefulWidget> createState() {
    return MealCardState(mealEntry, googleImageSearchService);
  }


}

class MealCardState extends State<MealCard> {

  MealEntry _mealEntry;
  GoogleImageSearchService _googleImageSearchService;

  MealCardState(this._mealEntry, this._googleImageSearchService);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientHints = new List<Widget>();
    for (var i in _mealEntry.ingredients) {
      ingredientHints.add(Text(Ingredient.ingredientsToShortString(i)));
    }

    return new Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FutureBuilder(
            future: _googleImageSearchService
                .getImageSuggestion(_mealEntry.description),
            builder: (BuildContext context, AsyncSnapshot<FadeInImage> image) {
              if (image.hasData) {
                return image.data; // image is ready
              } else {
                return Image.memory(
                  kTransparentImage,
                  width: 80,
                  height: 80,
                ); // placeholder
              }
            },
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Text(
                    _mealEntry.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 8.0),
            child: Column(
              children: ingredientHints,
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

}
*/
