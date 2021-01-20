import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodStyle extends StatefulWidget {
  final int hoosen;
  final Color color;
  final bool settings;
  const MoodStyle({Key key, this.hoosen, this.color, this.settings}) : super(key: key);
  @override
  _MoodStyleState createState() => _MoodStyleState();
}

class _MoodStyleState extends State<MoodStyle> {
  bool _isChecked = true;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  int choosen=0;
  bool pu=false;

  List defaultEmojis1=[
    'assets/emojis/1/1neutral.png',
    'assets/emojis/1/2blush.png',
    'assets/emojis/1/3happy.png',
    'assets/emojis/1/4star.png',
    'assets/emojis/1/5wink.png',
    'assets/emojis/1/6sad.png',
    'assets/emojis/1/7angry.png',
    'assets/emojis/1/8cry.png',
    'assets/emojis/1/9cry.png',
  ];

  List defaultEmojis2=[
    'assets/emojis/2/1neutral.png',
    'assets/emojis/2/2blush.png',
    'assets/emojis/2/3happy.png',
    'assets/emojis/2/4star.png',
    'assets/emojis/2/5wink.png',
    'assets/emojis/2/6sad.png',
    'assets/emojis/2/7angry.png',
    'assets/emojis/2/8cry.png',
    'assets/emojis/2/9cry.png',
  ];

  List defaultEmojis3=[
    'assets/emojis/3/1neutral.png',
    'assets/emojis/3/2blush.png',
    'assets/emojis/3/3happy.png',
    'assets/emojis/3/4star.png',
    'assets/emojis/3/5wink.png',
    'assets/emojis/3/6sad.png',
    'assets/emojis/3/7angry.png',
    'assets/emojis/3/8cry.png',
    'assets/emojis/3/9cry.png',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPU();
    setState(() {
      widget.hoosen!=null?choosen=widget.hoosen:print('null');
    });
  }
  getPU()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getBool('premium_user');
    setState(() {
      pu=v;
    });
  }

  Future<bool> _onWillPop() async {
    if(widget.settings!=null){
      return widget.settings;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
              Navigator.pop(context,choosen);
            },),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            title: Text('Mood Style',style: TextStyle(color: Colors.black),),
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top:20.0,bottom: 20,left: 20),
                  child: Column(
                    children: <Widget>[
                    Row(children: <Widget>[
                      Text("Normal Mood",style: TextStyle(color: Colors.black38)),
                      Spacer(),
                      Checkbox(
                        activeColor: widget.color,
                        value: _isChecked,
                        onChanged: (val) {
                          setState(() {
                            _isChecked = true;
                            if(val){
                              choosen=0;
                              _isChecked1=false;
                              _isChecked2=false;
                            }
                          });
                        },
                      )
                    ],),
                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                    Row(children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height*0.15,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.count(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 9/6,
                          children: List.generate(9, (index) {
                            return Image.asset(defaultEmojis1[index]);
                          }),
                        ),
                      )
                    ],)
                  ])
              ),
              Divider(thickness: 1,),
              Padding(
                  padding: EdgeInsets.only(top:20.0,bottom: 20,left: 20),
                  child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("PRO Mood 01",style: TextStyle(color: Colors.black38)),
                          Spacer(),
                          Checkbox(
                            activeColor: widget.color,
                            value: _isChecked1,
                            onChanged: (val) {
                              if(pu!=null){
                                if(pu){
                                  setState(() {
                                    _isChecked1 = val;
                                    if(val){
                                      choosen=1;
                                      _isChecked=false;
                                      _isChecked2=false;
                                    }
                                  });
                                }else{
                                  Fluttertoast.showToast(
                                    msg: "Premium Feature",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                  );
                                }
                              }else{
                                Fluttertoast.showToast(
                                  msg: "Premium Feature",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                );
                              }
                            },
                          )
                        ],),
                        SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                        Row(children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GridView.count(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9/6,
                              children: List.generate(9, (index) {
                                return Image.asset(defaultEmojis2[index]);
                              }),
                            ),
                          )
                        ],)
                      ])
              ),
              Divider(thickness: 1,),
              Padding(
                  padding: EdgeInsets.only(top:20.0,bottom: 20,left: 20),
                  child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text("PRO Mood 02",style: TextStyle(color: Colors.black38)),
                          Spacer(),
                          Checkbox(
                            activeColor: widget.color,
                            value: _isChecked2,
                            onChanged: (val) {
                              if(pu!=null){
                                if(pu){
                                  setState(() {
                                    _isChecked2 = val;
                                    if(val){
                                      choosen=2;
                                      _isChecked=false;
                                      _isChecked1=false;
                                    }
                                  });
                                }else{
                                  Fluttertoast.showToast(
                                    msg: "Premium Feature",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                  );
                                }
                              }else{
                                Fluttertoast.showToast(
                                  msg: "Premium Feature",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                );
                              }
                            },
                          )
                        ],),
                        SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                        Row(children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GridView.count(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9/6,
                              children: List.generate(9, (index) {
                                return Image.asset(defaultEmojis3[index]);
                              }),
                            ),
                          )
                        ],)
                      ])
              ),
            ]),
          )
      ),
    );
  }
}