import 'dart:convert';

import 'package:latenews/model/article_model.dart';

import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
  
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=ac26ad027e3148eead3ebe64154d22aa";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
   
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
          );
          news.add(articleModel);
        }
      });
    }
  }

    
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category) async {
  
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=ac26ad027e3148eead3ebe64154d22aa";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
   
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
          );
          news.add(articleModel);
        }
      });
    }
  }

    
}


