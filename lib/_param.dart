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


const coloredIcon1 = {
  "J": 'assets/ico1-J.png',
  "L": 'assets/ico1-L.png',
  "D": 'assets/ico1-D.png',
  "G": 'assets/ico1-G.png',
};

const coloredIcon2 = {
  "J": 'assets/ico2-J.png',
  "L": 'assets/ico2-L.png',
  "D": 'assets/ico2-D.png',
  "G": 'assets/ico2-G.png',
};

const coloredIcon4 = {
  "J": 'assets/ico4-J.png',
  "L": 'assets/ico4-L.png',
  "D": 'assets/ico4-D.png',
  "G": 'assets/ico4-G.png',
};


const coloredIcon5 = {
  "J": 'assets/ico5-J.png',
  "L": 'assets/ico5-L.png',
  "D": 'assets/ico5-D.png',
  "G": 'assets/ico5-G.png',
};


const coloredIcon6 = {
  "J": 'assets/ico6-J.png',
  "L": 'assets/ico6-L.png',
  "D": 'assets/ico6-D.png',
  "G": 'assets/ico6-G.png',
};


const coloredIcon7 = {
  "J": 'assets/ico7-J.png',
  "L": 'assets/ico7-L.png',
  "D": 'assets/ico7-D.png',
  "G": 'assets/ico7-G.png',
};

const famille = {
  "J": "joyeux",
  "L": "lumineux",
  "D": "douloureux",
  "G": "glorieux",
};
