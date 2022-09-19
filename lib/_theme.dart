import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData MonTheme(BuildContext context) {
  return ThemeData(

      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      textTheme: TextTheme(
        headline1: GoogleFonts.juliusSansOne(
            fontSize: 30, fontWeight: FontWeight.w900),
        headline2: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
        headline3: GoogleFonts.cormorant(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 0, 0),
            fontStyle: FontStyle.italic),
        headline4: GoogleFonts.juliusSansOne(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        headline5: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        headline6: GoogleFonts.juliusSansOne(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic),
        bodyText1: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        bodyText2:
            GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
      ));
}

ButtonStyle MonStyledeBouton = ElevatedButton.styleFrom(
  textStyle: const TextStyle(fontSize: 20, color: Colors.amber),
  primary: Colors.black26,
);
