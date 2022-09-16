import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ar_msg.dart';

class EnvMsg extends StatelessWidget {
  // paramètres reçus de bouton Message dans accueil.dart
  final String aLogin;
  final String aPrenom;
  final String aEmail;
  String TexteMessage = "";

  EnvMsg(this.aLogin, this.aPrenom, this.aEmail);

  @override
  void ValidForm(BuildContext ctx) async {
    String urlCreation =
        "http://app.equipes-rosaire.org/msg2.php?Login=$aLogin&Prenom=$aPrenom&Email=$aEmail&TexteMessage=$TexteMessage";
    print('envoimsg.dart/ValidForm() urlCreation : ' + urlCreation);

    var uri = Uri.parse(urlCreation);
    var response = await http.post(uri);
    print('envoimsg.dart/ValidForm()  Response body: ${response.body}');

    var jsonArMsg = jsonDecode(response.body);
    var bLogin = jsonArMsg['Login'];
    var bPrenom = jsonArMsg['Prenom'];
    var bEmail = jsonArMsg['Email'];
    var bTexteMessage = jsonArMsg['TexteMessage'];

    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (ctx) => ArMsg(bLogin, bPrenom, bEmail, bTexteMessage)));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              height: 80,
              child: Image.asset(
                'assets/EdR_splash.png',
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
                Text("Bonjour $aPrenom, \nmerci de nous contacter, nous vous répondrons dans les meilleurs délais."),
                Text("Votre email : $aEmail\n"),
                Container(
                  child: TextField(
                    style: TextStyle (height:1.0),
                    minLines: 3,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    onChanged: (text) {
                      print('TexteMessage : $text');
                      TexteMessage = text;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre message',),
                  ),
                ),
                TextButton(
                  child: Text('Envoyer votre message'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                  onPressed: () {
                    ValidForm(context);
                  },
                ),
                SizedBox(height: 20.0),
                Text('Merci de votre participation')
              ],
            ),
          ),
        ),
      );
    });
  }
}
