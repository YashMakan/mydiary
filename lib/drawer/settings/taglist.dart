import 'package:flutter/material.dart';
import 'package:mydiary/AddButton/listwidgetView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class TagList extends StatefulWidget {
  final String tag;

  const TagList({Key key, this.tag}) : super(key: key);
  @override
  _TagListState createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  List<Widget> wids=[];
  List items=[];
  bool have = false;
  List selected=[];
  List<Color> cont;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  Future getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('items');
  }

  ToBool(val){
    if(val=="true"){
      return  true;
    }else{
      return false;
    }
  }

  ToList(val){
    if(this != "null"){
      return json.decode(val);
    }else{
      return null;
    }
  }
  indexAll(list,str){
    List<int> last=[];
    for(int i = 0; i < list.length; i++){
      if(str==list[i])
        last.add(i);
      else
        null;
    }
    return last;
  }
  getItems() async {
    List<String> data = await getList();
    if (data != null) {
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
      setState(() {
        // ignore: missing_return
        wids=List.generate(items.length, (i) {
          List<String> _values = List<String>.from(ToList(items[i][14].replaceAll('[','["').replaceAll(',','","').replaceAll(']','"]').replaceAll(' ','')));
          print(_values);
          print(widget.tag);
          if(_values.contains(widget.tag)){
            return GestureDetector(
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
            );
          }
          else{
            return Container();
          }
        });
      });
    }
    print(wids.length);
  }

  int count(List<String> list, String element) {
    if (list == null || list.isEmpty) {
      return 0;
    }

    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag Management',style: TextStyle(color: Colors.black,fontSize: 15),),
        backgroundColor: Color(0xffdce8f4),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(child: wids.length!=0?Column(children: wids,):Center(child: Text("No Tags Used"),)),
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
