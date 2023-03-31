import 'package:flutter/material.dart';

class CardItem {
  final String assetImage;
  final String title;
  const CardItem({
    required this.assetImage,
    required this.title,
  });
}

List<CardItem> items = [
    CardItem(
      assetImage:
          'images/soilPollution.png',
      title: "LAND POLLUTION",
    ),
    CardItem(
      assetImage:
          'images/waterPollution.png',
      title: "WATER POLLUTION",
    ),
    CardItem(
      assetImage:
          'images/airPollution.png',
      title: "AIR POLLUTION",
    ),
    CardItem(
      assetImage:
          'images/noisePollution.png',
      title: "NOISE POLLUTION",
    ),
    CardItem(
      assetImage:
          'images/lightPollution.png',
      title: "LIGHT POLLUTION",
    ),
  ];

  Widget buildCard({
  required CardItem item,
}) =>
    Container(
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 4/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  item.assetImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'
            ),
          ),
          Container(
            child: getWidget(item.title),
          ),
        ],
      ),
    );
Widget getWidget(String title) {
  if (title == 'LAND POLLUTION')
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  else if (title == 'WATER POLLUTION')
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  else if (title == 'AIR POLLUTION')
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SizedBox(height: 20,),
          // Text(
          //   "AQI GRAPHS",
          //   style: TextStyle(
          //     fontWeight: FontWeight.w400,
          //     fontSize: 20,
          //   ),
          // ),
        ],
      ),
    );
  else if (title == 'NOISE POLLUTION')
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  else if (title == 'LIGHT POLLUTION')
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  else
    return Container();
}