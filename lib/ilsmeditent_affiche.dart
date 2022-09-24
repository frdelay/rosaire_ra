import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '_param.dart';

class IlsMeditent extends StatefulWidget {
  const IlsMeditent({Key? key}) : super(key: key);

  @override
  State<IlsMeditent> createState() => _IlsMeditentState();
}

class _IlsMeditentState extends State<IlsMeditent> {
  List<Map> usersConnected = [];

  @override
  void initState() {
    super.initState();
    getConnectPhp();
  }

  getConnectPhp() async {
    var uri = Uri.parse("https://app.equipes-rosaire.org/journaltri2.php");
    var response = await http.post(uri);

    var jsonConnexions = jsonDecode(response.body);

    Map<String, dynamic>.from(jsonConnexions)
        .forEach((String key, dynamic value) {
      usersConnected.add(<String, dynamic>{key: value});
    });

    setState(() {
      usersConnected = usersConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              toolbarHeight: 40,
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
            body: SingleChildScrollView(
              child: Column(children: [

                     Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                      child: Text("ils méditent",
                          style: Theme.of(context).textTheme.headline4),
                    ),

            Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          color: colorTitle["J"],
                          child: 
                          Text('mystères joyeux', 
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                          )
                        ),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          color: colorTitle["L"],
                          child: 
                          Text('mystères lumineux', 
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                          )
                        ),
                      ),
                    ),


Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          color: colorTitle["G"],
                          child: 
                          Text('mystères glorieux', 
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                          )
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          color: colorTitle["D"],
                          child: 
                          Text('mystères douloureux', 
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                          )
                        ),
                      ),
                    ),
                  ],
                ),

                // '...' it's spread operator (https://www.geeksforgeeks.org/dart-spread-operator/)
                ...List<Widget>.generate(
                  usersConnected.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: colorTitle[
                              '${usersConnected.elementAt(index).keys.first[0]}'],
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              usersConnected
                                  .elementAt(index)
                                  .keys
                                  .first
                                  .toString()
                                  .substring(4),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List<Widget>.generate(
                              usersConnected
                                  .elementAt(index)
                                  .values
                                  .first
                                  .length,
                              (index2) => Text(
                                usersConnected
                                    .elementAt(index)
                                    .values
                                    .first[index2]
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black45.withOpacity(0.7),
                    Colors.transparent,
                  ]),
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
          ),
        ),
      ],
    );
  }
}
