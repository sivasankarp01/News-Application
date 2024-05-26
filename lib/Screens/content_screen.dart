import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapplication/Models/news_model.dart';

class ContentPage extends StatelessWidget {
 
  final NewsArticle article;
  const ContentPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.source),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(article.name,style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Published At : ${article.publishedAt}",style: TextStyle(color: Colors.grey)),
            Text(article.description),
            Text(article.content),


          ],
        ),
      ),
    );
  }
}