import 'dart:convert';

import 'package:flutter/material.dart';
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

class _AffMeditState extends State<AffMedit> {
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

  Meditation meditationdujour = Meditation();
  Meditation meditNotif = Meditation();

  late final LocalNotificationService localNotificationService;

  @override
  void initState() {
    actualisationJournaliere();
    getUserPhp(widget.login, 0);
    localNotificationService = LocalNotificationService();
    localNotificationService.init();
    super.initState();
  }

  actualisationJournaliere() async {
    while (true) {
      DateTime time1 = DateTime(now.year, now.month, now.day);

      await Future<dynamic>.delayed(const Duration(minutes: 60));
      DateTime time2 = DateTime(now.year, now.month, now.day);

      if (time1.day != time2.day) {
        int difJours = time2.difference(time1).inDays;
        getUserPhp(widget.login, difJours);
      }
    }
  }

  // on récupère les données de l'utilisateur depuis la shared préference Login
  Future<void> getUserPhp(String loginId, int difDate) async {
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
      nummedit = int.parse(jsonMedit['Nummedit']) - 1 + difDate;
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
    // Paramètres de présentation
    double mQh05 = MediaQuery.of(context).size.height / 100 * 5;
        double mQh03 = MediaQuery.of(context).size.height / 100 * 3;
    double mQh10 = MediaQuery.of(context).size.height / 100 * 10;
    double mQh15 = MediaQuery.of(context).size.height / 100 * 15;
    double mQh30 = MediaQuery.of(context).size.height / 100 * 30;

    double mQh60 = MediaQuery.of(context).size.height / 100 * 60;

    double mQw02 = MediaQuery.of(context).size.width / 100 * 2;
    double mQw05 = MediaQuery.of(context).size.width / 100 * 5;
    double mQw10 = MediaQuery.of(context).size.width / 100 * 10;
    double mQw20 = MediaQuery.of(context).size.width / 100 * 20;
    double mQw60 = MediaQuery.of(context).size.width / 100 * 60;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
                      toolbarHeight: MediaQuery.of(context).size.height / 100 * 10,
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
                                "Aujourd'hui, ${jourFR[dayOfWeek]} $day ${moisFR[mois]}  $year, \nvous méditez un ",
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
                       SizedBox(height: mQh03),
                      Container(
                        child: Text(meditationdujour.texteEvangile,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                       SizedBox(height: mQh03),
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
                                  style: Theme.of(context).textTheme.headline4)
                              ),
                        ],
                      ),
                       SizedBox(height: mQh03),
                      Container(
                          child: Text(meditationdujour.texteMeditation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3)), //style: TextStyle(fontSize: 18)),

                       SizedBox(height: mQh03),
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
                            height: 30,
                            width: 30,
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
                       SizedBox(height: mQh03),
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
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  Text("Fruit du mystère",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 10.0),
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
                       SizedBox(height: mQh03),
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
                                    height: mQh05,
                                    width: 30,
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
                                padding:  EdgeInsets.all(mQh05),
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
                      SizedBox(height:mQh03),
                      if (meditationdujour.imgUrl != "")
                        Image(image: NetworkImage(meditationdujour.imgUrl)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: Image.asset(
                                coloredIcon6[meditationdujour.code[0]]!,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            //
                            // Texte audio
                            //
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0, 5.0, 0.0),
                                child: Text(
                                  "Audio",
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                      icon: const Icon(Icons.play_arrow,
                                          color: Colors.red),
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
                                icon: const Icon(Icons.stop),
                                tooltip: 'stop',
                                onPressed: () {
                                  print("stop");
                                  playeraudio.dispose();
                                  //playeraudio.stop();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                },
                              ),
                              Text(meditationdujour.audioTitre)
                            ],
                          )),
                       SizedBox(height: mQh03),
                      Divider(
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                            child: Image.asset(
                              coloredIcon7[meditationdujour.code[0]]!,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Container(
                            //Video
                            child: Text(
                              "Video",
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        //child: Text(videoUrl, style: TextStyle(fontSize: 14)),
                        child: WebView(
                          initialUrl: meditationdujour.videoUrl,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                        height: mQh30,
                      ),

                      SizedBox(height: mQh15),
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
                  width: MediaQuery.of(context).size.width / 3 - 10,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AfficheSite(
                                  "https://equipes-rosaire.org/accueil-appli"),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                        child: Text(
                          'Vers\nle site',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10,
                          minimumSize: const Size(45, 30))),
                ),
                //
                // Bouton  "ils méditent"
                //
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 10,
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
                        child:
                            Text('Ils\nméditent', textAlign: TextAlign.center),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10,
                          minimumSize: const Size(60, 30))),
                ),
                //
                // Bouton  "laisser un message"
                //
                SizedBox(
                  width: mQh15,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EnvMsg(widget.login, prenom, email),
                            ));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 6.0, 0.0, 6.0),
                        child: Text('Laisser\nun message',
                            textAlign: TextAlign.center),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorTitle[meditationdujour.code[0]],
                          elevation: 10,
                          minimumSize: const Size(50, 30))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
