import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../components/primary_appbar.dart';

class News_home extends StatefulWidget {
  const News_home({super.key});

  @override
  State<News_home> createState() => _News_homeState();
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
        body: Column(
          children: [],
        ));
  }
}
