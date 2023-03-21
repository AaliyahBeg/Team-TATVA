import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'components/primary_appbar.dart';

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

class _NewsState extends State<News> {
  final tag = 'environment';
  final img =
      'https://media.istockphoto.com/id/167231386/photo/detail-of-white-smoke-polluted-sky.jpg?b=1&s=170667a&w=0&k=20&c=GKnZABKAO6ItSF0yuLWwgF57QewpMi6-zMNUwrzyrU0=';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'news',
        ),
        preferredSize: const Size.fromHeight(110.0),
      ),
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
                  title: Text(
                    // article['title'] == null ? 'Title' :
                      article['title']),
                  subtitle: Text(
                    // article['description'] == null
                    //   ? 'description'
                    //   :
                      article['description']),
                  leading: Image.network(article['urlToImage'] == null
                      ? img
                      : article['urlToImage']),
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