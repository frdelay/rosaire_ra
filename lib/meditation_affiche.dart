import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'site_affiche.dart';
import 'msg_formulaire.dart';
import 'ilsmeditent_affiche.dart';
import 'meditation_requete.dart';
import '_param.dart';

import 'notification_service.dart';

class AffMedit extends StatefulWidget {
  final String login;

  const AffMedit(this.login);

  @override
  State<AffMedit> createState() => _AffMeditState();
}

class _AffMeditState extends State<AffMedit> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        getUserPhp(widget.login);
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //variables globales
  final playeraudio = AudioPlayer();

  String login = "";
  String prenom = "";
  String email = "";
  String usernum = "";
  String ville = "";
  int nummedit = 0;
  bool isLoading = true;
  bool isPlaying = false;
  DateTime heure = DateTime.now();
  String nomJour = "";
  String noJour = "";
  int moisJour =0;
  String anneeJour = "";

  Meditation meditationdujour = Meditation();
  Meditation meditNotif = Meditation();
  late final LocalNotificationService localNotificationService;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // actualisationJournaliere();
    getUserPhp(widget.login);
    localNotificationService = LocalNotificationService();
    localNotificationService.init();
    super.initState();
  }

  // on récupère les données de l'utilisateur depuis la shared préference Login
  Future<void> getUserPhp(String loginId) async {
    var uri =
        Uri.parse("https://app.equipes-rosaire.org/user2.php?Login=$loginId");
    var response = await http.post(uri);
    var jsonMedit = jsonDecode(response.body);
    setState(() {
      login = jsonMedit['Login'];
      prenom = jsonMedit['Prenom'];
      email = jsonMedit['Email'];
      ville = jsonMedit['Ville'];
      usernum = jsonMedit['Usernum'];
      nummedit = int.parse(jsonMedit['Nummedit']) - 1;
      heure = DateTime.now();

      nomJour = DateFormat.EEEE().format(heure);
      noJour = DateFormat.d().format(heure);
      moisJour = int.parse(DateFormat.M().format(heure)) - 1;
      anneeJour = DateFormat.y().format(heure);
    });
    await getMeditations();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getMeditations() async {
    var meditations = await Meditation.getMeditPhp();

    setState(() {
      meditationdujour = meditations[nummedit];

      localNotificationService.generate30Notifications(
          meditationNumber: nummedit, prenom: prenom);
    });

    print("playeraudio : ${meditationdujour.audioUrl}");
    await playeraudio.setUrl(meditationdujour.audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: Display(context).h() * 10,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: Padding(
                padding: const EdgeInsets.all(120.0),
                child: Container(
                  child: Image.asset(
                    'assets/EDR-logo-long.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                    children: [
                      Text(
                        "Bonjour $prenom !",
                        style: Theme.of(context).textTheme.headline4?.merge(
                            TextStyle(
                                color: colorTitle[meditationdujour.code[0]])),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                "Aujourd'hui, ${jourFR[nomJour]} $noJour ${moisFR[moisJour]} $anneeJour, \nvous méditez un ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.merge(TextStyle(
                                  color: colorTitle[meditationdujour.code[0]],
                                )),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "mystère ${famille[meditationdujour.code[0]]}\n",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colorTitle[meditationdujour.code[0]],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.90))),
                        child: Column(children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 4.0),
                            child: Container(
                                width: double.infinity,
                                child: Text(meditationdujour.titre,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.merge(const TextStyle(
                                            color: Colors.white)))),
                          ),
                          Container(
                              width: double.infinity,
                              child: Text("${meditationdujour.titreEvangile}\n",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.merge(const TextStyle(
                                          color: Colors.white)))),
                        ]),
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      Container(
                        child: Text(meditationdujour.texteEvangile,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      Divider(
                        height: 20,
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            coloredIcon1[meditationdujour.code[0]]!,
                            height: 30,
                            width: 30,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Méditation",
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                        ],
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      Container(
                          child: Text(meditationdujour.texteMeditation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3)), //style: TextStyle(fontSize: 18)),

                      SizedBox(height: Display(context).h() * 3),
                      Divider(
                        height: 20,
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            coloredIcon2[meditationdujour.code[0]]!,
                            height: Display(context).h() * 4,
                            width: Display(context).h() * 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Intentions",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      Container(
                        child: Text(
                          meditationdujour.texteIntentions,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(height: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          height: 20,
                          thickness: 1,
                          color: colorTitle[meditationdujour.code[0]],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 240, 167),
                              borderRadius: BorderRadius.circular(17)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 5.0, 0.0),
                                    child: Image.asset(
                                      coloredIcon5[meditationdujour.code[0]]!,
                                      height: Display(context).h() * 4,
                                      width: Display(context).h() * 4,
                                    ),
                                  ),
                                  Text("Fruit du mystère",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                              SizedBox(height: Display(context).h() * 3),
                              Container(
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(Display(context).h() * 2),
                                  child: Text(meditationdujour.texteFruit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      //
                      // Titre de la clausule
                      //
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(
                            color: colorTitle[meditationdujour.code[0]]!,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 5.0, 0.0),
                                  child: Image.asset(
                                    coloredIcon4[meditationdujour.code[0]]!,
                                    height: Display(context).h() * 5,
                                  ),
                                ),
                                Text("Les clausules",
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              ],
                            ),

                            //
                            // Texte de la clausule
                            //
                            Padding(
                                padding:
                                    EdgeInsets.all(Display(context).h() * 5),
                                child: Container(
                                    child: Text(meditationdujour.texteClausules,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.merge(const TextStyle(
                                                color: Color.fromRGBO(
                                                    43, 62, 143, 1)))))),
                          ],
                        ),
                      ),

                      SizedBox(height: Display(context).h() * 3),

                      //
                      // Affichage de l'image
                      //

                      if (meditationdujour.imgUrl != "")
                        Container(
                          color: Colors.amber,
                          //padding : EdgeInsets.all(Display(context).w()*20),
                          child: Image(
                            image: NetworkImage(meditationdujour.imgUrl),
                            fit: BoxFit.fill,
                          ),
                        ),

                      SizedBox(height: Display(context).h() * 3),

                      //
                      // Bloc audio
                      //

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //
                          // Icone audio
                          //
                          Image.asset(
                            coloredIcon6[meditationdujour.code[0]]!,
                            height: Display(context).h() * 4,
                          ),

                          //
                          // Texte audio
                          //
                          Text(
                            " Audio",
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      SizedBox(height: Display(context).h() * 3),
                      //
                      // Player audio
                      //
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: colorTitle[meditationdujour.code[0]]!,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              isPlaying == false
                                  ? IconButton(
                                      icon: Icon(Icons.play_arrow,
                                          color: colorTitle[
                                              meditationdujour.code[0]]!),
                                      tooltip: 'lancer l audio',
                                      onPressed: () {
                                        print(meditationdujour.audioUrl);
                                        playeraudio.play();
                                        setState(() {
                                          isPlaying = true;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.pause),
                                      tooltip: 'pause',
                                      onPressed: () {
                                        print("pause");
                                        playeraudio.pause();
                                        setState(() {
                                          isPlaying = false;
                                        });
                                      },
                                    ),
                              IconButton(
                                icon: Icon(Icons.stop,
                                    color:
                                        colorTitle[meditationdujour.code[0]]!),
                                tooltip: 'stop',
                                onPressed: () {
                                  print("stop");
                                  playeraudio.stop();
                                  playeraudio.seek(Duration(seconds: 0));
                                  setState(() {
                                    isPlaying = false;
                                  });
                                },
                              ),
                              Text(meditationdujour.audioTitre)
                            ],
                          )),
                      SizedBox(height: Display(context).h() * 3),
                      Divider(
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      //
                      // Bloc video
                      //
                      SizedBox(height: Display(context).h() * 3),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            coloredIcon7[meditationdujour.code[0]]!,
                            height: Display(context).h() * 4,
                          ),
                          Text(
                            " Video",
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: Display(context).h() * 3),
                      Container(
                        child: WebView(
                          initialUrl: meditationdujour.videoUrl,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                        height: Display(context).h() * 35,
                      ),

                      SizedBox(
                        height: Display(context).h() * 15,
                        child:Text("$heure")
                        )
                        
                    ],
                  ),
                ),

          //
          // Pied de page
          //

          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // Bouton  "vers le site"
                //
                SizedBox(
                  width: Display(context).w() * 25,
                  height: Display(context).h() * 5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficheSite(
                                  "https://equipes-rosaire.org/accueil-appli"),
                            ));
                      },
                      child: Text(
                        'Vers\nle site',
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10)),
                ),
                //
                // Bouton  "ils méditent"
                //
                SizedBox(
                  width: Display(context).w() * 30,
                  height: Display(context).h() * 5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IlsMeditent(),
                            ));
                      },
                      child: Text('Ils et elles méditent', textAlign: TextAlign.center),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10)),
                ),
                //
                // Bouton  "laisser un message"
                //
                SizedBox(
                  width: Display(context).w() * 35,
                  height: Display(context).h() * 5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnvMsg(widget.login, prenom, email),
                            ));
                      },
                      child: Text('Laisser\nun message',
                          textAlign: TextAlign.center),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
