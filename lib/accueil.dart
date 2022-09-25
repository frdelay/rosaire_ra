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

    // Paramètres de présentation
    double mQh03 = MediaQuery.of(context).size.height / 100 * 3;
    double mQh05 = MediaQuery.of(context).size.height / 100 * 5;
    double mQh10 = MediaQuery.of(context).size.height / 100 * 10;
    double mQh12 = MediaQuery.of(context).size.height / 100 * 12;
    double mQh60 = MediaQuery.of(context).size.height / 100 * 60;
    double mQh75 = MediaQuery.of(context).size.height / 100 * 75;

    double mQw02 = MediaQuery.of(context).size.width / 100 * 2;
    double mQw05 = MediaQuery.of(context).size.width / 100 * 5;
    double mQw10 = MediaQuery.of(context).size.width / 100 * 10;
    double mQw20 = MediaQuery.of(context).size.width / 100 * 20;
    double mQw60 = MediaQuery.of(context).size.width / 100 * 60;


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mQh10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Container(
            //height: 80,
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
            height: mQh12,
            child: Text(
              "\nMÉDITER UN MYSTÈRE\nchaque jour avec\nUNE EQUIPE DU ROSAIRE\n",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: mQh75,
            child: GridView.count(
                primary: false,
                padding: EdgeInsets.all(mQw02),
                crossAxisSpacing: mQw02,
                mainAxisSpacing: mQw02,
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
                                builder: (context) => AfficheSite(
                                    "https://equipes-rosaire.org/pq"),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Une prière chaque jour',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffac7a10),
                            elevation: 10,
                            minimumSize: const Size(30, 30))),
                    color: Color(0x80ac7a10),
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
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Je veux prier un mystère chaque jour',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1957CC),
                            elevation: 10,
                            minimumSize: const Size(30, 30))),
                    color: Color(0x801957CC),
                  ),
                  //
                  // bouton d'affichage de la liste "Rejoindre une équipe"
                  //
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AfficheSite(
                                    "https://equipes-rosaire.org/nr"),
                              ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Rejoindre une équipe',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff96143f),
                            elevation: 10,
                            minimumSize: const Size(30, 30))),
                    color: Color(0xaa96143f),
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
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Ils\nméditent',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height /
                                      100 *
                                      2.5)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2E986E),
                            elevation: 10,
                            minimumSize: Size(30, 30))),
                    color: Color(0x902E986E),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
