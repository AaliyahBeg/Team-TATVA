import 'package:environment_app/News/datenews.dart';
import 'package:environment_app/News/newscontent.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/primary_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class datenews_home extends StatefulWidget {
  const datenews_home({super.key});

  @override
  State<datenews_home> createState() => _datenews_homeState();
}

class _datenews_homeState extends State<datenews_home> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  void _onDateSelected(DateTime Day, DateTime focusedDay) {
    setState(() {
      _selectedDay = Day;
      _focusedDay = focusedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

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
              height: 30,
            ),
            Text(
              'Pick a Date',
              style: TextStyle(
                color: Color.fromARGB(255, 29, 71, 31),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.now(),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              onDaySelected: _onDateSelected,
            ),
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                print('hi' + _selectedDay.toString().split(" ")[0]);
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return datenews(date: _selectedDay.toString().split(" ")[0]);
                }));
              },
              icon: Icon(Icons.arrow_forward),
            ),
            Image(
              width: double.infinity, //media query otherwise
              image: AssetImage('images/calendar2.webp'),
            ),
          ],
        )));
  }
}
