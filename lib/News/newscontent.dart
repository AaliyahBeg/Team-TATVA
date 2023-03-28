import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/primary_appbar.dart';

class newscontent extends StatefulWidget {
  const newscontent(
      {Key? key,
      required this.urlstring,
      required this.url,
      required this.img,
      required this.title,
      required this.desc,
      required this.pubAt,
      required this.author,
      required this.content})
      : super(key: key);
  final urlstring, img, title, desc, author, content, pubAt;
  final Uri url;
  @override
  State<newscontent> createState() => _newscontentState();
}

class _newscontentState extends State<newscontent> {
  final default_img =
      'https://media.istockphoto.com/id/167231386/photo/detail-of-white-smoke-polluted-sky.jpg?b=1&s=170667a&w=0&k=20&c=GKnZABKAO6ItSF0yuLWwgF57QewpMi6-zMNUwrzyrU0=';

  Future<void> _launchUrl() async {
    if (!await launchUrl(widget.url)) {
      throw Exception('Could not launch $widget.url');
    }
  }

  Future<void> _launchWhatsapp() async {
    if (!await launchUrl(
        Uri.parse(
            'https:/api.whatsapp.com/send?text=${Uri.encodeFull(widget.urlstring)}'),
        //wa works with a particular phone number only , however api.whatsapp.com/send? works without it
        //the msg string had to be put inside Uri.encodeFull to work
        // Uri.encodeFull(
        //     'https:/api.whatsapp.com/send?text='),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch whatsapp');
    }
  }

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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title, style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        (widget.author == Null ? ' ' : widget.author) +
                            (widget.author == Null ? ' ' : ' | ') +
                            (widget.pubAt == Null ? ' ' : widget.pubAt),
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 20,
              shadowColor: Color.fromARGB(255, 75, 111, 77),
              margin: EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.white60),
                  borderRadius: BorderRadius.circular(
                    20,
                  )),
              child: Image(
                image:
                    NetworkImage(widget.img == null ? default_img : widget.img),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Desciption: ' + widget.desc,
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 2,
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.content,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) {
                return Size(100, 20);
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 198, 218, 198);
                } else
                  return Color.fromARGB(255, 18, 55, 19);
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 18, 55, 19);
                } else
                  return Color.fromARGB(255, 198, 218, 198);
              }),
            ),
            onPressed: _launchUrl,
            icon: Icon(Icons.read_more_outlined),
            label: Text('Read More'),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) {
                return Size(100, 20);
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 198, 218, 198);
                } else
                  return Color.fromARGB(255, 18, 55, 19);
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 18, 55, 19);
                } else
                  return Color.fromARGB(255, 198, 218, 198);
              }),
            ),
            onPressed: () => {},
            icon: Icon(Icons.save_alt),
            label: Text('Save'),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) {
                return Size(100, 20);
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 198, 218, 198);
                } else
                  return Color.fromARGB(255, 18, 55, 19);
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Color.fromARGB(255, 18, 55, 19);
                } else
                  return Color.fromARGB(255, 198, 218, 198);
              }),
            ),
            onPressed: _launchWhatsapp,
            icon: Icon(Icons.share),
            label: Text('Share'),
          ),
        ],
      ),
    );
  }
}
