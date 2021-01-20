import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/Animation/FadeAnimation.dart';
import 'package:mydiary/homescreen.dart';
import 'package:mydiary/webviewpayment.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Premium extends StatefulWidget {
  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  var ins="""
• Enter same email address every time in the process
• Your email address is the unique id of your payment. DON'T SHARE IT
• You can restore your premium services by clicking RESTORE in top right
• You have to enter same email address while RESTORE
• For further you can contact our services
""";
  List bannerAdSlider = [
    'https://image.freepik.com/free-vector/modern-sale-banner-with-product-description_1361-1259.jpg',
    'https://image.freepik.com/free-vector/poster-promotion-cosmetic-anti-aging-premium-product_1441-176.jpg',
    'https://image.freepik.com/free-vector/black-toothpaste-ads-banner-with-brush-tooth_107791-3321.jpg',
    'https://image.freepik.com/free-vector/colorstay-make-up-elegant-packaging-background-drop-foundation_1441-286.jpg',
    'https://image.freepik.com/free-psd/electronic-shop-template-banner_23-2148785671.jpg',
    'https://image.freepik.com/free-vector/modern-black-friday-sale-banner-template-with-3d-background-red-splash_1361-1877.jpg',
    'https://image.freepik.com/free-vector/sun-protection-cosmetic-vector-realistic_88138-84.jpg', 'https://image.freepik.com/free-vector/poster-promotion-cosmetic-anti-aging-premium-product_1441-176.jpg',
  ];
  TextEditingController t1 = TextEditingController();
  _showDialog([res=false]) async {
    await showDialog<String>(
      context: context,
      builder: (context){
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller: t1,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: 'Enter Email', hintText: 'eg. example@mail.com'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('DONE'),
                onPressed: ()async{
                  if(t1.text.trim()!="" && !res){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WebPaymentGateway(mail: t1.text,)),
                    );
                  }else if(res){
                    final db = Firestore.instance;
                    final userRef = db.collection('Users');
                    userRef.getDocuments().then((snapshot) {
                      int counter=0;
                      snapshot.documents.forEach((doc) async {
                        if(doc.data['email']==t1.text && doc.data['status']=="TRUE"){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('premium_user',false);
                          prefs.setString('payment_id',doc.documentID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        }
                        counter+=1;
                      });
                    });
                  }
                })
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlue,
                Colors.blue,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              tileMode: TileMode.clamp),
        ),
        child: Column(children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.045,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
                Navigator.pop(context);
              },),
              Spacer(),
              GestureDetector(onTap: (){
                _showDialog(true);
                }, child: Text("RESTORE",style: TextStyle(color: Colors.white),))
            ],),
          ),
          FadeAnimation(0.5,Image.asset('assets/background/thank.png',height: MediaQuery.of(context).size.height*0.3,)),
          SizedBox(height: MediaQuery.of(context).size.height*0.045,),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Row(children: <Widget>[
              Text("INSTRUCTIONS",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.09,fontWeight: FontWeight.w800,),),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0,top: 20,right: 10),
            child: Row(children: <Widget>[
              Flexible(child: Text(ins, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: MediaQuery.of(context).size.width*0.03),)),
            ],),
          ),
          Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.06,
          ),
          Padding(
            padding: EdgeInsets.only(left:20, right:20,bottom: 40),
            child: RaisedButton(
              onPressed: () {
                _showDialog();
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
                      'PROCEED',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight
                      .w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
