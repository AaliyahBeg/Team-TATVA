import 'package:unixtime/unixtime.dart';
import 'package:date_util/date_util.dart';

int getUnix(String date, String time) {
  int unix;
  String dt = date.substring(0, 2);
  String mon = date.substring(3);
  String findt = "${DateTime.now().year}-";
  switch (mon) {
    case 'Jan':
      findt += "01-";
      break;
    case 'Feb':
      findt += "02-";
      break;
    case 'Mar':
      findt += "03-";
      break;
    case 'Apr':
      findt += "04-";
      break;
    case 'May':
      findt += "05-";
      break;
    case 'June':
      findt += "06-";
      break;
    case 'July':
      findt += "07-";
      break;
    case 'Aug':
      findt += "08-";
      break;
    case 'Sep':
      findt += "09-";
      break;
    case 'Oct':
      findt += "10-";
      break;
    case 'Nov':
      findt += "11-";
      break;
    case 'Dec':
      findt += "12-";
      break;
  }
  findt += dt + " " + time;
  unix = DateTime.parse(findt).unixtime;
  return unix;
}

List<int> getMonthUnix(String m) {
  String month = "";
  switch (m) {
    case "January":
      month = "01";
      break;
    case "February":
      month = "02";
      break;
    case "March":
      month = "03";
      break;
    case "April":
      month = "04";
      break;
    case "May":
      month = "05";
      break;
    case "June":
      month = "06";
      break;
    case "July":
      month = "07";
      break;
    case "August":
      month = "08";
      break;
    case "September":
      month = "09";
      break;
    case "October":
      month = "10";
      break;
    case "November":
      month = "12";
      break;
    case "December":
      month = "12";
      break;
  }
  List<int> start_end = [1,2];
  int curMon = DateTime.now().month;
  String start = "", end = "";
  var dateUtility = new DateUtil();
  int year = DateTime.now().year;
  if (int.parse(month) > curMon) {
    start = (year - 1).toString() + "-";
    end = (year - 1).toString() + "-";
  } else {
    start = year.toString() + "-";
    end = year.toString() + "-";
  }
  start += month + "-01 00:00:00.000";
  end += month +
      "-" +
      dateUtility.daysInMonth(int.parse(month), year).toString() +
      " 23:59:59.000";
  start_end[0] = DateTime.parse(start).unixtime;
  start_end[1] = DateTime.parse(end).unixtime;

  return start_end;
}
