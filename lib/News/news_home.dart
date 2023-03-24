import 'package:carousel_slider/carousel_slider.dart';
import 'package:environment_app/News/news_titles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../components/primary_appbar.dart';
import 'package:environment_app/News/news.dart';

class News_home extends StatefulWidget {
  const News_home({super.key});

  @override
  State<News_home> createState() => _News_homeState();
}

Widget carousel_item(String carousel_img) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(carousel_img), fit: BoxFit.fill),
    ),
  );
}

Widget news_title(String news_img, String news_text, String news_route,
    BuildContext context) {
  return GestureDetector(
    onTap: () => {
      Navigator.pushNamed(context, news_route)
      //Navigator.of(context).pushNamed(news_route);
    },
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.white60),
          borderRadius: BorderRadius.circular(
            20,
          )),
      child: Container(
        child: Row(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color: Color.fromARGB(153, 63, 101, 74)),
                  borderRadius: BorderRadius.circular(
                    20,
                  )),
              child: Image(
                width: 100,
                height: 100,
                image: AssetImage(news_img),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(child: Text(news_text)),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    ),
  );
}

class _News_homeState extends State<News_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'news',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListBody(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                      items: [
                        carousel_item(ci[0]),
                        carousel_item(ci[1]),
                        carousel_item(ci[2]),
                      ],
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        initialPage: 0,
                        autoPlayCurve: Curves.decelerate,
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        viewportFraction: 0.7,
                      ))
                ],
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: Color.fromARGB(255, 29, 71, 31),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Saved News',
                        style: TextStyle(
                          color: Color.fromARGB(255, 76, 117, 78),
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, 'saved_news'),
                          icon: Icon(Icons.save_alt))
                    ],
                  ),
                ],
              ),
              news_title(ni[0], nt[0], 'news_page1', context),
              news_title(ni[1], nt[1], 'news_page2', context),
              news_title(ni[2], nt[2], 'news_page3', context),
            ],
          ),
        ));
  }
}
