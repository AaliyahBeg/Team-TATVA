import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> getNews(String tag) async {
  final apiKey = '90166e7fedb747b59ff59ad7be9b71eb';
  final url = 'https://newsapi.org/v2/everything?q=$tag&apiKey=$apiKey';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final articles = result['articles'];
    return articles;
  } else {
    throw Exception('Failed to load news');
  }
}
class News extends StatefulWidget {
  @override
  _NewsState createState() => new _NewsState();
}

class _NewsState extends State<News>{
  final tag = 'environment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getNews(tag),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            final articles = snapshot.data;
            // int? x;
            // if(articles?.length==Null) x=0;
            // else x=articles?.length;
              return ListView.builder(

              //itemCount:x,
              itemBuilder: (context, index) {
                final article = articles?[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description']),
                  leading: Image.network(article['urlToImage']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

