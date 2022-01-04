import 'dart:convert';

import 'package:helloworld/model/articles.dart';
import 'package:http/http.dart' as http;

class ArticleHelper{
  List<Articles> articleList = <Articles>[];
  //String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=79767cd4e7e248c8ae67eab27b525e1e";
  String url = "https://newsapi.org/v2/top-headlines?country=au&apiKey=79767cd4e7e248c8ae67eab27b525e1e";
  Future getArticles()async{
    var response = await http.get(Uri.parse(url));

    print(response.statusCode);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == 'ok'){
      jsonData['articles'].forEach((element){
        Articles articles = Articles(
            element['author']??"এইটা পাওয়া যাইতাসে না ",
            element['title']??"",
            element['description']??"",
            element['url']??"",
            element['urlToImage']??"https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b6e0b072897469.5bf6e79950d23.gif",
            element['publishedAt']??"",
            element['content']??""
        );
        articleList.add(articles);
      });
    }
  }
}