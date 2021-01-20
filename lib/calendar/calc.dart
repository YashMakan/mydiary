import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/AddButton/add.dart';
import 'package:mydiary/AddButton/listwidgetView.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalcMain extends StatefulWidget {
  final int inte;
  final Color color;
  CalcMain({Key key, this.inte, this.color}) : super(key: key);

  @override
  _CalcMainState createState() => new _CalcMainState();
}

class _CalcMainState extends State<CalcMain> {
  DateTime _date = DateTime.now();
  List days=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  List months=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"];
  List<Widget> wids=[];
  List items=[];
  @override
  void initState() {
    super.initState();
    print(6567);
    getDate(DateTime.now().day,DateTime.now().month,DateTime.now().year);
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

  getDate(d,m,y)async{
    items=[];
    List<String> data=await getList();
    if(data!=null){
      print(7585);
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

        int date=int.parse(_date.replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ','')+' '); // date
        int month=months.indexOf(_date.replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ','')+' ')+2; // month
        int year=int.parse(_date.replaceAll('[','').replaceAll(']','').split(',')[2].replaceAll(' ','')+' '); // year
        print(date);
        print(month);
        print(year);
        print(d);
        print(m);
        print(y);
        if(d==date && m==month && y==year){
              setState(() {
                wids=List<Widget>.generate(data.length, (index) {
                  return GestureDetector(
                    onTap: (){
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
                    },
                    child: ListWidget(
                        Colors.white,
                        items[i][8].replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ',''), // date
                        items[i][8].replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ',''), // month
                        items[i][7].trim().replaceAll('\n',''),  // emojiMood
                        items[i][9], // title
                        items[i][10], // body
                        context
                    ),
                  );
                });
              });
        }else{
          wids=[];
        }
      }
    }else{
      wids=[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Color(0xffdce8f4),
        appBar: new AppBar(
          title: new Text('Calendar',style: TextStyle(color: Colors.black),),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xffdce8f4),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: new Offset(0.0, 5)
                    )
                  ]
              ),
              child: TableCalendar(
                onDaySelected: (date, events) {
                  setState(() {
                    _date=date;
                    getDate(_date.day, _date.month, _date.year);
                  });
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                  weekendStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                ),
                calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  weekdayStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  todayColor: Color(0xffc7d5e2),
                  todayStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
                  selectedColor: Colors.black,
                  outsideWeekendStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  outsideStyle: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
                headerStyle: HeaderStyle(
                  leftChevronIcon: Icon(Icons.arrow_back_ios, size: 10,),
                  rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 10,),
                  titleTextStyle: TextStyle(fontFamily: 'montserrat', fontSize: 10,color: Colors.black,fontWeight: FontWeight.w700),
                  formatButtonVisible: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.values[widget.inte],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,top: 40),
              child: Row(children: <Widget>[
                Text('${days[_date.weekday-1]}, ${months[_date.month-1]} ${_date.day}, ${_date.year}',style: TextStyle(color: widget.color, fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.045),)
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(thickness: 0.9,color: Colors.grey,),
            ),
            wids.length==0?Expanded(
              child: Center(child: Text("No diary on this day",style: TextStyle(fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),)),
            ):Expanded(child: Container(child: SingleChildScrollView(child: Column(children: wids,)),),)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: widget.color,
          onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEdit(datePassed: _date,color: widget.color,)),
          );
        },
          child: Icon(Icons.add),),
    );
  }
}

Widget ListWidget(col, date, month, emojiMood, title, body,context){
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