import 'package:flutter/material.dart';

class CardItem {
  final String assetImage;
  final String title;
  final String desc;
  const CardItem({
    required this.assetImage,
    required this.title,
    required this.desc,
  });
}

List<CardItem> items = [
  CardItem(
    assetImage: 'images/soilPollution.png',
    title: "LAND POLLUTION",
    desc: "",
  ),
  CardItem(
    assetImage: 'images/waterPollution.png',
    title: "WATER POLLUTION",
    desc: "",
  ),
  CardItem(
    assetImage: 'images/airPollution.png',
    title: "AIR POLLUTION",
    desc: "",
  ),
  CardItem(
    assetImage: 'images/noisePollution.png',
    title: "NOISE POLLUTION",
    desc: "",
  ),
  CardItem(
    assetImage: 'images/lightPollution.png',
    title: "LIGHT POLLUTION",
    desc: "",
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
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  item.assetImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.desc,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w100,
              color: Colors.grey,
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
