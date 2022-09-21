import 'package:flutter/material.dart';
import 'package:rosaire/site_affiche.dart';
import 'ilsmeditent_affiche.dart';
import 'inscription_formulaire.dart';

class Accueil extends StatelessWidget {
String urlSite = "";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      body: Column(
        children: [
          const Text("\nMÉDITER UN MYSTÈRE\nchaque jour avec\nUNE EQUIPE DU ROSAIRE\n"),
          SizedBox(
            height: 400,
            child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                crossAxisCount: 2,
                children: [
                  //
                  // bouton d'affichage de la page Prière Quotidienne du site
                  //
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AfficheSite("https://equipes-rosaire.org/pq"),
                          //builder: (context) => AfficheSite_pq(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                    child: Text('Une prière quotidienne', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(220, 37, 183, 135),
                      elevation: 10,
                      minimumSize: const Size(60, 30))),
                    color: Colors.teal[100],
                  ),
                  //
                  // bouton d'affichage de la page "Je veux prier un mystère"
                  //
                 Container(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLog(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                    child: Text('Je veux prier un mystère chaque jour', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(220, 37, 183, 135),
                      elevation: 10,
                      minimumSize: const Size(60, 30))),
                    color: Colors.teal[200],
                  ),
                  //
                  // bouton d'affichage de la liste "Ils méditent"
                  //
                  Container( child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficheSite("https://equipes-rosaire.org/nous-rejoindre"),
                              //builder: (context) => AfficheSite_pq(),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                        child: Text('Rejoinde une équipe', textAlign: TextAlign.center),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(220, 37, 183, 135),
                          elevation: 10,
                          minimumSize: const Size(60, 30))),
                    color: Colors.teal[100],
                  ),

                  //
                  // bouton d'affichage de la liste "Ils méditent"
                  //                  
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IlsMeditent(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                    child: Text('Ils\nméditent', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(220, 37, 183, 135),
                      elevation: 10,
                      minimumSize: const Size(60, 30))),
                    color: Colors.teal[400],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
