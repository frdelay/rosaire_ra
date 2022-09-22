import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


DateTime now = DateTime.now();
String dayOfWeek = DateFormat.EEEE().format(now);
String day = DateFormat.d().format(now);
int mois = int.parse(DateFormat.M().format(now)) - 1;
String year = DateFormat.y().format(now);

const jourFR = {
  "Monday": "lundi",
  "Tuesday": "mardi",
  "Wednesday": "mercredi",
  "Thursday": "jeudi",
  "Friday": "vendredi",
  "Saturday": "samedi",
  "Sunday": "dimanche"
};

const moisFR = [
  "janvier",
  "février",
  "mars",
  "avril",
  "mai",
  "juin",
  "juillet",
  "août",
  "septembre",
  "octobre",
  "novembre",
  "décembre"
];

const colorTitle = {
  "J": Color(0xffac7a10),
  "L": Color(0xff1957CC),
  "D": Color(0xff96143f),
  "G": Color(0xff2E986E),
};


// const coloredIcon1 = {
//   "J": 'assets/icoJ.png',
//   "L": 'assets/ico1L.png',
//   "D": 'assets/ico1D.png',
//   "G": 'assets/ico1G.png',
// };

// const coloredIcon2 = {
//   "J": 'assets/ico2J.png',
//   "L": 'assets/ico2L.png',
//   "D": 'assets/ico2D.png',
//   "G": 'assets/ico2G.png',
// };

// const coloredIcon3 = {
//   "J": 'assets/ico3J.png',
//   "L": 'assets/ico3L.png',
//   "D": 'assets/ico3D.png',
//   "G": 'assets/ico3G.png',
// };

// const coloredIcon4 = {
//   "J": 'assets/ico4J.png',
//   "L": 'assets/ico4L.png',
//   "D": 'assets/ico4D.png',
//   "G": 'assets/ico4G.png',
// };


const famille = {
  "J": "joyeux",
  "L": "lumineux",
  "D": "douloureux",
  "G": "glorieux",
};
