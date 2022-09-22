import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'meditation_affiche.dart';

class ArMsg extends StatelessWidget {
  // paramètres reçus de la bdd  app_msg2
  final String bLogin;
  final String bPrenom;
  final String bEmail;
  final String bTexteMessage;

  ArMsg(this.bLogin, this.bPrenom, this.bEmail, this.bTexteMessage);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              height: 80,
              child: Image.asset(
                'assets/EDR-logo-long.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                    "nous avons bien reçu votre message dont voici les caractéristiques"),
                Text(bLogin),
                Text(bPrenom),
                Text(bEmail),
                Text(bTexteMessage)
              ],
            ),
          ),
        ),
      );
    });
  }
}
