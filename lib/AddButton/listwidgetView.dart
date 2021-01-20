import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydiary/AddButton/ListWidgetEdit.dart';
import 'package:mydiary/AddButton/player_vid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:typed_data';

class FirstViewPage extends StatefulWidget {
  final String emojiMood;
  final List date;
  final String title;
  final String body;
  final List<dynamic> elemPos;
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
  final int tapindex;
  const FirstViewPage({Key key, this.emojiMood, this.date, this.title, this.body, this.elemPos, this.selected, this.values, this.bold, this.bodyFont, this.bodyFontSize, this.bodyAlign, this.selectedHeading, this.bodyColor, this.allindex, this.files, this.tapindex}) : super(key: key);
  @override
  _FirstViewPageState createState() => _FirstViewPageState();
}

class _FirstViewPageState extends State<FirstViewPage> {
  GlobalKey _globalKey = new GlobalKey();

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
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.045),
              child: GestureDetector(onTap:()async{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstEditPage(
                    tapindex:widget.tapindex,
                    allindex:widget.allindex,
                    bold:widget.bold,
                    bodyColor:widget.bodyColor,
                    bodyFont:widget.bodyFont,
                    bodyFontSize:widget.bodyFontSize,
                    bodyAlign:widget.bodyAlign,
                    selectedHeading:widget.selectedHeading,
                    emojiMood: widget.emojiMood,
                    date: widget.date,
                    title: widget.title,
                    body: widget.body,
                    elemPos: widget.elemPos,
                    files: widget.files,
                    selected: widget.selected,
                    values:widget.values,
                  )),
                );
              },child: Image.asset('assets/pencil@3x.png',width: MediaQuery.of(context).size.width*0.058,)),
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.043),
              child: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert,color: Colors.black,),
                elevation: 3.2,
                onCanceled: () {
                  print('You have not chossed anything');
                },
                tooltip: 'Details',
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
            ),
          ],
          leading: IconButton(icon:Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
        ),
        backgroundColor: eyemode?Colors.lightGreenAccent.withOpacity(0.1):Color(0xffdce8f4),
        body: Stack(children: <Widget>[
          widget.elemPos!=null?Positioned(
              left: widget.elemPos[1],
              top: widget.elemPos[2],
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
      ),
    );
  }

  void _select(String choice)async{
    if(choice=='Export PDF')
      getImage();
    else if(choice=='Share')
      share();
  }
  getImage()async{
    Fluttertoast.showToast(
      msg: "Processing your PDF",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
    RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    PdfDocument document = PdfDocument();
    PdfPage page = document.pages.add();
    final PdfImage image1 = PdfBitmap(pngBytes);
    page.graphics.drawImage(image1, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
    List<int> bytes = document.save();
    document.dispose();
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path;
    File file = File('$path/Output.pdf');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Text File Successfully Stored to'),
            content: new Text(path),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: new Text('Sure'),
              ),
            ],
          ));
    });
  }

  share()async{
    Fluttertoast.showToast(
      msg: "Processing",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
    RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    final directory = (await getExternalStorageDirectory()).path;
    File imgFile = new File('$directory/0.jpg');
    imgFile.writeAsBytes(pngBytes);
    Share.shareFiles(['$directory/0.jpg'], text: 'Made with love using MyDiary');
//    await Share.file('ESYS AMLOG', 'output.jpg', pngBytes, 'image/jpg',text: "made with MyDiary App Journal");
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
    return widget.body.contains('🖼')?[tex(index), im(index)]:[Row(children: <Widget>[Flexible(child: Text(widget.body))],)];
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
          }, child: Row(children: <Widget>[Container(color: Colors.yellow[100],child: Image.file(File(widget.files[index]),),width: MediaQuery.of(context).size.width*0.3,height: MediaQuery.of(context).size.height*0.3,)],));
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
                  child: Center(child: Icon(Icons.play_arrow,color: Colors.white,),),
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

class PopUpButtons{
  static const String a = 'Export PDF';
  static const String b = 'Share';

  static const List<String> choices = <String>[
    a,b
  ];
}