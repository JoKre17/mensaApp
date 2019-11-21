import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mensa_app/google_image_search_service.dart';

void main() {
  test('Test to fetch an image from ecosia using query.', () async {
    final service = GoogleImageSearchService();

    Future<FadeInImage> imageSuggestion = service.getImageSuggestion("bunter maiseintopf mit pilzen");
    imageSuggestion.then((image) => expect(image != null, true));

    await Future.wait([imageSuggestion]);
  });
}