import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rosaire/main.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'meditation_affiche.dart';
import '_param.dart';

class UserLog extends StatefulWidget {
  @override
  State<UserLog> createState() => _UserLogState();
}

class _UserLogState extends State<UserLog> {
  String uPrenom = "";
  String uEmail = "";
  String uVille = "";
  String uUsernum = "";
  String uEkipnum = "";
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }


  @override
  void ValidForm(BuildContext ctx) async {
    // on appel la requete serveur

    String urlCreation =
        "https://app.equipes-rosaire.org/user2.php?Prenom=$uPrenom&Email=$uEmail&Ville=$uVille&Usernum=$uUsernum&Ekipnum=$uEkipnum";
    //print('i_f.dart : urlCreation : ' + urlCreation);
    var uri = Uri.parse(urlCreation);
    var response = await http.post(uri);

    print('i_f.dart : ${response.body}');
    var jsonMedit = jsonDecode(response.body);

    String uLogin = jsonMedit['Login'];

    // on sauvegarde Login ( id )
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ppLogin', uLogin);

    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => MyApp()));
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: Display(context).h() * 10,
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              child: Image.asset(
                'assets/EDR-logo-long.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Text(
                      'En remplissant ce formulaire vous recevrez tous les jours une m??ditation tenant compte de votre num??ro d\'??quipier et du calendrier des myst??res',
                      textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
                    ),
                                    //
                  // SAISIE DU PRENOM
                  //
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vous devez saisir votre pr??nom';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          uPrenom = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          focusColor: Colors.green,
                          hintText: 'Saisir votre pr??nom',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 129, 135, 135),
                              fontStyle: FontStyle.italic),
                          labelText: 'Pr??nom',
                          labelStyle: TextStyle(color: Color(0xFF3E938A)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3E938A),
                              width: 2,
                            ),
                          ),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 20, 24),
                        )
                      ),
                  ),
                  //
                  // SAISIE DE L'EMAIL
                  //
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !isEmailValid(value)) {
                            return 'Adresse email non conforme';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          uEmail = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          hintText: 'Saisir votre email',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 129, 135, 135),
                              fontStyle: FontStyle.italic),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF3E938A)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3E938A),
                              width: 2,
                            ),
                          ),
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 20, 24),
                        ),
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  //
                  // SAISIE DE LA VILLE
                  //                  
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre ville';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        uVille = text;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisir votre ville',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 129, 135, 135),
                            fontStyle: FontStyle.italic),
                        labelText: 'Ville',
                        labelStyle: TextStyle(color: Color(0xFF3E938A)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF3E938A),
                            width: 2,
                          ),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(15, 10, 20, 24),
                      ),
                    ),
                  ),
                  //
                  // SAISIE DU NUMERO D'EQUIPIER
                  //                  
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre n?? d\??quipier';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          uUsernum = text;
                        },
                        keyboardType:TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Saisir votre num??ro d\'??quipier',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 129, 135, 135),
                              fontStyle: FontStyle.italic),
                          labelText: 'Num??ro d\'??quipier',
                          labelStyle: TextStyle(color: Color(0xFF3E938A)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3E938A),
                              width: 2,
                            ),
                          ),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 20, 24),
                        ),
                      )),
                  //
                  // SAISIE DU NUMERO D'EQUIPE
                  //                  
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre n?? d\??quipe';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          uEkipnum = text;
                        },
                        keyboardType:TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Si vous le connaissez...',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 129, 135, 135),
                              fontStyle: FontStyle.italic),
                          labelText: 'Num??ro d\'??quipe',
                          labelStyle: TextStyle(color: Color(0xFF3E938A)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF3E938A),
                              width: 2,
                            ),
                          ),
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 20, 24),
                        ),
                      )),

                
                    Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      child: Text('Je m\'inscris pour m??diter'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black54,
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                      onPressed: () {
                        // on verifie que les champs ne sont plus vides
                        if (_formKey.currentState!.validate()) {
                          ValidForm(context);
                        }
                      },
                    ),
                  ),],
              ),
            ),
          ),
        ),
      );
    });
  }
}
