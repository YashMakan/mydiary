import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:share/share.dart';
import 'achievement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonIcon extends StatefulWidget {
  final String lend;
  final int one;
  final int two;
  final int three;
  final int four;
  final int five;
  final int six;
  final int seven;
  final int eight;
  final int nine;
  final Color color;
  PersonIcon({Key key, this.lend, this.one, this.two, this.three, this.four, this.five, this.six, this.seven, this.eight, this.nine, this.color}) : super(key: key);
  @override
  _PersonIconState createState() => _PersonIconState();
}

class _PersonIconState extends State<PersonIcon> {
  bool one,three,four=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }
  getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      one=prefs.getBool('diary_apprentice');
      three=prefs.getBool('grow');
      four=prefs.getBool('talent');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Mine',style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.048),),
      ),
      backgroundColor: Color(0xffdce8f4),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          first_card(widget.lend,context),
          chart_card(
              context,
              widget.one,
              widget.two,
              widget.three,
              widget.four,
              widget.five,
              widget.six,
              widget.seven,
              widget.eight,
              widget.nine,
          ),
          achievements(context,one,three,four),
          SizedBox(height: 20,)
        ],),
      ),
    );
  }
}

Widget first_card(text,context){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/banner1.png'),
          fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Column(
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(children: <Widget>[
            Text('My Diary',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.056,color: Colors.white,fontWeight: FontWeight.w700),),
            Spacer(),
            IconButton(icon:Icon(Icons.share),color: Colors.white,onPressed: (){
              print('suhi');
              Share.share('Finally completed $text diaries by using  MyDiary app. You should also use https://play.google.com/store/apps/details?id=mydiary.journal.diary.diarywithlock.diaryjournal.secretdiary&hl=en&gl=US', subject: 'Look what I made!');
            },)
          ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left:25.0),
          child: Row(children: <Widget>[
            Text(text,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.1,color: Colors.white,fontWeight: FontWeight.w700),)
          ],),
        ),
        Padding(
            padding: const EdgeInsets.only(left:25.0,top:10),
            child: Row(children: <Widget>[
              Text('Diaries',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color: Colors.white,fontWeight: FontWeight.w700),)
            ],),
        ),
        Padding(
            padding: const EdgeInsets.only(left:25.0,top: 10),
            child: Row(children: <Widget>[
              Text('A Diary Mean Yes Indeed',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06,color: Colors.white,fontWeight: FontWeight.w300,fontFamily: 'italianno'),)
            ],),
        )
      ],),
    ),
  );
}

Widget chart_card(context,one, two, three, four, five, six, seven, eight, nine){
  final List<String> _dropdownValues = [
    "Last 7 days",
  ];
  var data = [
    ChartClick('😑',one, Colors.blueAccent),
    ChartClick('☺',two, Colors.blueAccent),
    ChartClick('😄',three, Colors.blueAccent),
    ChartClick('😍',four, Colors.blueAccent),
    ChartClick('😚',five, Colors.blueAccent),
    ChartClick('😢',six, Colors.blueAccent),
    ChartClick('😡',seven, Colors.blueAccent),
    ChartClick('😞',eight, Colors.blueAccent),
    ChartClick('😭',nine, Colors.blueAccent),
  ];

  var series = [
    charts.Series(
      domainFn: (ChartClick clickData, _) => clickData.year,
      measureFn: (ChartClick clickData, _) => clickData.clicks,
      colorFn: (ChartClick clickData, _) => clickData.color,
      id: 'Clicks',
      data: data,
    ),
  ];

  var chart = charts.BarChart(
    series,
    animate: true,
  );

  var chartWidget = Padding(
    padding: EdgeInsets.all(32.0),
    child: SizedBox(
      height: 200.0,
      child: chart,
    ),
  );
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(children: <Widget>[
              Text('Mood Statistics',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.038,color: Colors.black,fontWeight: FontWeight.w700),),
            ],),
          ),
          chartWidget
        ],),
    ),
  );
}
class ChartClick {
  final String year;
  final int clicks;
  final charts.Color color;

  ChartClick(this.year, this.clicks, Color color)
      : this.color = charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

Widget achievements(context,one,three,four){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(children: <Widget>[
              Text('Achievements',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.056,color: Colors.black,fontWeight: FontWeight.w700),),
              Spacer(),
              GestureDetector(onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Achievement()),
                );
              },child: Text('More',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.grey,fontWeight: FontWeight.w700),)),
            ],),
          ),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: <Widget>[
              roundAchievements('assets/background/quill.png', 'Diary Apprentice',context,one),
              roundAchievements('assets/background/mountains.png', 'Will Power',context,three),
              roundAchievements('assets/background/plant.png', 'Growing Strong',context,four),
            ],
          )
        ],),
    ),
  );
}
Widget roundAchievements(img,name,context,col){
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
    Text(name,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.02,color: Colors.black),),
    SizedBox(height: 10,)
  ],);
}