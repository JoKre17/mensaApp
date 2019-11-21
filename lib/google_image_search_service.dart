import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:transparent_image/transparent_image.dart';

class GoogleImageSearchService {
  //var url = "https://www.google.com/search?tbm=isch&q=";
  var url = "https://www.ecosia.org/images?q=";

  Future<FadeInImage> getImageSuggestion(String query) async {
    var requestUrl = url + query.split(' ').join('+');

    debugPrint("Fetching $requestUrl");

    return await http
        .read(requestUrl)
        .then((response) => _parseImageFromResponse(response));
  }

  FadeInImage _parseImageFromResponse(String response) {
    //debugPrint(response);

    var document = parse(response);
    var imageResults = document
        .getElementsByClassName("image-results-wrapper")[0]
        .getElementsByTagName("a")
        .where((e) => e.attributes['href'].startsWith("http"));
    for (var result in imageResults) {
      debugPrint(result.attributes['href']);
      //return result.attributes['href'];
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: result.attributes['href'],
        width: 80,
        height: 80,
      );
      //return Image.network(result.attributes['href']);
    }

    return null;
  }
}
