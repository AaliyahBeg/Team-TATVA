import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'air_quality.dart';
import '../confidential.dart';
import 'search_data.dart';

class AirQualityProvider with ChangeNotifier {
  final List<AirQuality> _items = [];
  SearchData? _searchData;

  Future<void> fetchAndSetData() async {
    print("In Fetch and Set Data of Air Quality Provider");
    final url = Uri.parse("https://api.waqi.info/feed/here/?token=$apiKey");
    try {
      print("In Try of Fetch and Set Data of Air Quality Provider");
      final response = await get(url);
      print(response);
      final responseData = json.decode(response.body);
      // print(responseData);
      print(AirQuality.fromJson(responseData));
      _items.insert(0, AirQuality.fromJson(responseData));
      if (_items == null) print("Null Items");
      print(_items[0].status);
      notifyListeners();
      return;
    } catch (e) {}
  }

  Future<void> dataFromSearch(String cityUrl) async {
    final Uri url =
        Uri.parse('https://api.waqi.info/feed/$cityUrl/?token=$apiKey');
    final response = await get(url);
    final responseData = json.decode(response.body);

    _items.add(AirQuality.fromJson(responseData));
    notifyListeners();
  }

  SearchData get cities {
    return _searchData!;
  }

  List<AirQuality> get items {
    return _items;
  }
}
