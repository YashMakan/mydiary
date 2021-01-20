import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mydiary/AddButton/player_vid.dart';
import 'package:video_player/video_player.dart';

class ViewPage extends StatefulWidget {
  final String emojiMood;
  final List date;
  final String title;
  final String body;
  final List<String> elemPos;
  final List<String> files;
  final List<bool> selected;
  final List<String> values;
  final Color bodyColor;
  final bool bold;
  final String bodyFont;
  final double bodyFontSize;
  final TextAlign bodyAlign;
  final String selectedHeading;
  final int allindex;

  const ViewPage({Key key, this.emojiMood, this.date, this.title, this.body, this.elemPos, this.selected, this.values, this.bold, this.bodyFont, this.bodyFontSize, this.bodyAlign, this.selectedHeading, this.bodyColor, this.allindex, this.files}) : super(key: key);
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

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

  bool eyemode=false;
  List<String> texts=[];

  Color bodyColor=Colors.black;
  bool bold=false;
  String bodyFont='';
  double bodyFontSize=14;
  TextAlign bodyAlign=TextAlign.left;
  String selectedHeading='';
  bool imageisone=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      widget.body.contains('🖼')?calculateImg():texts.add(widget.body);
      bodyColor=widget.bodyColor;
      bold=widget.bold;
      bodyFont=widget.bodyFont;
      bodyFontSize=widget.bodyFontSize;
      bodyAlign=widget.bodyAlign;
      selectedHeading=widget.selectedHeading;
    });
  }
  calculateImg(){
    setState(() {
      texts=widget.body.split('🖼️');
      if(texts[0]==''){
        imageisone=true;
      }
      print(texts);
      var tobedeleted=[];
      for(var i = 0; i < texts.length; i++){
        if(texts[i]==''){
          tobedeleted.add(i);
        }
      }
      texts.removeWhere((element) => tobedeleted.contains(texts.indexOf(element)));
      print(texts);
    });
  }

  _showDialog(String src) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Row(children: <Widget>[
          Text("Video",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),
        ],),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          ChewieListItem(
            videoPlayerController: VideoPlayerController.file(
              File(src),
            ),
          )
        ],)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      backgroundColor: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Color(0xffdce8f4),
      body: Stack(children: <Widget>[
        widget.elemPos!=null?Positioned(
            left: double.parse(widget.elemPos[1]),
            top: double.parse(widget.elemPos[2]),
            child: Image.asset(elements[widget.allindex],)
        ):Container(),
        Align(alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Row(children: <Widget>[
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text: widget.date[0],style: TextStyle(fontSize: 28,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600)),
                        TextSpan(text: widget.date[1],style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        TextSpan(text: widget.date[2]),
                      ]
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(widget.emojiMood,width: MediaQuery.of(context).size.width*0.06,),
                )
              ],),
              SizedBox(height: 4,),
              Divider(thickness: 1,),
              Row(children: <Widget>[Text(widget.title,)],),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Column(children: List.generate(texts.length, (index) {
                return Column(
                  children: imageisone?imone(index):texone(index),);
              }),)
            ],),
          ),
        ),),
        Align(alignment: Alignment.bottomCenter,child: widget.values.length!=0?Padding(
          padding: const EdgeInsets.only(bottom:20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
            MySeparator(color: Colors.grey,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[Text('Tags:',style: TextStyle(color: Colors.black54),),],),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:8.0,left: 17),
                  child: Container(child: buildChips(),height: 30,),
                ),
              ],),
            ),
          ],),
        ):Container(width: 0, height: 0,),)
      ],),
    );
  }

  Widget buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < widget.values.length; i++) {
      Widget actionChip = Padding(padding: EdgeInsets.symmetric(horizontal: 2),child: InputChip(
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
        selected: widget.selected[i],
        label: Text(widget.values[i]),
      ));
      chips.add(actionChip);
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  List<Widget> texone(index){
    print('dldufuhiglf');
    return widget.body.contains('🖼')?[tex(index), im(index)]:[Row(children: <Widget>[Text(widget.body)],)];
  }

  List<Widget> imone(index){
    print('qqqqqqqqqqqqqqqqqqqq');
    return [im(index), tex(index)];
  }

  Widget tex(index){
    try{
      var a=Row(children: <Widget>[Flexible(child: Text(texts[index],style: TextStyle(
        color: bodyColor,
        fontFamily: bodyFont,
        fontSize: bodyFontSize,
        fontWeight: bold?FontWeight.bold:FontWeight.w400,
      ),))],);
      return a;
    }catch(_){
      var a=Container(width: 0,height: 0,);
      return a;
    }
  }
  Widget im(index){
    try{
      if(widget.files[index].endsWith('.jpg')){
        try{
          var a=GestureDetector(onTap:(){
            print(index);
            }, child: Row(children: <Widget>[
              Container(
                color: Colors.yellow[100],
                child: Image.file(File(widget.files[index]),),
                width: MediaQuery.of(context).size.width*0.3,
                height: MediaQuery.of(context).size.height*0.3,)
          ],));
          return a;
        }catch(_){
          var a=Container(width: 0,height: 0,);
          return a;
        }
      }
      else{
        try{
          var a = GestureDetector(onTap: (){
            print(index);
            }, child: Row(children: <Widget>[
              Column(children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _showDialog(widget.files[index].replaceAll(".mp4", ".jpg"));
                  },
                  child: Container(
                    color: Colors.yellow[100],
                    child: Stack(children: <Widget>[
                      Align(alignment: Alignment.center,child: Icon(Icons.play_arrow,color: Colors.white,),)
                    ],),
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.height*0.3,
                  ),
                )
              ],)
          ],));
          return a;
        }catch(_){
          var a=Container(width: 0,height: 0,);
          return a;
        }
      }
    }catch(_){
      return Container(width: 0, height: 0,);
    }
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}