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
import '_theme.dart';

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
    getUserPhp(widget.login);
    localNotificationService = LocalNotificationService();
    localNotificationService.init();
    super.initState();
  }

  // on récupère les données de l'utilisateur depuis la shared préference Login
  Future<void> getUserPhp(String loginId) async {
    //print("medit.dart : uri = https://app.equipes-rosaire.org/user2.php?Login=$loginId");
    var uri =
        Uri.parse("https://app.equipes-rosaire.org/user2.php?Login=$loginId");
    var response = await http.post(uri);
    var jsonMedit = jsonDecode(response.body);
    //print('getUserPhp() ££££££££££££££ Response body: ${response.body}');
    setState(() {
      login = jsonMedit['Login'];
      prenom = jsonMedit['Prenom'];
      email = jsonMedit['Email'];
      ville = jsonMedit['Ville'];
      usernum = jsonMedit['Usernum'];
      nummedit = int.parse(jsonMedit['Nummedit']) - 1;
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
        meditationNumber: nummedit,
      );
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
            toolbarHeight: 60,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: Container(
                height: 40,
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
                        style: Theme.of(context).textTheme.headline2?.merge(
                            TextStyle(color: colorTitle[meditationdujour.code[0]])),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold))
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
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 4.0),
                            child: Container(
                                width: double.infinity,
                                child: Text(meditationdujour.titre,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.merge(
                                            const TextStyle(color: Colors.white)))),
                          ),
                          Container(
                              width: double.infinity,
                              child: Text("${meditationdujour.titreEvangile}\n",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      ?.merge(
                                          const TextStyle(color: Colors.white)))),
                        ]),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        child: Text(meditationdujour.texteEvangile,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      const SizedBox(height: 20.0),
                      Divider(
                        height: 20,
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            // coloredIcon1[meditationdujour.code[0]]
                            'assets/ico1.png',
                            height: 30,
                            width: 30,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Méditation",
                                  style: Theme.of(context).textTheme.headline4)
                              //  style: TextStyle(
                              //    fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                          child: Text(meditationdujour.texteMeditation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3)), //style: TextStyle(fontSize: 18)),

                      const SizedBox(height: 20.0),
                      Divider(
                        height: 20,
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/ico2.png',
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
                      const SizedBox(height: 20.0),
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
                                      'assets/ico5.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  Text("Fruit du mystère",
                                      style: Theme.of(context).textTheme.headline4),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: Text(meditationdujour.texteFruit,
                                      style: Theme.of(context).textTheme.headline3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                                  child: Image.asset(
                                    'assets/ico4.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                Text("Les clausules",
                                    style: Theme.of(context).textTheme.headline4),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                                padding: const EdgeInsets.all(0.8),
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
                      const SizedBox(height: 20.0),
                      const SizedBox(height: 20.0),
                      if (meditationdujour.imgUrl != "")
                        Image(image: NetworkImage(meditationdujour.imgUrl)),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                              child: Image.asset(
                                'assets/ico6.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
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
                      const SizedBox(height: 20.0),
                      /**/
                      Container(
                          //Audio
                          child: Row(
                        children: [
                          isPlaying == false
                              ? IconButton(
                                  icon: const Icon(Icons.play_arrow),
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
                        ],
                      )),
                      const SizedBox(height: 20.0),
                      Divider(
                        height: 20,
                        thickness: 1,
                        color: colorTitle[meditationdujour.code[0]],
                      ),
                      /**/
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                            child: Image.asset(
                              'assets/ico7.png',
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
                          height: 200),
                    ],
                  ),
                ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 10,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AfficheSite("https://equipes-rosaire.org"),
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
                    child: Text('Ils\nméditent', textAlign: TextAlign.center),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorTitle[meditationdujour.code[0]],
                      elevation: 10,
                      minimumSize: const Size(60, 30))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3 - 10,

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
                    child:
                        Text('Laisser\nun message', textAlign: TextAlign.center),
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
