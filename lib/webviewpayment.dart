import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mydiary/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WebPaymentGateway extends StatefulWidget {
  final String mail;

  const WebPaymentGateway({Key key, this.mail}) : super(key: key);
  @override
  _WebPaymentGatewayState createState() => new _WebPaymentGatewayState();
}

class _WebPaymentGatewayState extends State<WebPaymentGateway> {

  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height*0.06,),
              Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Icon(Icons.arrow_back,color: Colors.black,),
                    onPressed: () {
                      if (webView != null) {
                        webView.goBack();
                      }
                    },
                  ),
                  RaisedButton(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Icon(Icons.arrow_forward,color: Colors.black,),
                    onPressed: () {
                      if (webView != null) {
                        webView.goForward();
                      }
                    },
                  ),
                  Spacer(),
                  RaisedButton(
                    color: Colors.transparent,
                    elevation: 0.0,
                    child: Icon(Icons.refresh,color: Colors.black,),
                    onPressed: () {
                      if (webView != null) {
                        webView.reload();
                      }
                    },
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  child: InAppWebView(
                    initialUrl: "https://flutterwave.com/pay/flamesdigitalconcepts36g",
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: true,
                        )
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller, String url) async {
                      setState(() {
                        this.url = url;
                      });
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.06,
              ),
              Padding(
                padding: EdgeInsets.only(left:20, right:20,bottom: 40),
                child: RaisedButton(
                  onPressed: () async{
                    final db = Firestore.instance;
                    await db.collection("Users").add({
                      'email': widget.mail,
                      'status': 'FALSE',
                    }).then((documentReference) async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('payment_id',documentReference.documentID);
                      var t=prefs.setBool('premium_user',false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(trans: true,)),
                      );
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightBlueAccent,
                            Colors.blueAccent,
                            Colors.deepPurpleAccent
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: Text(
                          'COMPLETE',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight
                              .w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ])
        ),
    );
  }
}