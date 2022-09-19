import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    var uri = Uri.parse("http://app.equipes-rosaire.org/journaltri.php");
    var response = await http.post(uri);

    var jsonConnexions = jsonDecode(response.body);
    print(jsonConnexions);
    print(jsonConnexions.runtimeType);

    Map<String, dynamic>.from(jsonConnexions).forEach((String key, dynamic value) {

    usersConnected.add(<String,dynamic>{key:value});
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
                    color: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: Center(
                child: Container(
                  height: 80,
                  child: Image.asset(
                    'assets/EdR_splash.png',
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
                      style: Theme.of(context).textTheme.headline1),
                ),

                // ListView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: usersConnected.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Column(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               border: Border.all(
                //                 width: 3.0,
                //                 color: Color.fromARGB(
                //                     220, 37, 183, 135), // red as border color
                //               ),
                //               color: Color.fromRGBO(43, 62, 143, 1),
                //             ),
                //             child: Padding(
                //               padding:
                //                   const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                 Text(usersConnected[index]["Meditation"],
                //                     textAlign: TextAlign.center,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .subtitle1
                //                         ?.merge(TextStyle(color: Colors.white)))
                //               ]),
                //             ),
                //           ),
                //           Column(
                //             children: [
                //               Container(
                //                 child: Row(
                //                   children: [Expanded(
                //                     child: Container(
                //                       decoration: const BoxDecoration(
                //                         border: Border(
                //                           top: BorderSide(
                //                               color: Color.fromARGB(0, 250, 250, 250)),
                //                           left: BorderSide(
                //                               width: 3.0,
                //                               color: Color.fromARGB(220, 37, 183, 135)),
                //                           right: BorderSide(
                //                               color: Color.fromARGB(220, 37, 183, 135)),
                //                           bottom: BorderSide(
                //                               color: Color.fromARGB(0, 37, 183, 134)),
                //                         ),
                //                         color: Color.fromARGB(255, 255, 255, 255),
                //                       ),
                //                       child: Padding(
                //                         padding:
                //                             const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
                //                         child: Row(
                //                           children: [
                //                             Text(usersConnected[index]["Prenom"]),
                //                           ],
                //                         ),
                //                       ),
                //                     ),),
                //                     Container(
                //                       decoration: const BoxDecoration(
                //                         border: Border(
                //                           top: BorderSide(
                //                               color: Color.fromARGB(0, 37, 183, 134)),
                //                           left: BorderSide(
                //                               color: Color.fromARGB(0, 30, 198, 27)),
                //                           right: BorderSide(
                //                               color: Color.fromARGB(220, 37, 183, 135)),
                //                           bottom: BorderSide(
                //                               color: Color.fromARGB(0, 37, 183, 134)),
                //                         ),
                //                         color: Color.fromARGB(255, 255, 255, 255),
                //                       ),
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(6.0),
                //                         child: Row(
                //                           children: [
                //                             Text(usersConnected[index]["Ville"]),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                     Container(
                //                       decoration: const BoxDecoration(
                //                         border: Border(
                //                           top: BorderSide(
                //                               color: Color.fromARGB(0, 37, 183, 134)),
                //                           left: BorderSide(
                //                               color: Color.fromARGB(0, 30, 198, 27)),
                //                           right: BorderSide(
                //                               width: 3.0,
                //                               color: Color.fromARGB(220, 37, 183, 135)),
                //                           bottom: BorderSide(
                //                               color: Color.fromARGB(0, 37, 183, 134)),
                //                         ),
                //                         color: Color.fromARGB(255, 255, 255, 255),
                //                       ),
                //                       child: Padding(
                //                         padding: const EdgeInsets.all(6.0),
                //                         child: Row(
                //                           children: [
                //                             Text(usersConnected[index]["DateConnexion"],
                //                                 style:
                //                                     Theme.of(context).textTheme.subtitle2)
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ],
                //       );
                //     }),


              //   ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: usersConnected.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Table(
              //         columnWidths: const <int, TableColumnWidth>{
              // 0: FixedColumnWidth(100),
              // 1: FixedColumnWidth(40),
              // 2: FixedColumnWidth(80)},
              //           //border: TableBorder.all(),
              //           children: <TableRow>[
              //             TableRow(
              //               children: [
              //                 TableCell(
              //                 child: Text(usersConnected[index]["Meditation"],
              //                     style: TextStyle(backgroundColor: Colors.red)),
              //               ),
              //               TableCell(child:Text('')),
              //               TableCell(child:Text(''))
              //               ]
              //             ),
              //             TableRow(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(usersConnected[index]["Prenom"]),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(usersConnected[index]["Ville"]),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(usersConnected[index]["DateConnexion"]),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         );
              //       }),

              //  ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: usersConnected.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Row(
              //           children: [
              //                 Text(usersConnected[index]["Meditation"],
              //                     style: TextStyle(backgroundColor: Colors.red)),
              //                     Text(usersConnected[index]["Prenom"]),
              //                     Text(usersConnected[index]["Ville"]),
              //                     Text(usersConnected[index]["DateConnexion"]),
              //
              //               ]);}
              // ),

                // '...' it's spread operator (https://www.geeksforgeeks.org/dart-spread-operator/)
                ...List<Widget>.generate(
                  usersConnected.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Text(
                              usersConnected.elementAt(index).keys.first,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
                              usersConnected.elementAt(index).values.first.length,
                              (index2) => Container(
                                // color: Colors.green,
                                child: Text(usersConnected
                                    .elementAt(index)
                                    .values
                                    .first[index2]
                                    .toString()),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

// Raphael
//            ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: usersConnected.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Row(
//                     children: [
//                           Text(usersConnected[index]["Meditation"],
//                               style: TextStyle(backgroundColor: Colors.red)),
//                               Text(usersConnected[index]["Prenom"]),
//                               Text(usersConnected[index]["Ville"]),
//                               Text(usersConnected[index]["DateConnexion"]),
//
//                         ]);}
//           )


              ]),
            )),


        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,
              colors: [
                Colors.black45.withOpacity(0.7),
                Colors.transparent,
              ]
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
          )
          ,),
      ],
    );
  }
}
