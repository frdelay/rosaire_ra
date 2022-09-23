import 'package:flutter/material.dart';
import 'package:rosaire/site_affiche.dart';
import 'ilsmeditent_affiche.dart';
import 'inscription_formulaire.dart';
import '_theme.dart';

class Accueil extends StatelessWidget {
String urlSite = "";
  // This widget is the root of your application.
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
          SizedBox(
            height: 200,

            child :Text(
                        "\nMÉDITER UN MYSTÈRE\nchaque jour avec\nUNE EQUIPE DU ROSAIRE\n",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
              ),
          SizedBox(
            //height: 1000,
            height :MediaQuery.of(context).size.height/100*70,
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
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AfficheSite("https://equipes-rosaire.org/pq"),
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: 
                    Text(
                      'Une prière \nquotidienne', 
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontSize: MediaQuery.of(context).size.height/100*5
                        )),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xaaac7a10),
                      elevation: 10,
                      minimumSize: const Size(60, 30))),
                    color: Color(0xffac7a10),
                  ),
                  //
                  // bouton d'affichage de la page "Je veux prier un mystère"
                  //
                 Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLog(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Je veux prier un mystère chaque jour', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xaa1957CC),
                      elevation: 10,
                      minimumSize: const Size(30, 30))),
                    color: Color(0xff1957CC),
                  ),
                  //
                  // bouton d'affichage de la liste "Rejoindre une équipe"
                  //
                  Container( child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficheSite("https://equipes-rosaire.org/nr"),
                            ));
                      },
                      child:  Padding(
                        padding: EdgeInsets.all(20),
                        child: 
                                          Text(
                      'Rejoindre une équipe', 
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontSize: MediaQuery.of(context).size.height/100*5
                        )),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary:  Color(0x2096143f),
                          elevation: 10,
                          minimumSize: const Size(30, 30))),
                    color: Color(0xff96143f),
                  ),

                  //
                  // bouton d'affichage de la liste "Ils méditent"
                  //                  
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IlsMeditent(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Ils\nméditent', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff2E986E),
                      elevation: 10,
                      minimumSize: const Size(30, 30))),
                    color: Color(0xaa2E986E),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
