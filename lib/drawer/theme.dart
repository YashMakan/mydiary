import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydiary/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends StatefulWidget {
  ThemePage() : super();

  final String title = "Carousel Demo";

  @override
  ThemePageState createState() => ThemePageState();
}

class ThemePageState extends State<ThemePage> {
  //
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/background/login@3x.png',
    'assets/background/login – 1@3x.png',
    'assets/background/login – 2@3x.png',
    'assets/background/login – 3@3x.png',
    'assets/background/login – 4@3x.png',
  ];
  List buttonColors = [
    Colors.deepOrange,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.amber,
  ];
  List premium=[0,3];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  setIndex(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('in', v);
    prefs.setString('first', 'done');
  }

  bool pu=false;
  getPU()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getBool('premium_user');
    setState(() {
      pu=v;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPU();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imgList[_current])
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.85,-0.85,),
            child: Text('Choose Your Diary Theme',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.055,fontWeight: FontWeight.w700),),
          ),
          Align(
            alignment: Alignment(0,-0.2),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height*0.62,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: false,
                reverse: false,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index,a){
                  setState(() {
                    _current = index;
                  });
                }
              ),
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        imgUrl,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment(0,0.7),
            child: Container(
              width: MediaQuery.of(context).size.width*0.315,
              child: FlatButton(
                color: buttonColors[_current],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  premium.contains(_current)?Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,):Container(width: 0,height: 0,),
                  premium.contains(_current)?SizedBox(width: 5,):Container(width: 0,height: 0,),
                  Text('USE IT',style: TextStyle(color: Colors.white))
                ],),
                onPressed: () {
                  if(pu==null){
                    if(premium.contains(_current)){
                      Fluttertoast.showToast(
                        msg: "Premium Feature",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                      );
                    }else{
                      setIndex(_current);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    }
                  }
                  else{
                    if(pu){
                      setIndex(_current);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    }else{
                      if(!premium.contains(_current)){
                        setIndex(_current);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      }else {
                        Fluttertoast.showToast(
                          msg: "Premium Feature",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }
                    }
                  }
                },
              ),
            ),
          )
        ],)
      ),
    );
  }
}