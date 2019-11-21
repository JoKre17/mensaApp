import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mensa_app/ingredients.dart';

class CanteenRssService {
  // actually use the TXT format since it is easier parsable. :D
  final _baseUrl = 'http://www.stwh-portal.de/mensa/index.php?format=txt';

  Future<List<DayEntry>> getMenu(var mensaId, MenuDate menuDate) {
    final _targetUrl = _getUrl(mensaId, menuDate);

    return http.read(_targetUrl).then((response) => _parseMenu(response));
  }

  String _getUrl(var mensaId, MenuDate menuDate) {
    var menuDateId = menuDate.index + 1;

    return "$_baseUrl&wo=$mensaId&wann=$menuDateId";
  }

  List<DayEntry> _parseMenu(String response) {
    var entries = List<DayEntry>();

    var dayEntryDate;
    var dayEntryDay;
    var mealEntries;

    // states for the parsing
    var readingMeals = false;

    response.split('\n').forEach((line) {
      if (line.startsWith('#')) {
        var dateSplit = line.replaceAll('#', '').trim().split(' ');
        dayEntryDay = dateSplit[0];
        dayEntryDate = dateSplit[1];
        mealEntries = List<MealEntry>();
        readingMeals = true;
        return;
      }

      if (readingMeals) {
        if (line.startsWith('>')) {
          mealEntries.add(MealEntry.fromString(line));
          return;
        } else {
          entries.add(DayEntry(dayEntryDate, dayEntryDay, mealEntries));
          readingMeals = false;
        }
      }
    });

    return entries;
  }

}

enum MenuDate { today, this_week, next_week }

class DayEntry {
  final date;
  final day;
  List<MealEntry> entries;

  DayEntry(this.date, this.day, this.entries);

  String toString() => "$date $day\n${entries.toString()}";

}

class MealEntry {
  String category;
  String type;
  String description;
  List<Ingredients> ingredients;
  List<double> prices;

  MealEntry(this.category, this.type, this.description, this.ingredients,
      this.prices);

  MealEntry.fromString(String line) {
    line = line.replaceAll(">", "").trimLeft();

    var categoryEndIndex = line.indexOf(':');
    this.category = line.substring(0, categoryEndIndex).trim();

    if (this.category.contains('(')) {
      var typeStartIndex = this.category.indexOf('(');

      this.type = this
          .category
          .substring(typeStartIndex + 1, this.category.length - 1)
          .trim();
      this.category = this.category.substring(0, typeStartIndex).trim();
    }

    var descriptionEndIndex = categoryEndIndex + 2 +
        line.substring(categoryEndIndex + 2).indexOf(':') - 1;
    this.description =
        line.substring(categoryEndIndex + 2, descriptionEndIndex).trim();

    if (this.description.contains("(")) {
      this.ingredients = List<Ingredients>();
      var ingredientsStartIndex = this.description.indexOf('(');

      this
          .description
          .substring(ingredientsStartIndex + 1, this.description.length - 1)
          .split(")(")
          .forEach((ingredientsIdentifier) =>
              ingredients.add(Ingredient.ingredientsFromIdentifier(ingredientsIdentifier)));
      this.description =
          this.description.substring(0, ingredientsStartIndex).trim();
    }

    this.prices = List<double>();
    line
        .substring(descriptionEndIndex)
        .replaceAll(new RegExp(r'[KB:\|€]'), "").replaceAll(',', '.').trim().split(new RegExp(r'[/\s]+'))
        .forEach((price) => prices.add(double.parse(price)));

  }

  String toString() => "$category $type $description $ingredients ${prices.toString()}";
}
