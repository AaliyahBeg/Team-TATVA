List<String> dayDropdownValues = <String>["","","","","","",""];
const List<String> aqiDropdownValues = <String>[
  "AQI",
  "PM 2.5",
  "PM 10",
  "CO",
  "NO",
  "NO\u2082",
  "O\u2083",
  "SO\u2082",
  "NH\u2083"
];

const List<String> monthDropdownValues = <String>[
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
// 2023-03-09 22:31:25.041

String dateToString(DateTime date) {
  String curDate = date.toString();
  String findt = curDate.substring(8, 10);
  String mon = curDate.substring(5, 7);
  switch (mon) {
    case '01':
      findt += " Jan";
      break;
    case '02':
      findt += " Feb";
      break;
    case '03':
      findt += " Mar";
      break;
    case '04':
      findt += " Apr";
      break;
    case '05':
      findt += " May";
      break;
    case '06':
      findt += " June";
      break;
    case '07':
      findt += " July";
      break;
    case '08':
      findt += " Aug";
      break;
    case '09':
      findt += " Sep";
      break;
    case '10':
      findt += " Oct";
      break;
    case '11':
      findt += " Nov";
      break;
    case '12':
      findt += " Dec";
      break;
  }
  return findt;
}

void createDayDropdownList() {
  DateTime today = DateTime.now();
  for (int i = 6; i >= 0; i--) {
    dayDropdownValues[i] = dateToString(today.subtract(Duration(days: 6 - i)));
  }
}

String findMonth(DateTime date) {
  switch (date.month) {
    case 01:
      return "January";
    case 02:
      return "February";
    case 03:
      return "March";
    case 04:
      return "April";
    case 05:
      return "May";
    case 06:
      return "June";
    case 07:
      return "July";
    case 08:
      return "August";
    case 09:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
  }
  return "";
}
