import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:mydiary/AddButton/listwidgetView.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
  TextEditingController t1 = TextEditingController();
  List newCols = [
    Colors.redAccent,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.yellow
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeekDay();
    hideQuote();
    getItems();
    getIndex();
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

  bool have = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.053,),
            Row(children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
                Navigator.pop(context);
              },),
              Flexible(
                child: TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    hintText: "Search Diary",
                    suffixIcon: IconButton(
                      onPressed: () => t1.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v){
                  if(v!=''){
                    List<Widget> temp=[];
                    temp.add(SizedBox(height: MediaQuery.of(context).size.height*0.08,),);
                    for(int i = 0; i < items.length; i++){
                      String _title = items[i][9].replaceAll('\n','');
                      if(_title.startsWith(v)){
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
                    }
                    setState(() {
                      wids=temp;
                    });
                  }else{
                    setState(() {
                      wids=[];
                    });
                  }
                },),
              ),
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
////            FadeAnimation(2, Align(alignment:Alignment.center,child: AnimatedOpacity(opacity:quote_opacity,duration: Duration(seconds: 2,milliseconds: 500), child: Text('"\nKeep a diary,\nand someday it\'ll\nkeep you.\n',textAlign: TextAlign.center,style: GoogleFonts.ebGaramond(textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 30)))))),
////            FadeAnimation(6, Align(alignment: Alignment(0,0.4),child: Text('Tap to start your first entry',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w600),),)),
////            FadeAnimation(5.8,Opacity(opacity:0.7,child: Align(alignment: Alignment(0,0.49),child: Icon(arr,color: Colors.blueAccent,size: 40,)))),
////            FadeAnimation(5.6,Opacity(opacity:0.4,child: Align(alignment: Alignment(0,0.57),child: Icon(arr,color: Colors.blueAccent,size: 40,)))),
////            FadeAnimation(5.4,Opacity(opacity:0.3,child: Align(alignment: Alignment(0,0.65),child: Icon(arr,color: Colors.blueAccent,size: 40,)))),
//          ],
//        ),
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
