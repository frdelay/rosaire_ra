import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AfficheSite extends StatefulWidget {
  final String url;
  const AfficheSite(this.url);

  @override
  State<AfficheSite> createState() => _AfficheSiteState();
}

class _AfficheSiteState extends State<AfficheSite> {
  bool isLoading = true;
  late WebViewController controller;
  String urlSite = "";

  void initState() {
    urlSite = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
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
                  //initialUrl: urlSite,
                  initialUrl: urlSite,

                  javascriptMode: JavascriptMode.unrestricted,
                  onPageStarted: (String url) {
                    print(" WebView onPageStarted : $urlSite");
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    print(" WebView onPageFinished $urlSite");
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
