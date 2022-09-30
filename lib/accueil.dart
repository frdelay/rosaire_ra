import 'package:flutter/material.dart';
import 'package:rosaire/site_affiche.dart';
import 'ilsmeditent_affiche.dart';
import 'inscription_formulaire.dart';
import '_param.dart';

class Accueil extends StatelessWidget {
  String urlSite = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: Display(context).h() * 10,
          automaticallyImplyLeading: false,
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
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
              "\nPour recevoir chaque matin le mystère du jour correspondant à votre numéro d'équipier\n",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4),
          //
          // bouton d'affichage de la page "Je veux prier un mystère"
          //
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(Display(context).w() * 2),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserLog(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(Display(context).w() * 2),
                  child: Text('Je veux prier un mystère chaque jour',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Display(context).h() * 2.5)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7DBEEA), elevation: 10)),
            color: Color.fromARGB(165, 86, 154, 185),
          ),
          Text("\nPour mieux connaître notre mouvement\n",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5),
          //
          // bouton d'affichage de la liste "Un mystère chaque jour"
          //
          SizedBox(height: Display(context).h() * 1),
          Container(
            padding: const EdgeInsets.all(10),
            width: Display(context).w() * 80,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AfficheSite("https://equipes-rosaire.org/pq"),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(Display(context).w() * 1.5),
                  child: Text('Une prière chaque jour',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Display(context).h() * 2.5)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x94cadae9), elevation: 10)),
            color: Color.fromARGB(128, 89, 128, 162),
          ),
          //
          // bouton d'affichage de la liste "Rejoindre une équipe"
          //
          SizedBox(height: Display(context).h() * 3),

          Container(
            padding: const EdgeInsets.all(10),
            width: Display(context).w() * 80,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AfficheSite("https://equipes-rosaire.org/nr"),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Rejoindre une équipe',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Display(context).h() * 2.5)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFadd2f1),
                  elevation: 10,
                )),
            color: Color.fromARGB(165, 86, 154, 185),
          ),

          //
          // bouton d'affichage de la liste "Ils méditent"
          //
          SizedBox(height: Display(context).h() * 3),

          Container(
            padding: const EdgeInsets.all(10),
            width: Display(context).w() * 80,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IlsMeditent(),
                      ));
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Ils méditent',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Display(context).h() * 2.5)),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xAA9cbbd3), elevation: 10)),
            color: Color.fromARGB(128, 89, 128, 162),
          )
        ]));
  }
}
