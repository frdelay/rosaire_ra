import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AfficheSite_pq extends StatefulWidget {
  @override
  State<AfficheSite_pq> createState() => _AfficheSite_pqState();
}

class _AfficheSite_pqState extends State<AfficheSite_pq> {
  bool isLoading = true;
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'assets/EDR-logo-long.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
        body: Center(
          child: Stack(
            children: [
              Center(
                child:
                    isLoading ? const CircularProgressIndicator() : Container(),
              ),
              Opacity(
                opacity: isLoading ? 0 : 1,
                child: WebView(
                  onWebViewCreated: (WebViewController webViewController) {},
                  initialUrl: "https://equipes-rosaire.org/pq",
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageStarted: (String url) {
                    print(" WebView onPageStarted");
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    print(" WebView onPageFinished $url");
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onProgress: (int index) {
                    print("WebView onProgress $index");
                            setState(() {
                      isLoading = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
