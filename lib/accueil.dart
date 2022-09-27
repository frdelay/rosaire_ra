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
        toolbarHeight: Display(context).h()*10,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(
            height: Display(context).h() * 80,
            child: GridView.count(
                primary: false,
                padding: EdgeInsets.all(Display(context).w() * 5),
                crossAxisSpacing: Display(context).w() * 2,
                mainAxisSpacing: Display(context).w() * 2,
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
                          padding: EdgeInsets.all(Display(context).w() * 2),
                          child: Text('Une prière chaque jour',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: Display(context).h() *2.5)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffac7a10),
                            elevation: 10)),
                    color: Color(0x80ac7a10),
                  ),
                  //
                  // bouton d'affichage de la page "Je veux prier un mystère"
                  //
                  Container(
                    padding:  EdgeInsets.all(Display(context).w()  * 2),
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
                              style: TextStyle(fontSize: Display(context).h() *  2.5)
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1957CC),
                            elevation: 10)
                            ),
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
                              style: TextStyle(fontSize: Display(context).h() * 2.5)
                       ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff96143f),
                            elevation: 10,
                            )),
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
                                  fontSize: Display(context).h() * 2.5)
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2E986E),
                            elevation: 10)),
                    color: Color(0x902E986E),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
