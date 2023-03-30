import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../components/primary_appbar.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

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
    // ignore: deprecated_member_use
    List<Widget> vector = <Widget>[];
    vector.add(Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.white60),
          borderRadius: BorderRadius.circular(
            20,
          )),
    ));
    vector.add(FutureBuilder<List>(
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
              return Stack(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.5, color: Colors.white60),
                        borderRadius: BorderRadius.circular(
                          20,
                        )),
                    child: Container(
                      //margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(article['urlToImage'] == null
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
                                        color:
                                            Color.fromARGB(255, 153, 151, 151),
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
              );
              // return ListTile(
              //   title: Text(
              //       // article['title'] == null ? 'Title' :
              //       article['title']),
              //   subtitle: Text(
              //       // article['description'] == null
              //       //   ? 'description'
              //       //   :
              //       article['description']),
              //   leading: Image.network(article['urlToImage'] == null
              //       ? img
              //       : article['urlToImage']),
              // );
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
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'news',
          ),
          preferredSize: const Size.fromHeight(110.0),
        ),
        body: ListBody(
          children: vector,
        ));
  }
}

// class _NewsState extends State<News> {
//   final tag = 'environment';
//   final img =
//       'https://media.istockphoto.com/id/167231386/photo/detail-of-white-smoke-polluted-sky.jpg?b=1&s=170667a&w=0&k=20&c=GKnZABKAO6ItSF0yuLWwgF57QewpMi6-zMNUwrzyrU0=';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         child: PrimaryAppBar(
//           page: 'news',
//         ),
//         preferredSize: const Size.fromHeight(110.0),
//       ),
//       body: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
//                 margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 208, 242, 207),
//                   // border: Border.symmetric(color: Colors.black),
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromARGB(255, 224, 222, 222),
//                       offset: Offset(5.0, 5.0),
//                       blurRadius: 6.0,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   child: Text(
//                     'Best way to stay connected and keeping yourself updated regarding the latest News on Environment.\n',
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 3, 17, 16),
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             child: FutureBuilder<List>(
//               future: getNews(tag),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final articles = snapshot.data;
//                   // int? x;
//                   // if(articles?.length==Null) x=0;
//                   // else x=articles?.length;
//                   return ListView.builder(
//                     //itemCount:x,
//                     itemBuilder: (context, index) {
//                       final article = articles?[index];
//                       return Stack(
//                         children: [
//                           Card(
//                             elevation: 5,
//                             shape: RoundedRectangleBorder(
//                                 side: BorderSide(
//                                     width: 0.5, color: Colors.white60),
//                                 borderRadius: BorderRadius.circular(
//                                   20,
//                                 )),
//                             child: Container(
//                               //margin: EdgeInsets.all(10),
//                               child: Column(
//                                 children: [
//                                   Image(
//                                     image: NetworkImage(
//                                         article['urlToImage'] == null
//                                             ? img
//                                             : article['urlToImage']),
//                                   ),
//                                   Container(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.teal[200],
//                                         borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(20),
//                                             bottomRight: Radius.circular(20)),
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             child: Text(
//                                               article['title'],
//                                               style: TextStyle(
//                                                 color: Colors.grey[50],
//                                                 fontSize: 14.0,
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.all(10),
//                                             child: Text(
//                                               article['description'],
//                                               style: TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 153, 151, 151),
//                                                 fontSize: 10.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                       // return ListTile(
//                       //   title: Text(
//                       //       // article['title'] == null ? 'Title' :
//                       //       article['title']),
//                       //   subtitle: Text(
//                       //       // article['description'] == null
//                       //       //   ? 'description'
//                       //       //   :
//                       //       article['description']),
//                       //   leading: Image.network(article['urlToImage'] == null
//                       //       ? img
//                       //       : article['urlToImage']),
//                       // );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('${snapshot.error}'),
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
