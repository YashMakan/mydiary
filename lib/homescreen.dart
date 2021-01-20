import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mydiary/AddButton/add.dart';
import 'package:mydiary/drawer/backup.dart';
import 'package:mydiary/drawer/theme.dart';
import 'package:mydiary/pro.dart';
import 'package:mydiary/search.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';
import 'package:mydiary/Person/person.dart';
import 'calendar/calc.dart';
import 'drawer/diarylock.dart';
import 'drawer/export.dart';
import 'drawer/settings/settings.dart';
import 'main.dart';
import 'package:mydiary/AddButton/listwidgetView.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.trans, this.spec}) : super(key: key);

  final String title;
  final bool trans;
  final String spec;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double quote_opacity = 1.0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  IconData arr = Ionicons.ios_arrow_down;
  List items=[];
  List<Widget> wids=[];
  String bg='';
  Color plusBtn=Color(0xff4886bd);
  List<Color> cont;
  List selected=[];
  int inte;
  List cols = [
    Color(0xffbe654d),
    Color(0xff4886bd),
    Color(0xffbd639d),
    Color(0xff68be80),
    Color(0xffbfb35b),
  ];
  List newCols = [
    Colors.redAccent,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.orangeAccent
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.trans==true){
      _showDialog();
    }
    if(widget.spec=="one"){
      achUnlock('assets/background/quill.png','Diary Apprentice');
    }
    if(widget.spec=="two"){
      achUnlock('assets/background/plant.png','Growing Strong');
    }
    if(widget.spec=="three"){
      achUnlock('assets/background/star.png','Diary Talent');
    }
    if(widget.spec=="four"){
      achUnlock('assets/background/star (1).png','Secret Keeper');
    }
    if(widget.spec=="five"){
      achUnlock('assets/background/security-guard.png','Data Guarder');
    }
    getPaymentStatus();
    getWeekDay();
    hideQuote();
    getItems();
    getIndex();
  }

  getPaymentStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('payment_id');
    if(id!=null){
      print('wieufhiuewfhiewhf');
      final db = Firestore.instance;
      await db.collection('Users').document(id).get().then((DocumentSnapshot documentSnapshot) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var t=prefs.getBool('premium_user');
        try{
          if(documentSnapshot.data['status']=="TRUE" && !t){
            prefs.setBool('premium_user',true);
            _showDialogPaymentSuccess();
            achUnlock('assets/background/superhero.png','MyDiary Hero');
          }
        }catch(_){
          //
        }
      });
    }
  }

  _showDialogPaymentSuccess() async {
    await showDialog<String>(
        context: context,
        builder: (context){
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text('Congratulations!!'),
            content: Text('You have successfully registered as a premium user'),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('WOW'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        }
    );
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: FadeAnimation(0.5,Image.asset('assets/background/cong.png',color: Colors.orangeAccent,)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
        content: FadeAnimation(0.7,Text("The transaction takes upto 48 hours for validation."))
      );
    });
  }

  Widget roundAchievementsMy(img,name,context,col){
    return Column(children: <Widget>[
      SizedBox(height: 2,),
      Container(
          foregroundDecoration: col == true?BoxDecoration():BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.saturation,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(img,width: 30,),
          )
      ),
      SizedBox(height: 3,),
      Text(name,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06,color: Colors.black,fontWeight: FontWeight.w700),),
      SizedBox(height: 10,)
    ],);
  }

  achUnlock(img,tit) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: roundAchievementsMy(img, tit,context,true),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
          content: FadeAnimation(0.7, Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text("Achievement Unlocked !!",style: TextStyle(fontSize: 12,color: Colors.black38),)],))
      );
    });
  }


  getWeekDay()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getInt('first_day');
    setState(() {
      inte=v;
      print(v);
      inte==2?inte=0:inte=1;
      print(inte);
    });
  }
  getIndex()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getInt('in');
    if(v==0){
      setState(() {
        bg='assets/background/login@3x.png';
        plusBtn=Color(0xffbe654d);
      });
    }
    else if(v==1){
      setState(() {
        bg='assets/background/login – 1@3x.png';
        plusBtn=Color(0xff4886bd);
      });
    }
    else if(v==2){
      setState(() {
        bg='assets/background/login – 2@3x.png';
        plusBtn=Color(0xffbd639d);
      });
    }
    else if(v==3){
      setState(() {
        bg='assets/background/login – 3@3x.png';
        plusBtn=Color(0xff68be80);
      });
    }
    else if(v==4){
      setState(() {
        bg='assets/background/login – 4@3x.png';
        plusBtn=Color(0xffbfb35b);
      });
    }
    else if(v==null){
      setState(() {
        setIndex(1);
        bg='assets/background/login – 1@3x.png';
      });
    }
  }

  setIndex(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('in', v);
  }

  getItems()async{
    items=[];
    List<String> data=await getList();
    if(data!=null){
      var newa=data.length;
      if(cont==null){
        cont=List.generate(newa, (index) {
          return Color(0xffdce8f4);
        });
      }
      for(int i = 0; i < data.length; i++){
        var snapshot=data[i].split('`');
        var allindex = snapshot[0];
        var bold = snapshot[1];
        var bodyColor = snapshot[2];
        var bodyFont = snapshot[3];
        var bodyFontSize = snapshot[4];
        var bodyAlign = snapshot[5];
        var selectedHeading = snapshot[6];
        var emojiMood = snapshot[7];
        var _date = snapshot[8];
        var _elemPos = snapshot[9];
        var files = snapshot[10];
        var _selected = snapshot[11];
        var _values = snapshot[12];
        var _title = snapshot[13];
        var _body = snapshot[14];
        items.add([
          allindex,
          bold,
          bodyColor,
          bodyFont,
          bodyFontSize,
          bodyAlign,
          selectedHeading,
          emojiMood,
          _date,
          _elemPos,
          files,
          _selected,
          _values,
          _title,
          _body,
        ]);
      }
    }
    List<Widget> temp=[];
    temp.add(SizedBox(height: MediaQuery.of(context).size.height*0.08,),);
    for(int i = 0; i < items.length; i++){
      temp.add(GestureDetector(
        onLongPress: ()async{
          if (selected == null){
            selected=[];
            setState(() {
              have=true;
              selected.add(i);
            });
            cont[i]=Colors.white38;
          }
          else if(!selected.contains(i)){
            setState(() {
              have=true;
              selected.add(i);
            });
            cont[i]=Colors.white38;
          }
          else{
            setState(() {
              selected.remove(i);
              if(selected.length==0){
                have=false;
              }else{
                have=true;
              }
            });
            cont[i]=Color(0xffdce8f4);
          }
          getItems();
        },
        onTap: (){
          if(!have){
            String date=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ','')+' '; // date
            String month=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ','')+' '; // month
            String year=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[2].replaceAll(' ','')+' '; // year

            String emojiMood = items[i][7].trim().replaceAll('\n','');  // emojiMood
            var _date = [date, month, year];
            String _title = items[i][9]; // title
            String _body = items[i][10]; //body

            var bodyColor = items[i][2];
            var hexColor = bodyColor.replaceAll("Color(", "").replaceAll(')','').replaceAll('\n','');
            bodyColor=Color(int.parse("$hexColor"));
            //body
            String bodyFont = items[i][3];
            double bodyFontSize = double.parse(items[i][4]);
            var a = items[i][5].replaceAll('\n','');

            var bodyAlign;
            var textAlign=[
              TextAlign.values,
              TextAlign.end,
              TextAlign.start,
              TextAlign.center,
              TextAlign.right,
              TextAlign.left,
              TextAlign.justify,
            ];
            if(a=="TextAlign.values"){
              bodyAlign=textAlign[0];
            }
            else if(a=="TextAlign.end"){
              bodyAlign=textAlign[1];
            }
            else if(a=="TextAlign.start"){
              bodyAlign=textAlign[2];
            }
            else if(a=="TextAlign.center"){
              bodyAlign=textAlign[3];
            }
            else if(a=="TextAlign.right"){
              bodyAlign=textAlign[4];
            }
            else if(a=="TextAlign.left"){
              bodyAlign=textAlign[5];
            }
            else if(a=="TextAlign.justify"){
              bodyAlign=textAlign[6];
            }

            String selectedHeading = items[i][6];
            var _elemPos = ToList(items[i][11]);
            print(_elemPos);
            print(items[i][12].replaceAll('[','["').replaceAll(',','","').replaceAll(']','"]'));
            List<String> files = List<String>.from(ToList(items[i][12].replaceAll('[','["').replaceAll(',','","').replaceAll(']','"]').replaceAll(' ','')));
            List<bool> _selected = List<bool>.from(ToList(items[i][13]));
            List<String> _values = List<String>.from(ToList(items[i][14].replaceAll('[','["').replaceAll(',','","').replaceAll(']','"]').replaceAll(' ','')));
            bool bold = ToBool(items[i][1]);
            int allindex = items[i][0].replaceAll('\n','').trim()=="null"?null:int.parse(items[i][0]);
            if(_values.contains(""))
              _values.remove("");

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstViewPage(
                tapindex:i,
                allindex:allindex,
                bold:bold,
                bodyColor:bodyColor,
                bodyFont:bodyFont,
                bodyFontSize:bodyFontSize,
                bodyAlign:bodyAlign,
                selectedHeading:selectedHeading,
                emojiMood: emojiMood,
                date: _date,
                title: _title,
                body: _body,
                elemPos: _elemPos,
                files: files,
                selected: _selected,
                values: _values,
              )),
            );
          }
          else{
            if(!selected.contains(i)){
              setState(() {
                have=true;
                selected.add(i);
              });
              cont[i]=Colors.white38;
            }
            else{
              setState(() {
                selected.remove(i);
                if(selected.length==0){
                  have=false;
                }else{
                  have=true;
                }
              });
              cont[i]=Color(0xffdce8f4);
            }
            getItems();
          }
        },
        child: ListWidget(
            cont[i],
            items[i][8].replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ',''), // date
            items[i][8].replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ',''), // month
            items[i][7].trim().replaceAll('\n',''),  // emojiMood
            items[i][9], // title
            items[i][10] // body
        ),
      ),);
    }
    setState(() {
      wids=temp;
    });
  }

  ToList(val){
    if(this != "null"){
      return json.decode(val);
    }else{
      return null;
    }
  }

  ToBool(val){
    if(val=="true"){
      return  true;
    }else{
      return false;
    }
  }
  Future getList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('items');
  }

  Future setList(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items',v);
  }

  hideQuote()async{
    Future.delayed(const Duration(seconds: 2,milliseconds: 500), () {
      setState(() {
        quote_opacity=0;
      });
    });
  }
  String now="oldest";
  void _select(String choice)async{
    if(choice=="Latest First" && now=="oldest"){
      List<String> data=await getList();
      for(var i=0;i<data.length/2;i++){
        var temp = data[i];
        data[i] = data[data.length-1-i];
        data[data.length-1-i] = temp;
      }
      now="latest";
      await setList(data);
      getItems();
    }
    else if(choice=="Oldest First" && now=="latest"){
      List<String> data=await getList();
      for(var i=0;i<data.length/2;i++){
        var temp = data[i];
        data[i] = data[data.length-1-i];
        data[data.length-1-i] = temp;
      }
      now="oldest";
      await setList(data);
      getItems();
    }
    else{
      //
    }
  }
  bool have = false;

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit the App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _drawerKey,
          backgroundColor: Colors.white,
          drawer: MainDrawer(plusBtn: plusBtn,items: items,),
          endDrawerEnableOpenDragGesture: false,
          body: bg.startsWith('as')?Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(bg)
                  ),
                ),
                child: items.isEmpty?Stack(
                  children: <Widget>[
                    Align(alignment: Alignment.topCenter,child: Column(children: <Widget>[SizedBox(height: MediaQuery.of(context).size.height*0.053,),Row(children: <Widget>[
                      !have?IconButton(icon: Icon(Icons.menu,color: Colors.black,),onPressed: (){
                        print("hi");
                        _drawerKey.currentState.openDrawer();
                      }):IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
                        setState(() {
                          have=false;
                          selected=[];
                          cont=List.generate(cont.length, (index) {
                            return Color(0xffdce8f4);
                          });
                          getItems();
                        });
                      },),
                      Spacer(),
                      !have?Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                          child: Row(children: <Widget>[
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Premium()),
                                  );
                                },
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Row(children: <Widget>[
                                  Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                  Text("PRO".toUpperCase(),
                                      style: TextStyle(fontSize: 13.2, color: Colors.amberAccent)),

                                ],)),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            GestureDetector(onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Search()),
                              );
                            }, child: Image.asset('assets/search.png')),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            PopupMenuButton<String>(
                              icon: Icon(Icons.swap_vert,color: Colors.black,),
                              elevation: 3.2,
                              onCanceled: () {
                                print('You have not chossed anything');
                              },
                              tooltip: 'Sort',
                              onSelected: _select,
                              itemBuilder: (BuildContext context) {
                                return PopUpButtons.choices.map((String choice){
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                          ]
                          )
                      ):IconButton(icon: Icon(Icons.delete_outline,color: Colors.redAccent,),onPressed: () async {
                        print(selected);
                        List news=[];
                        news=await getList();
                        int ind=0;
                        for(var val in selected){
                          news.removeAt(val-ind);
                          ind+=1;
                        }
                        await setList(news);
                        have=false;
                        selected=[];
                        cont=List.generate(cont.length, (index) {
                          return Color(0xffdce8f4);
                        });
                        getItems();
                      },),
                    ],),],)),
                    FadeAnimation(2, Align(alignment:Alignment.center,child: AnimatedOpacity(opacity:quote_opacity,duration: Duration(seconds: 2,milliseconds: 500), child: Text('"\nKeep a diary,\nand someday it\'ll\nkeep you.\n',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color: Colors.white))))),
                    FadeAnimation(6, Align(alignment: Alignment(0,0.4),child: Text('Tap to start your first entry',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),)),
                    FadeAnimation(5.8,Opacity(opacity:0.7,child: Align(alignment: Alignment(0,0.49),child: Icon(arr,color: Colors.white,size: 40,)))),
                    FadeAnimation(5.6,Opacity(opacity:0.4,child: Align(alignment: Alignment(0,0.57),child: Icon(arr,color: Colors.white,size: 40,)))),
                    FadeAnimation(5.4,Opacity(opacity:0.3,child: Align(alignment: Alignment(0,0.65),child: Icon(arr,color: Colors.white,size: 40,)))),
                  ],
                ):SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height*0.053,),
                    Row(children: <Widget>[
                      !have?IconButton(icon: Icon(Icons.menu,color: Colors.black,),onPressed: (){
                    print("hi");
                    _drawerKey.currentState.openDrawer();
                  }):IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
                    setState(() {
                      have=false;
                      selected=[];
                      cont=List.generate(cont.length, (index) {
                        return Color(0xffdce8f4);
                      });
                      getItems();
                    });
                      },),
                      Spacer(),
                      !have?Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                          child: Row(children: <Widget>[
                            RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Premium()),
                                  );
                                },
                                color: Colors.black,
                                textColor: Colors.white,
                                child: Row(children: <Widget>[
                                  Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                                  Text("PRO".toUpperCase(),
                                      style: TextStyle(fontSize: 13.2, color: Colors.amberAccent)),

                                ],)),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            GestureDetector(onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Search()),
                              );
                            }, child: Image.asset('assets/search.png')),
                            SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                            PopupMenuButton<String>(
                              icon: Icon(Icons.swap_vert,color: Colors.black,),
                              elevation: 3.2,
                              onCanceled: () {
                                print('You have not chossed anything');
                              },
                              tooltip: 'Sort',
                              onSelected: _select,
                              itemBuilder: (BuildContext context) {
                                return PopUpButtons.choices.map((String choice){
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                            ),
                          ]
                          )
                      ):IconButton(icon: Icon(Icons.delete_outline,color: Colors.redAccent,),onPressed: () async {
                        print(selected);
                        selected.sort((a, b) => a.compareTo(b));
                        List news=[];
                        news=await getList();
                        int ind=0;
                        for(var val in selected){
                          news.removeAt(val-ind);
                          ind+=1;
                        }
                        await setList(news);
                        have=false;
                        selected=[];
                        cont=List.generate(cont.length, (index) {
                          return Color(0xffdce8f4);
                        });
                        getItems();
                      },),
                    ],),
                    Column(children: wids,),
                    SizedBox(height: MediaQuery.of(context).size.height*0.16,),
                  ],),
                ),
              ):Container(),

//        body: Stack(
//          children: <Widget>[
//            bg.startsWith('as')?Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  fit: BoxFit.fill,
//                  image: AssetImage(bg)
//                ),
//              ),
//            ):Container(),
//            Align(alignment: Alignment.topCenter, child: SingleChildScrollView(child: Column(children: <Widget>[
//              SizedBox(height: MediaQuery.of(context).size.height*0.053,),
//              Column(children: wids,),
//              SizedBox(height: MediaQuery.of(context).size.height*0.16,),
//            ])),),
//            Align(alignment: Alignment.topCenter, child: Column(children: <Widget>[
//              SizedBox(height: MediaQuery.of(context).size.height*0.046,),
//              Row(children: <Widget>[
//                IconButton(icon: Icon(Icons.menu,color: Colors.black,),onPressed: (){
//                  print("hi");
//                  _drawerKey.currentState.openDrawer();
//                }),
//                Spacer(),
//                Padding(
//                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
//                  child: Row(children: <Widget>[
//                    RaisedButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(18.0),
//                        ),
//                        onPressed: () {},
//                        color: Colors.black,
//                        textColor: Colors.white,
//                        child: Row(children: <Widget>[
//                          Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,),
//                          SizedBox(width: MediaQuery.of(context).size.width*0.01,),
//                          Text("PRO".toUpperCase(),
//                              style: TextStyle(fontSize: 13.2, color: Colors.amberAccent)),
//                        ],)
//                    ),
//                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                    Image.asset('assets/search.png'),
//                    SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                    PopupMenuButton<String>(
//                      icon: Icon(Icons.swap_vert,color: Colors.black,),
//                      elevation: 3.2,
//                      onCanceled: () {
//                        print('You have not chossed anything');
//                      },
//                      tooltip: 'This is tooltip',
//                      onSelected: _select,
//                      itemBuilder: (BuildContext context) {
//                        return PopUpButtons.choices.map((String choice){
//                          return PopupMenuItem<String>(
//                            value: choice,
//                            child: Text(choice),
//                          );
//                        }).toList();
//                      },
//                    ),
//                  ],),
//                )
//              ],),
//            ],)),
//          ],
//        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Opacity(
                  opacity: 0.65,
                  child: FloatingActionButton(
                      heroTag: 'b1',
                      mini: true,
                      onPressed: ()async {
                        await getWeekDay();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalcMain(inte:inte,color: newCols[cols.indexOf(plusBtn)]
                            ,)),
                        );
                      },
                      backgroundColor: Colors.grey,
                      elevation: 2,
                      child: Center(child: Image.asset('assets/calendar (1).png',color: Colors.white,),)),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                AvatarGlow(
                  animate: true,
                  glowColor: newCols[cols.indexOf(plusBtn)],
                  endRadius: 50.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                    backgroundColor: newCols[cols.indexOf(plusBtn)],
                    heroTag: 'b2',
                    mini: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEdit(color: newCols[cols.indexOf(plusBtn)],)),
                      );
                    },
                    child: Center(child: Icon(AntDesign.plus,size: 30,),),),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                Opacity(
                  opacity: 0.65,
                  child: FloatingActionButton(
                      heroTag: 'b3',
                      onPressed: () {
                        List<String> temp=[];
                        for(int i = 0; i < items.length; i++){
                          temp.add(items[i][7].trim().replaceAll('\n',''));
                        }
                        int one=0;
                        int two=0;
                        int three=0;
                        int four=0;
                        int five=0;
                        int six=0;
                        int seven=0;
                        int eight=0;
                        int nine=0;
                        for(int i = 0; i < temp.length; i++){
                          if(temp[i].endsWith("1neutral.png")){
                            one+=1;
                          }else if(temp[i].endsWith("2blush.png")){
                            two+=1;
                          }else if(temp[i].endsWith("3happy.png")){
                            three+=1;
                          }else if(temp[i].endsWith("4star.png")){
                            four+=1;
                          }else if(temp[i].endsWith("5wink.png")){
                            five+=1;
                          }else if(temp[i].endsWith("6sad.png")){
                            six+=1;
                          }else if(temp[i].endsWith("7angry.png")){
                            seven+=1;
                          }else if(temp[i].endsWith("8cry.png")){
                            eight+=1;
                          }else if(temp[i].endsWith("9cry.png")){
                            nine+=1;
                          }
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonIcon(
                              color: plusBtn,
                              lend:items.length.toString(),
                              one:one,
                              two:two,
                              three:three,
                              four:four,
                              five:five,
                              six:six,
                              seven:seven,
                              eight:eight,
                              nine:nine,
                          )),
                        );
                      },
                      mini: true,
                      backgroundColor: Colors.grey,
                      elevation: 2,
                      child: Center(child: Image.asset('assets/user (2).png'),)),
                ),
              ]),
      ),
    );
  }

  Widget ListWidget(col, date, month, emojiMood, title, body){
    int titleRange=20;
    int range=15;
    if(body.length > range){
      body=body.toString().substring(0,range)+'...';
    }
    if(title.length > titleRange){
      title=title.toString().substring(0,titleRange)+'...';
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text: date,style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600)),
                        TextSpan(text: month,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                      ]
                  ),
                ),
                SizedBox(height: 2,),
                Image.asset(emojiMood,width: MediaQuery.of(context).size.width*0.06,),
              ],),
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Text(title.trim().replaceAll('\n',''),style: TextStyle(fontWeight: FontWeight.w700),),
                Text(body.replaceAll('\n','').trim(),overflow: TextOverflow.ellipsis,)
              ],),
            ),
          ],),
        ),
      ),
    );
  }
}

class MainDrawer extends StatefulWidget {
  final Color plusBtn;
  final List items;
  const MainDrawer({Key key, this.plusBtn, this.items}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List cols = [
    Color(0xffbe654d),
    Color(0xff4886bd),
    Color(0xffbd639d),
    Color(0xff68be80),
    Color(0xffbfb35b),
  ];
  List newCols = [
    Colors.redAccent,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.orangeAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width*0.78,
      child: Column(children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.asset('assets/background/logo.png'),
          ),
          height: MediaQuery.of(context).size.height*0.26,
        ),
        SizedBox(
          height: 10.0,
        ),
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Premium()),
            );
          },
          leading: Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.07,),
          title: Text("Upgrade to PRO"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemePage()),
            );
          },
          leading: Image.asset(
            'assets/palette@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 22,
          ),
          title: Text("Theme"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 16),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiaryLock(color:newCols[cols.indexOf(widget.plusBtn)])),
            );
          },
          leading: Image.asset(
            'assets/lock@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 17,
          ),
          title: Text("Diary Lock"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Restore(color:newCols[cols.indexOf(widget.plusBtn)])),
            );
          },
          leading: Image.asset(
            'assets/cloud-backup-up-arrow@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 22,
          ),
          title: Text("Backup & Restore"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Export(color:newCols[cols.indexOf(widget.plusBtn)],items:widget.items)),
            );
          },
          leading: Image.asset(
            'assets/export@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 22,
          ),
          title: Text("Export"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Share.share('check out this wonderful diary app\nhttps://play.google.com/store/apps/details?id=mydiary.journal.diary.diarywithlock.diaryjournal.secretdiary&hl=en&gl=US', subject: 'Amazing diary app');
          },
          leading: Image.asset(
            'assets/share (3)@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 19,
          ),
          title: Text("Share App"),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings(color:newCols[cols.indexOf(widget.plusBtn)])),
            );
          },
          leading: Image.asset(
            'assets/settings (1)@3x.png',
            color: newCols[cols.indexOf(widget.plusBtn)],
            width: 22,
          ),
          title: Text("Settings"),
        ),
      ]),
    );
  }
}

class PopUpButtons{
  static const String a = 'Latest First';
  static const String b = 'Oldest First';

  static const List<String> choices = <String>[
    a,b
  ];
}