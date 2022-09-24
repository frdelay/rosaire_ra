import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'accueil.dart';
import 'meditation_affiche.dart';
import '_theme.dart';

void main() async {
  ///
  /// Force the layout to Portrait mode
  ///
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Equipes Rosaire';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged = false;
  String login = "";

  @override
  void initState() {
    super.initState();
    redirection();
  }

  redirection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('ppLogin') == null) {
      setState(() {
        print("main.dart : SharedPref isLogged false");
        isLogged = false;
      });
    } else {
      login = (prefs.getString('ppLogin'))!;
      print("main.dart : SharedPref login = $login");
      setState(() {
        isLogged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      theme: MonTheme(context),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return isLogged == true ? AffMedit(login) : Accueil();
      }),
    );
  }
}
