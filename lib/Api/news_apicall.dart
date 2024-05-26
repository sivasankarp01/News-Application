import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapplication/Models/news_model.dart';

class NewsApi {
  Future<List<NewsArticle>> fetchnews(String category,int page) async {
    final String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&page=$page&apiKey=a03338c9d343452d93245f625ed58324';

    final response = await http.get(Uri.parse(apiUrl));
 
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      for (var item in articlesJson) {
        if (item is Map<String, dynamic>) {
          item['bookmark'] = false;
        }
      }

      
      List<NewsArticle> article = articlesJson
          .map((dynamic item) => NewsArticle.fromJson(item))
          .toList();
      return article;
    } else {
      print(response.body);
      throw Exception('Failed to load users');
    }
  }
}
