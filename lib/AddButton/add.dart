import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydiary/AddButton/viewPage.dart';
import 'package:mydiary/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/cupertino.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydiary/drawer/settings/moodstyle.dart';
import 'package:mydiary/main.dart';
import 'package:intl/intl.dart';


class AddEdit extends StatefulWidget {
  final DateTime datePassed;
  final Color color;
  const AddEdit({Key key, this.datePassed, this.color}) : super(key: key);
  @override
  _AddEditState createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  List elements = [
    'assets/sticker/Asset 1@3x.png',
    'assets/sticker/Asset 2@3x.png',
    'assets/sticker/Asset 3@3x.png',
    'assets/sticker/Asset 4@3x.png',
    'assets/sticker/Asset 5@3x.png',
    'assets/sticker/Asset 6@3x.png',
    'assets/sticker/Asset 7@3x.png',
    'assets/sticker/Asset 8@3x.png',
    'assets/sticker/Asset 9@3x.png',

    'assets/sticker/Asset 10@3x.png',
    'assets/sticker/Asset 13@3x.png',
    'assets/sticker/Asset 14@3x.png',
    'assets/sticker/Asset 15@3x.png',
    'assets/sticker/Asset 16@3x.png',
    'assets/sticker/Asset 17@3x.png',
    'assets/sticker/Asset 18@3x.png',
    'assets/sticker/Asset 19@3x.png',
    'assets/sticker/Asset 20@3x.png',
    'assets/sticker/Asset 21@3x.png',
    'assets/sticker/Asset 22@3x.png',
    'assets/sticker/Asset 23@3x.png',
    'assets/sticker/Group 3@3x.png',

    'assets/sticker/Group 5@3x.png',
    'assets/sticker/Group 9@3x.png',
    'assets/sticker/Group 15@3x.png',
    'assets/sticker/Group 18@3x.png',
    'assets/sticker/Group 21@3x.png',
    'assets/sticker/Group 23@3x.png',
    'assets/sticker/Group 25@3x.png',
    'assets/sticker/Group 29@3x.png',
    'assets/sticker/Group 32@3x.png',

    'assets/sticker/Group 34@3x.png',
    'assets/sticker/Group 878@3x.png',
    'assets/sticker/Group 879@3x.png',
    'assets/sticker/Group 880@3x.png',
    'assets/sticker/Group 881@3x.png',
    'assets/sticker/Group 882@3x.png',
    'assets/sticker/Group 883@3x.png',
    'assets/sticker/Group 884@3x.png',
    'assets/sticker/Group 885@3x.png',
    'assets/sticker/Group 886@3x.png',
    'assets/sticker/Group 887@3x.png',
    'assets/sticker/Group 888@3x.png',
    'assets/sticker/Group 889@3x.png',
    'assets/sticker/Group 890@3x.png',
    'assets/sticker/Group 891@3x.png',
    'assets/sticker/Group 891@3x.png',
    'assets/sticker/Group 891@3x.png',
    'assets/sticker/Group 893@3x.png',
    'assets/sticker/Group 894@3x.png',
    'assets/sticker/Group 895@3x.png',
    'assets/sticker/Group 896@3x.png',
    'assets/sticker/Group 897@3x.png',
    'assets/sticker/Group 898@3x.png',
    'assets/sticker/Group 899@3x.png',
    'assets/sticker/Group 900@3x.png',
    'assets/sticker/Group 901@3x.png',
  ];

  List<String> finalList;

  bool eyemode=false;
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  FocusNode textSecondFocusNode;
  FocusNode textNode;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime date;

  Offset position;
  Offset herePos = Offset(0.0, 0.0);
  List<String> items = [];

  int elementOnScreen;
  int counter=1;
  bool coun=false;
  List bulletPoints=[null,"⚫","🌟","🎄","☁","🌸"];
  bool bulletOn=false;
  String bullet='';

  List<String> files= [];

  bool galleryBool=false;
  bool stickerBool=false;
  bool emojiActive=false;
  bool listBool=false;
  bool tagBool=false;
  bool fontBool=false;
  bool micBool=false;
  bool bottomBar=true;

  Color bodyColor=Colors.black;
  bool bold=false;
  String bodyFont='';
  double bodyFontSize=14;
  TextAlign bodyAlign=TextAlign.left;
  String selectedHeading='';
  List fontsNames=[
    'Default',
    'Bold',
    'Monospace',
    'A Adistro',
    'Aileron Black',
    'Aileron',
    'ALLOYINK',
    'AMATIC BOLD',
    'AMATIC REGULAR',
    'Ambarella',
    'Amiri',
    'Asterix\nblink',
    'BIG JOHN',
    'Cardo Bold',
    'Cardo',
    'Floane',
    'Great Vibes',
    'HAMURZ FREE',
    'Helvetica\nbold',
  ];

  List colorList=[
    Color(0xffC0C0C0),
    Color(0xff808080),
    Color(0xff000000),
    Color(0xffFF0000),
    Color(0xff800000),
    Color(0xffFFFF00),
    Color(0xff808000),
    Color(0xff00FF00),
    Color(0xff008000),
    Color(0xff00FFFF),
    Color(0xff008080),
    Color(0xff0000FF),
    Color(0xff000080),
    Color(0xffFF00FF),
    Color(0xff800080),
  ];
  int fontButtonIndex=0;

  List<Widget> wids=[];
  List<Widget> boxes=[];
  int allindex;
  List<Widget> menuButtonBig=[];
  int borderToList;

  TextEditingController _textEditingController = new TextEditingController();
  List<String> _values = new List();
  List<bool> _selected = new List();
  List months=["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"];

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

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '\n';

  List defaultEmojis=[];
  int choosen=0;
  String emojiMood='assets/emojis/1/1neutral.png';

  bool pu=false;
  getPU()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getBool('premium_user');
    setState(() {
      pu=v;
    });
  }
  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Row(children: <Widget>[
          Text("What's Your Mood",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),
          Spacer(),
          GestureDetector(onTap: ()async{
            var val = await Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new MoodStyle(hoosen:choosen,color: widget.color,),
              fullscreenDialog: true,)
            );
            print(val);
            if(val==0){
              setState(() {
                defaultEmojis=defaultEmojis1;
                Navigator.pop(context);
                _showDialog();
              });
            }else if(val==1){
              setState(() {
                defaultEmojis=defaultEmojis2;
                Navigator.pop(context);
                _showDialog();
              });
            }else if(val==2){
              setState(() {
                defaultEmojis=defaultEmojis3;
                Navigator.pop(context);
                _showDialog();
              });
            }
          },child: Text("MORE",style: TextStyle(color: widget.color,fontSize: MediaQuery.of(context).size.width*0.025),)),
        ],),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
        content: Container(
          height: MediaQuery.of(context).size.height*0.14,
          width: MediaQuery.of(context).size.width * 0.7,
          child: GridView.count(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 9/6,
            children: List.generate(9, (index) {
              return GestureDetector(onTap: (){
                emojiMood=defaultEmojis[index];
                Navigator.pop(context);
                mainFunction();
              }, child: Image.asset(defaultEmojis[index]));
            }),
          ),
        ),
      );
    });
  }

  final app=SizeConfig.mediaQueryData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPU();
    position=Offset(app.size.width/3, app.size.height/3);
    _speech = stt.SpeechToText();
    defaultEmojis=defaultEmojis1;
    _showDialog();
    widget.datePassed==null?date= DateTime.now():date=widget.datePassed;
    mainFunction2();
    mainFunction();
    print(TextSelection.fromPosition(TextPosition(offset: 0)));
  }

  Future<Null> selectedTimePicker(BuildContext context) async{
    final DateTime picked = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1940), lastDate: DateTime(2030));
    if(picked != null){
      date=picked;
      mainFunction2();
    }
  }

  Future getList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getStringList('items');
    return v;
  }

  Future setList(value)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items',value);
  }
  String somebodytext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffdce8f4),
      appBar: AppBar(
        backgroundColor: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        leading: IconButton(icon:Icon(Icons.close),onPressed: (){
          Navigator.pop(context);
        },),
        actions: <Widget>[
          GestureDetector(child: Image.asset('assets/eye.png',width: MediaQuery.of(context).size.width*0.07,),onTap: (){
            eyemode?eyemode=false:eyemode=true;
            mainFunction2();
          },),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.059),
            child: GestureDetector(onTap:()async{
              var _body=t2.text;
              var _title=t1.text;
              var _elemPos=finalList;
              var _date = [date.day.toString().length==1?'0'+date.day.toString()+' ':date.day.toString()+' ', months[date.month-1]+' ', date.year.toString()+' '];
              print(_elemPos);
              print(files);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewPage(
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
            },child: Image.asset('assets/qr-code-scan@3x.png',width: MediaQuery.of(context).size.width*0.058,)),
          ),
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: Center(child: GestureDetector(onTap:()async{
              var _body=t2.text;
              var _title=t1.text;
              var _elemPos=finalList;
              var _date = [date.day.toString().length==1?'0'+date.day.toString()+' ':date.day.toString()+' ', months[date.month-1]+' ', date.year.toString()+' '];

              String allText = '''
              $allindex`
              $bold`
              $bodyColor`
              $bodyFont`
              $bodyFontSize`
              $bodyAlign`
              $selectedHeading`
              $emojiMood`
              $_date`
              $_title`
              $_body`
              $_elemPos`
              $files`
              $_selected`
              $_values`
              ''';
              allText=stripMargin(allText);
              List<String> temp=await getList();
              if(temp==null){
                temp=[];
              }
              temp.add(allText);
              //developer.log(allText);
              await setList(temp);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var v = prefs.getInt('diary_streak');
              var d1 = DateFormat('d/M/yyyy').parse(prefs.getString('previous_diary')!=null?prefs.getString('previous_diary'):"2/1/2000");
              if(DateTime.now().difference(d1) < Duration(days: 2) && DateTime.now().difference(d1) > Duration(days: 1)){
                if(v!=null){
                  v+=1;
                }else{
                  v=1;
                }
                prefs.setInt('diary_streak', v);
                var one=prefs.getBool('diary_apprentice');
                var two=prefs.getBool('grow');
                var three=prefs.getBool('talent');

                if(v>=6 && one!=null && one!=true){
                    var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                    prefs.setString('previous_diary',temp);
                    prefs.setBool('diary_apprentice',true);
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new MyHomePage(spec: "one"),)
                    );
                }
                else{
                  var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                  prefs.setString('previous_diary',temp);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(),)
                  );
                }

                if(v>=10 && one!=null && two!=true && one==true){
                  var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                  prefs.setString('previous_diary',temp);
                  prefs.setBool('grow',true);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(spec: "two"),)
                  );
                }
                else{
                  var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                  prefs.setString('previous_diary',temp);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(),)
                  );
                }

                if(v>=100 && one!=null && three!=true && two==true && one==true){
                  var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                  prefs.setString('previous_diary',temp);
                  prefs.setBool('talent',true);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(spec: "three"),)
                  );
                }
                else{
                  var temp = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
                  prefs.setString('previous_diary',temp);
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(),)
                  );
                }

              }
              else if(DateTime.now().difference(d1) > Duration(days: 2)){
                prefs.setInt('diary_streak', null);
              }
              var tempa = DateTime.now().day.toString()+'/'+DateTime.now().month.toString()+'/'+DateTime.now().year.toString();
              prefs.setString('previous_diary',tempa);
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new MyHomePage(),)
              );
              }, child: Text('SAVE',style: TextStyle(color: widget.color,fontWeight: FontWeight.w600),))),
          ),
        ],
      ),
      body: Stack(children: wids,),
    );
  }

  String stripMargin(String s) {
    return s.splitMapJoin(
      RegExp(r'^', multiLine: true),
      onMatch: (_) => '\n',
      onNonMatch: (n) => n.trim(),
    );
  }

  mainFunction(){
    wids=[];
    print(app.size.height);
    print(allindex);
    boxes=[allindex!=null?DragBox(allindex,position, elements[allindex], Colors.red):Container()];
    List<Widget> temp1 = [
      Visibility(visible: eyemode,child: Align(alignment: Alignment.topLeft,child: Container(width: app.size.width, height: app.size.height, color: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Colors.transparent))),
      Align(alignment: Alignment.topCenter,child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              GestureDetector(
                onTap:(){
                  selectedTimePicker(context);
                },
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text: date.day.toString().length==1?'0'+date.day.toString()+' ':date.day.toString()+' ',style: TextStyle(fontSize: 28,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600)),
                        TextSpan(text: months[date.month-1]+' ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        TextSpan(text: date.year.toString()+' '),
                      ]
                  ),
                ),
              ),
              SizedBox(width: 1,),
              Icon(Icons.arrow_drop_down),
              Spacer(),
              GestureDetector(
                onTap: (){
                  _showDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Image.asset(emojiMood,width: app.size.width*0.06,),
                      SizedBox(width: app.size.width*0.02,),
                      Text('Mood',style: TextStyle(color: Colors.black87),)
                    ],),
                  ),
                ),
              )
            ],),
            SizedBox(height: 4,),
            Divider(thickness: 1,),
            TextFormField(
              controller: t1,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Title",
                  hintStyle: TextStyle(fontWeight: FontWeight.w600,color: Colors.black38)
              ),
            ),
            TextFormField(
              textAlign: bodyAlign,
              style: TextStyle(
                color: bodyColor,
                fontFamily: bodyFont,
                fontSize: bodyFontSize,
                fontWeight: bold?FontWeight.bold:FontWeight.w400,
              ),
              controller: t2,
              focusNode: textSecondFocusNode,
              onChanged: (val){
                somebodytext=val;
                if(val.split('\n').last.replaceAll(' ', '')=='' && bulletOn && !coun){
                  t2.text=t2.text+bullet+' ';
                  var newV = TextSelection.collapsed(offset: t2.text.length);
                  t2.selection=newV;
                }
                else if(val.split('\n').last.replaceAll(' ', '')=='' && bulletOn && coun){
                  print(val+ 'zinga');
                  t2.text=t2.text+counter.toString()+'.  ';
                  counter+=1;
                  var newV = TextSelection.collapsed(offset: t2.text.length);
                  t2.selection=newV;
                }
                else if(val.split('\n').last==bullet && bulletOn && !coun){
                  bulletOn=false;
                  var t=t2.text.split('\n');
                  t.removeLast();
                  t2.text=t.join('\n')+'\n';
                  var l = TextSelection.collapsed(offset: t2.text.length);
                  t2.selection = l;
                }
                else if(isNumeric(val.split('\n').last) && bulletOn && coun){
                  bulletOn=false;
                  coun=false;
                  var t=t2.text.split('\n');
                  t.removeLast();
                  t2.text=t.join('\n')+'\n';
                  var l = TextSelection.collapsed(offset: t2.text.length);
                  t2.selection = l;
                }
              },
              maxLines: null,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Write more here...",
                  hintStyle: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38)
              ),
            ),
          ],),
        ),
      ),),
      Stack(children: boxes),
      Align(alignment: Alignment.bottomCenter,child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: menuButtonBig,)),
    ];

    setState(() {
      wids.addAll(temp1);
    });
  }

  fontSizeCheck(){
    if(selectedHeading=='H1'){
      bodyFontSize=25;
    }
    else if(selectedHeading=='H2'){
      bodyFontSize=20;
    }
    else if(selectedHeading=='H3'){
      bodyFontSize=18;
    }
    else if(selectedHeading==''){
      bodyFontSize=14;
    }

  }
  Widget buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _values.length; i++) {
      Widget actionChip = Padding(padding: EdgeInsets.symmetric(horizontal: 2),child: InputChip(
        backgroundColor: Colors.white,
        selectedColor: Colors.white60,
        selected: _selected[i],
        label: Text(_values[i]),
        onPressed: () {
          _selected[i] = !_selected[i];
          mainFunction2();
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);

          _values = _values;
          _selected = _selected;
          mainFunction2();
        },
      ));

      chips.add(actionChip);
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  mainFunction2(){
    List<Widget> temp2 = [
      Visibility(
        visible: galleryBool,
        child: Container(
          width: app.size.width,
          height: app.size.height*0.15,
          color: Colors.white,
          child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
            RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: ()async{
                await getImg();
                galleryBool=false;
                mainFunction2();
              },
              color: widget.color,
              textColor: Colors.white,
              child: Text("Image".toUpperCase(), style: TextStyle(fontSize: app.size.width*0.033, color: Colors.white)),
            ),
            RaisedButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: ()async{
                await getVid();
                galleryBool=false;
                mainFunction2();
              },
              color: widget.color,
              textColor: Colors.white,
              child: Text("Video".toUpperCase(), style: TextStyle(fontSize: app.size.width*0.033, color: Colors.white)),
            ),
          ],),),
        ),
      ),

      Visibility(
        visible: emojiActive,
        child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.close),onPressed: (){
                  emojiActive=false;
                  bottomBar=true;
                  mainFunction2();
                },),
                EmojiPicker(
                  bgColor: Colors.white,
                  rows: 3,
                  columns: 7,
                  buttonMode: ButtonMode.MATERIAL,
                  recommendKeywords: ["face"],
                  numRecommended: 10,
                  onEmojiSelected: (emoji, category) {
                    int n=t2.selection.base.offset;
                    var val;
                    t2.text = t2.text.toString().substring(0,n)+emoji.emoji+t2.text.toString().substring(n).toString();
                    val = TextSelection.collapsed(offset: n+2);
                    t2.selection = val;
                  },
                )
              ],)
        ),
      ),// emoji
      Visibility(
        visible: listBool,
        child: Container(
          width: app.size.width,
          height: app.size.height/3,
          color: Colors.white,
          child: Stack(children: <Widget>[
            Align(alignment: Alignment.topLeft,child: Container(
              width: app.size.width*0.1,
              height: app.size.height*0.05,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))
              ),
              child: Center(child: Text('PRO',style: TextStyle(color: Colors.white,fontSize: app.size.width*0.025),),),
            ),),
            Align(alignment: Alignment.topCenter,child: Padding(
              padding: EdgeInsets.only(top:app.size.height*0.04),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Text('List',style: TextStyle(color: Colors.black,fontSize: app.size.width*0.045,fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 12/9,
                      padding: EdgeInsets.all(8),
                      children: <Widget>[
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=0;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==0?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list1.png',fit: BoxFit.fill,))),
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=1;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==1?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list2.png',fit: BoxFit.fill))),
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=2;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==2?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list3.png',fit: BoxFit.fill))),
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=3;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==3?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list4.png',fit: BoxFit.fill))),
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=4;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==4?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list5.png',fit: BoxFit.fill))),
                        GestureDetector(onTap:(){
                          if(pu!=null){
                            if(pu){
                              borderToList=5;
                              mainFunction2();
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
                          }, child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==5?Colors.black:Colors.transparent)),child: Image.asset('assets/background/list6.png',fit: BoxFit.fill))),
                      ],
                    ),
                  )
                ],),
            ),),
            Align(alignment: Alignment.topRight,child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.close),onPressed: (){
                      listBool=false;
                      bottomBar=true;
                      mainFunction2();
                    },),
                    IconButton(icon: Icon(Icons.check),onPressed: (){
                      counter=1;
                      listBool=false;
                      bottomBar=true;
                      mainFunction2();
                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                      if(t2.text.split('\n').last.replaceAll(' ', '') == ''){
                        var val=bulletPoints[borderToList];
                        if(val!=null){
                          t2.text=t2.text+val+' ';
                          bulletOn=true;
                          bullet=val;
                          val = TextSelection.collapsed(offset: t2.text.length);
                          t2.selection = val;
                          FocusScope.of(context).requestFocus(textSecondFocusNode);
                        }
                        else{
                          bulletOn=true;
                          coun=true;
                          t2.text=t2.text+counter.toString()+'.  ';
                          counter+=1;
                          val = TextSelection.collapsed(offset: t2.text.length);
                          t2.selection = val;
                        }
                      }
                      else{
                        print('!!!!!!! $counter');
                        t2.text=t2.text+'\n';
                        print('!!!!!!!!!!!! $counter');
                        var val=bulletPoints[borderToList];
                        if(val!=null){
                          t2.text=t2.text+val+' ';
                          bulletOn=true;
                          bullet=val;
                          val = TextSelection.collapsed(offset: t2.text.length);
                          t2.selection = val;
                        }
                        else{
                          bulletOn=true;
                          coun=true;
                          t2.text=t2.text+counter.toString()+'.  ';
                          counter+=1;
                          print('!62193981266 $counter');
                          val = TextSelection.collapsed(offset: t2.text.length);
                          t2.selection = val;
                          print('!62193981266 $counter');
                        }

                      }
                    },),
                  ],)
            ),)
          ],),
        ),
      ),// list
      Visibility(
        visible: stickerBool,
        child: Container(
          width: app.size.width,
          height: app.size.height/3,
          color: Colors.white,
          child: Stack(children: <Widget>[
            Align(alignment: Alignment.topCenter,child: Padding(
              padding: EdgeInsets.only(top:app.size.height*0.04),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 9/6,
                        padding: EdgeInsets.all(8),
                        children: List.generate(56, (index) {
                          return GestureDetector(onTap: ()async{
                            stickerBool=false;
                            elementOnScreen=index;
                            allindex=index;
//                            var l=await getPositions();
//                            print(l);
//                            List<String> news=[allindex.toString(), l[1], l[2]];
//                            await addPosition(news);
                            mainFunction2();
                          },child: Image.asset(elements[index]),);
                        })
                      //56 lines
                      //GestureDetector(onTap:(){borderToList=0;mainFunction2();},child: Container(decoration: BoxDecoration(border: Border.all(color: borderToList==0?Colors.black:Colors.transparent)),child: Image.asset(elements[],))),
                    ),
                  )
                ],),
            ),),
            Align(alignment: Alignment.topRight,child: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){
              boxes=[];
              allindex=null;
              position=Offset(app.size.width/3, app.size.height/3);
              mainFunction2();
            },),)
          ],),
        ),
      ),// sticker
      Visibility(
          visible: tagBool,
          child: Column(children: <Widget>[
            MySeparator(color: Colors.grey,),
            Container(
              width: app.size.width,
              color: Colors.transparent,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:8.0,left: 17),
                  child: Container(child: buildChips(),height: 30,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    focusNode: textNode,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Type tags here',
                        hintStyle: TextStyle(fontSize: app.size.width*0.03)
                    ),
                    onFieldSubmitted: (val){
                      _values.add(_textEditingController.text);
                      _selected.add(true);
                      _textEditingController.clear();
                      _values = _values;
                      _selected = _selected;
                      mainFunction2();
                    },
                  ),
                ),
              ],),
            ),
          ],)
      ),// tag
      Visibility(
        visible: fontBool,
        child: Container(
          width: app.size.width,
          height: app.size.height/3,
          color: Colors.white,
          child: Stack(children: <Widget>[
            Align(alignment: Alignment.topLeft,child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(icon: Icon(Icons.close),onPressed: (){
                fontBool=false;
                bottomBar=true;
                mainFunction2();
              },),
            ),),
            Align(alignment: Alignment.topCenter,child: Padding(
              padding: EdgeInsets.only(top:app.size.height*0.03),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Text('Font',style: TextStyle(color: Colors.black,fontSize: app.size.width*0.045,fontWeight: FontWeight.w600)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        IconButton(icon: Icon(Icons.format_align_left), onPressed: () {
                          bodyAlign=TextAlign.left;
                          mainFunction();
                        },),
                        IconButton(icon: Icon(Icons.format_align_center), onPressed: () {
                          bodyAlign=TextAlign.center;
                          mainFunction();
                        },),
                        IconButton(icon: Icon(Icons.format_align_right), onPressed: () {
                          bodyAlign=TextAlign.right;
                          mainFunction();
                        },),
                      ],),
                      Padding(
                        padding: const EdgeInsets.only(right:13.0),
                        child: Row(children: <Widget>[
                          GestureDetector(onTap: (){
                            selectedHeading=='H1'?selectedHeading='':selectedHeading='H1';
                            fontSizeCheck();
                            mainFunction2();
                          },child: Text('H1',style: TextStyle(color: selectedHeading=='H1'?widget.color:Colors.black38, fontSize: app.size.width*0.053),textAlign: TextAlign.end,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:18.0),
                            child: GestureDetector(onTap:(){
                              selectedHeading=='H2'?selectedHeading='':selectedHeading='H2';
                              fontSizeCheck();
                              mainFunction2();
                            },child: Text('H2',style: TextStyle(color: selectedHeading=='H2'?widget.color:Colors.black38, fontSize: app.size.width*0.043),textAlign: TextAlign.end)),
                          ),
                          GestureDetector(onTap: (){
                            selectedHeading=='H3'?selectedHeading='':selectedHeading='H3';
                            fontSizeCheck();
                            mainFunction2();
                          }, child: Text('H3',style: TextStyle(color: selectedHeading=='H3'?widget.color:Colors.black38, fontSize: app.size.width*0.037),textAlign: TextAlign.end)),
                        ],),
                      )
                    ],),
                  SizedBox(height: 1,),
                  Container(
                    height: app.size.width*0.055,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: List.generate(15, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal:8.0),
                          child: GestureDetector(onTap:(){
                            bodyColor=colorList[index];
                            mainFunction();
                          },child: Container(width: app.size.width*0.055,height: 0,decoration: BoxDecoration(color: colorList[index]))),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: app.size.height*0.02,),
                  Expanded(
                    child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 12/9,
                        padding: EdgeInsets.all(8),
                        children: List.generate(19, (index) {
                          return GestureDetector(onTap: (){
                            fontButtonIndex=index;
                            if(index!=1 && index!=0){
                              bold=false;
                              bodyFont=fontsNames[index];
                              mainFunction();
                            }else if(index==1){
                              bold=true;
                              mainFunction();
                            }else if(index==0){
                              bodyColor=Colors.black;
                              bold=false;
                              bodyFont='';
                              bodyFontSize=14;
                              bodyAlign=TextAlign.left;
                              selectedHeading='';
                              mainFunction();
                            }
                            mainFunction2();
                          },child: Container(decoration: BoxDecoration(color: Color(0xffdce8f4),border: Border.all(color:fontButtonIndex==index?widget.color:Colors.transparent)),child: Center(child: Text(fontsNames[index],style: TextStyle(fontFamily: fontsNames[index]),))));
                        })
                    ),
                  )
                ],),
            ),),
          ],),
        ),
      ),
      Visibility(
        visible: micBool,
        child: Expanded(
          child: Container(
            color: Colors.transparent,
            child: Stack(children: <Widget>[
              Align(alignment: Alignment(0,0.85),child: AvatarGlow(
                animate: _isListening,
                glowColor: Colors.redAccent,
                endRadius: 75.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: _listen,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                ),
              ),),
            ],),
          ),
        ),
      ),
      Visibility(
        visible: bottomBar,
        child: Container(
          decoration: BoxDecoration(
              color: eyemode?Colors.lightGreenAccent.withOpacity(0.01):Colors.white,
              boxShadow: [
                BoxShadow(
                    color: eyemode?Colors.lightGreenAccent.withOpacity(0.01):Colors.grey,
                    blurRadius: eyemode?0.0:5.0)
              ]
          ),
          height: app.size.height*0.065,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap: (){
                    setState(() {
                      emojiActive=false;
                      listBool=false;
                      stickerBool=false;
                      tagBool=false;
                      fontBool=false;
                      galleryBool?galleryBool=false:galleryBool=true;
                      mainFunction2();
                    });
                  },child: Image.asset('assets/background/gallery.png',width: app.size.width*0.085,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap:(){
                    emojiActive=false;
                    listBool=false;
                    galleryBool=false;
                    tagBool=false;
                    fontBool=false;
                    stickerBool?stickerBool=false:stickerBool=true;
                    mainFunction2();
                  },child: Image.asset('assets/background/badge.png',width: app.size.width*0.085,)),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal:14.0),
                    child: GestureDetector(onTap: (){
                      setState(() {
                        print('HI');
                        listBool=false;
                        galleryBool=false;
                        stickerBool=false;
                        tagBool=false;
                        fontBool=false;
                        bottomBar=false;
                        emojiActive?emojiActive=false:emojiActive=true;
                        print(emojiActive);
                        mainFunction2();
                      });
                    },child: Image.asset('assets/background/emoji.png',width: app.size.width*0.085,),)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap:(){
                    listBool=false;
                    stickerBool=false;
                    galleryBool=false;
                    tagBool=false;
                    emojiActive=false;
                    bottomBar=false;
                    fontBool?fontBool=false:fontBool=true;
                    mainFunction2();
                  },child: Image.asset('assets/background/text-font.png',width: app.size.width*0.085,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap: (){
                    emojiActive=false;
                    galleryBool=false;
                    stickerBool=false;
                    tagBool=false;
                    fontBool=false;
                    bottomBar=false;
                    listBool?listBool=false:listBool=true;
                    mainFunction2();
                  }, child: Image.asset('assets/background/list.png',width: app.size.width*0.08,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap: (){
                    emojiActive=false;
                    galleryBool=false;
                    stickerBool=false;
                    listBool=false;
                    fontBool=false;
                    tagBool?tagBool=false:tagBool=true;
                    FocusScope.of(context).requestFocus(textNode);
                    mainFunction2();
                  }, child: Image.asset('assets/background/price-tags.png',width: app.size.width*0.085,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:14.0),
                  child: GestureDetector(onTap: ()async{
                    micBool?micBool=false:micBool=true;
                    galleryBool=false;
                    emojiActive=false;
                    stickerBool=false;
                    listBool=false;
                    fontBool=false;
                    tagBool=false;
                    mainFunction2();
                  },child: Image.asset('assets/background/microphone-voice-interface-symbol.png',width: app.size.width*0.085,)),
                ),
              ],),
          ),
        ),
      )
    ];
    setState(() {
      menuButtonBig = temp2;
    });
    mainFunction();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val){
          print('onStatu: $val');
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords!=''?val.recognizedWords:_text;

            if (val.hasConfidenceRating && val.confidence > 0) {
              t2.text=t2.text+' '+_text;
              micBool=false;
              mainFunction2();
            }
          }),
        );
      }else{
//        micBool=false;
//        mainFunction2();
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  getImg() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) async {
      files.add(image.path);
      if(t2.text.split('\n').last.replaceAll(' ', '') == ''){
        t2.text=t2.text+'🖼️';
      }else{
        t2.text=t2.text+'\n'+'🖼️';
      }
      var val = TextSelection.collapsed(offset: t2.text.length);
      t2.selection = val;
    });

  }
  getVid() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickVideo(source: ImageSource.gallery).then((vid) async {
      files.add(vid.path.replaceAll('.jpg','.mp4'));
      if(t2.text.split('\n').last.replaceAll(' ', '') == ''){
        t2.text=t2.text+'🖼️';
      }else{
        t2.text=t2.text+'\n'+'🖼️';
      }
      var val = TextSelection.collapsed(offset: t2.text.length);
      t2.selection = val;
    });
  }

  DragBox(index, initPos, label, itemColor){
    position = initPos;
    return Positioned(
        left: position.dx,
        top: position.dy,
        child: Draggable(
          data: itemColor,
          child: Container(
            child: Center(
                child: Image.asset(label)
            ),
          ),
          onDragEnd: (v) async {
            herePos=Offset(v.offset.dx,v.offset.dy);
            setState(() {
              setState(() {
                position=herePos;
                mainFunction2();
              });
            });
            items=[index.toString(), herePos.dx.toString(), herePos.dy.toString()];
            finalList=items;
            // get data from S.P
            // if items['index'] in S.P then update that value
            // else add value
          },
          childWhenDragging: Container(width: 0,height: 0,),
          feedback: Opacity(
            opacity: 0.5,
            child: Image.asset(label),
          ),
        ));
  }


  
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    // ignore: deprecated_member_use
    return double.parse(s, (e) => null) != null;
  }

  encrypt(String text){
    List enList=text.codeUnits;
    List<int> res=[];
    for(var i=0;i<enList.length;i++){
      res.add(enList[i]+13);
    }
    return String.fromCharCodes(res);
  }

}