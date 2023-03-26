import 'package:environment_app/News/newscontent.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/primary_appbar.dart';

Future<List> getNews(String tag, String from_date, String to_date) async {
  final apiKey = '90166e7fedb747b59ff59ad7be9b71eb';
  final url =
      'https://newsapi.org/v2/everything?q=$tag&from=$from_date&to=$to_date&sortBy=publishedAt&apiKey=$apiKey';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    final articles = result['articles'];
    return articles;
  } else {
    throw Exception('Failed to load news');
  }
}

class datenews extends StatefulWidget {
  const datenews({super.key});

  @override
  State<datenews> createState() => _datenewsState();
}

class _datenewsState extends State<datenews> {
  final tag = 'environment';
  //take date from calendar yyyy-mm-dd
  final from_date = '';
  final to_date = '';
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
          future: getNews(tag, from_date, to_date),
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
                  return InkWell(
                    onDoubleTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return newscontent(
                            url: article['url'],
                            img: article['urlToImage'],
                            title: article['title'],
                            desc: article['description'],
                            pubAt: article['publishedAt'],
                            author: article['author'],
                            content: article['content']);
                      }));
                    },
                    child: Stack(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(width: 0.5, color: Colors.white60),
                              borderRadius: BorderRadius.circular(
                                20,
                              )),
                          child: Container(
                            //margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(
                                      article['urlToImage'] == null
                                          ? img
                                          : article['urlToImage']),
                                ),
                                Container(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 35, 86, 81),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            article['title'],
                                            style: TextStyle(
                                              color: Colors.grey[50],
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            article['description'],
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 153, 151, 151),
                                              fontSize: 10.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
        ));
  }
}
