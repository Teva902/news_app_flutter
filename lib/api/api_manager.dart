import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

/*
https://newsapi.org/v2/top-headlines/sources?apiKey=0f0954e59a0a49569916a35e5b0effd6
 */
class ApiManager {
  static Future<SourceResponse?> getSources(
    String categoryId,
  ) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesApi, {
      'apiKey': '0f0954e59a0a49569916a35e5b0effd6',
      'category': categoryId,
    });
    var response = await http.get(url);
    try {
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  /*
  https://newsapi.org/v2/everything?q=bitcoin&apiKey=0f0954e59a0a49569916a35e5b0effd6
   */
  static Future<NewsResponse?> getNewsBySourceId(
      String sourceId, int page, String searchValue) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': '0f0954e59a0a49569916a35e5b0effd6',
      'sources': sourceId,
      'page': '$page',
      'q': searchValue
    });
    var response = await http.get(url);
    try {
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
