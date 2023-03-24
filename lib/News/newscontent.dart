import 'package:flutter/material.dart';

class newscontent extends StatefulWidget {
  const newscontent(
      {super.key,
      required this.url,
      required this.img,
      required this.title,
      required this.desc,
      required this.pubAt,
      required this.author,
      required this.content});
  final url, img, title, desc, author, content, pubAt;

  @override
  State<newscontent> createState() => _newscontentState();
}

class _newscontentState extends State<newscontent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
