import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../textfile.dart';

class Export extends StatefulWidget {
  final Color color;
  final List items;
  const Export({Key key, this.color, this.items}) : super(key: key);
  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  int _site=1;
  bool buttonActive=false;
  List title = ['All Files', 'Last 7 days', 'Last 30 days', 'Customize'];
  bool isSwitched = false;
  String path;
  DateTime date1=DateTime.now().subtract(Duration(days: 9));
  DateTime date2=DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> selectedTimePicker(BuildContext context,num) async{
    if(num==1){
      final DateTime picked = await showDatePicker(context: context, initialDate: date1, firstDate: DateTime(1940), lastDate: DateTime(2030),builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: widget.color,
              onPrimary: Colors.white,
              surface: widget.color,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: widget.color,
          ),
          child: child,
        );
      },);
      if(picked!=null){
        setState(() {
          date1=picked;
        });
      }
    }else if(num==2){
      final DateTime picked = await showDatePicker(context: context, initialDate: date2, firstDate: DateTime(1940), lastDate: DateTime(2030),builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: widget.color,
              onPrimary: Colors.white,
              surface: widget.color,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: widget.color,
          ),
          child: child,
        );
      },);
      if(picked!=null){
        setState(() {
          date2=picked;
        });
      }
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export',style: TextStyle(color: Colors.white,fontSize: 15),),
        backgroundColor: widget.color,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Export Diary Period',style: TextStyle(color: Colors.grey[500]),),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(title[0],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                  leading: Radio(
                    value: 1,
                    activeColor: widget.color,
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Divider(thickness: 1,),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(title[1],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                  leading: Radio(
                    value: 2,
                    activeColor: widget.color,
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Divider(thickness: 1,),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(title[2],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                  leading: Radio(
                    value: 3,
                    activeColor: widget.color,
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Divider(thickness: 1,),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(title[3],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                  leading: Radio(
                    value: 4,
                    activeColor: widget.color,
                    groupValue: _site,
                    onChanged: (value) {
                      setState(() {
                        _site = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(children: <Widget>[
                  Spacer(),
                  RaisedButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      if(_site==4){
                        selectedTimePicker(context,1);
                      }
                    },
                    color: _site==4?widget.color:Colors.grey[200],
                    textColor: Colors.white,
                    child: Text(date1.toString().split(' ')[0], style: TextStyle(fontSize: 13.2, color: _site==4?Colors.white:Colors.black38)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: Text("To",style: TextStyle(color: Colors.black38),),
                  ),
                  RaisedButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      if(_site==4){
                        selectedTimePicker(context,2);
                      }
                    },
                    color: _site==4?widget.color:Colors.grey[200],
                    textColor: Colors.white,
                    child: Text(date2.toString().split(' ')[0], style: TextStyle(fontSize: 13.2, color: _site==4?Colors.white:Colors.black38)),
                  ),
                ],),
              ],
            ),
          ),
          Divider(thickness: 4,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Export to',style: TextStyle(color: Colors.grey[500]),),
                SizedBox(height: MediaQuery.of(context).size.height*0.007,),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text('.TXT',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                  trailing: RaisedButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () async{
                        if(_site==1){
                          DateFormat format = new DateFormat("dd MMM yyyy");
                          DateTime _date = format.parse("08 Jun 1999");
                          var res=await writeText(_date,DateTime.now());
                          if(res){
                            setState((){
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
                                      new FlatButton(
                                        onPressed: ()async{
                                          String text=await readContent();
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => TextFile(text:text)),
                                          );
                                        },
                                        child: new Text('Open'),
                                      ),
                                    ],
                                  ));
                            });
                          }
                          else{
                            print('Fuddu');
                          }
                        }
                        else if(_site==2){
                          var res=await writeText(DateTime.now().subtract(Duration(days: 7)),DateTime.now());
                          if(res){
                            setState((){
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
                                      new FlatButton(
                                        onPressed: ()async{
                                          String text=await readContent();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => TextFile(text:text)),
                                          );
                                        },
                                        child: new Text('Open'),
                                      ),
                                    ],
                                  ));
                            });
                          }
                          else{
                            print('Fuddu');
                          }
                        }
                        else if(_site==3){
                          var res=await writeText(DateTime.now().subtract(Duration(days: 30)),DateTime.now());
                          if(res){
                            setState((){
                              showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    title: new Text('Text File Successfully Stored to '),
                                    content: new Text(path),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: new Text('Sure'),
                                      ),
                                      new FlatButton(child: new Text('Open'),onPressed: ()async{
                                        String text=await readContent();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TextFile(text:text)),
                                        );
                                      },)
                                    ],
                                  ));
                            });
                          }
                          else{
                            print('Fuddu');
                          }
                        }
                        else if(_site==4){
                          var res=await writeText(date1,date2);
                          if(res){
                            setState((){
                              showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    title: new Text('Text File Successfully Stored to '),
                                    content: new Text(path),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: new Text('Sure'),
                                      ),
                                      new FlatButton(child: new Text("Open"),onPressed: ()async{
                                        String text=await readContent();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TextFile(text:text)),
                                        );
                                      },)
                                    ],
                                  ));
                            });
                          }
                          else{
                            print('Fuddu');
                          }
                        }
                      },
                      color: widget.color,
                      textColor: Colors.white,
                      child: Text("EXPORT".toUpperCase(), style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.033, color: Colors.white)),
                    ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Text('Only text will be exported',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Divider(thickness: 1,),
                ),
//                ListTile(
//                  contentPadding: EdgeInsets.all(0),
//                  title: Row(children: <Widget>[
//                    Text('.PDF',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
//                    SizedBox(width: 5,),
//                    Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,),
//                  ],),
//                  trailing: RaisedButton(
//                    elevation: 0.0,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(8.0),
//                    ),
//                    onPressed: () async{
//                      File file;
//                      final path = await _localPath;
//                      final Directory DocDir=Directory("$path/pdfExport");
//                      if(await DocDir.exists()){
////                        await DocDir.delete(recursive: true);
////                        final Directory docDirNew = await DocDir.create(recursive: true);
//                        file=File('${DocDir.path}/${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.txt');
//                      }
//                      else{
//                        final Directory docDirNew = await DocDir.create(recursive: true);
//                        file=File('${docDirNew.path}/${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.txt');
//                      }
////                      if(_site==1){
////                        DateFormat format = new DateFormat("dd MMM yyyy");
////                        DateTime _date = format.parse("08 Jun 1999");
////                        var res=await writePDF(_date,DateTime.now(),file);
////                      }
////                      else  if(_site==2){
////                        var res=await writePDF(DateTime.now().subtract(Duration(days: 7)),DateTime.now(),file);
////                      }
////                      else if(_site==3){
////                        var res=await writePDF(DateTime.now().subtract(Duration(days: 30)),DateTime.now(),file);
////                      }
////                      else if(_site==4){
////                        var res=await writePDF(date1,date2,file);
////                      }
//
//                    },
//                    color: widget.color,
//                    textColor: Colors.white,
//                    child: Text("EXPORT".toUpperCase(), style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.033, color: Colors.white)),
//                  ),
//                  subtitle: Padding(
//                    padding: const EdgeInsets.only(top:10.0),
//                    child: Text('Include pictures when exporting',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10,right: 10),
//                  child: Divider(thickness: 1,),
//                ),
//                ListTile(
//                  contentPadding: EdgeInsets.all(0),
//                  title: Row(children: <Widget>[
//                    Text('Remove Watermark',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037),),
//                    SizedBox(width: 5,),
//                    Image.asset("assets/crown.png",color: Colors.amberAccent,width: MediaQuery.of(context).size.width*0.045,),
//                  ],),
//                  trailing: Switch(
//                    value: isSwitched,
//                    onChanged: (value){
//                      setState(() {
//                        isSwitched=value;
//                        print(isSwitched);
//                      });
//                    },
//                    activeTrackColor: Colors.grey,
//                    activeColor: widget.color,
//                  ),
//                  subtitle: Padding(
//                    padding: const EdgeInsets.only(top:10.0),
//                    child: Text('Removes watermark when exporting',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
//                  ),
//                ),
              ],
            ),
          ),
        ],),
      )
    );
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    final Directory DocDir=Directory("$path/textExport");
    if(await DocDir.exists()){
//      await DocDir.delete(recursive: true);
//      final Directory docDirNew = await DocDir.create(recursive: true);
      return File('${DocDir.path}/${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.txt');
    }else{
      final Directory docDirNew = await DocDir.create(recursive: true);
      return File('${docDirNew.path}/${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.txt');
    }
  }

  Future<String> readContent() async {
    try {
      final file = File(path);
      setState(() {
        path=file.path;
      });
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      print(e);
      // If encountering an error, return
      return 'Error!';
    }
  }

  writeText(startDate,endDate) async {
    final file = await _localFile;
    setState(() {
      path=file.path;
    });
    List items = widget.items;
    print(items);
    if(items!=null || items != []){
      String totalText='';
      for(int i = 0; i < items.length; i++){
        String _body = items[i][10];
        String _title = items[i][9];

        String date=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ','').replaceAll('\n','')+' '; // date
        String month=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ','').replaceAll('\n','')+' '; // month
        String year=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[2].replaceAll(' ','').replaceAll('\n',''); // year
        DateFormat format = new DateFormat("dd MMM yyyy");
        print(date+month+year);
        DateTime _date = format.parse(date+month+year);
        print(startDate);
        print(endDate);
        if(startDate.isBefore(_date) && endDate.isAfter(_date)){
          totalText=totalText+'\n'+'Diary Index $i';
          totalText=totalText+'\nTitle:';
          totalText=totalText+_title;
          totalText=totalText+'\nBody:';
          totalText=totalText+_body;
          totalText=totalText+'\n-----------------------';
        }
      }
      file.writeAsString(totalText);
      return true;
    }
    return false;
  }

  writePDF(startDate,endDate,file) async {
    setState(() {
      path=file.path;
    });
    List items = widget.items;
    print(items);
    if(items!=null || items != []){
      String totalText='';
      for(int i = 0; i < items.length; i++){
        String _body = items[i][10];
        String _title = items[i][9];

        String date=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[0].replaceAll(' ','').replaceAll('\n','')+' '; // date
        String month=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[1].replaceAll(' ','').replaceAll('\n','')+' '; // month
        String year=items[i][8].replaceAll('[','').replaceAll(']','').split(',')[2].replaceAll(' ','').replaceAll('\n',''); // year

        String emojiMood = items[i][7].trim().replaceAll('\n','');  // emojiMood

        var bodyColor = items[i][2];
        var hexColor = bodyColor.replaceAll("Color(", "").replaceAll(')','').replaceAll('\n','');
        bodyColor=Color(int.parse("$hexColor"));

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

        DateFormat format = new DateFormat("dd MMM yyyy");
        DateTime _date = format.parse(date+month+year);

        if(startDate.isBefore(_date) && endDate.isAfter(_date)){
//          final doc = pw.Document(pageMode: PdfPageMode.outlines);
//          doc.addPage(pw.MultiPage(
//            pageFormat:
//            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
//            crossAxisAlignment: pw.CrossAxisAlignment.start,
////            header: (pw.Context context) {
////              if (context.pageNumber == 1) {
////                return null;
////              }
////              return pw.Container(
////                  alignment: pw.Alignment.centerRight,
////                  margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
////                  padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
////                  decoration: pw.BoxDecoration(
////                      border: pw.Border(
////                          bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey))),
////                  child: pw.Text('Portable Document Format',
////                      style: pw.Theme.of(context)
////                          .defaultTextStyle
////                          .copyWith(color: PdfColors.grey)));
////            },
//            footer: (pw.Context context) {
//              return pw.Container(
//                  alignment: pw.Alignment.centerRight,
//                  margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
//                  child: pw.Text(
//                      'Page ${context.pageNumber} of ${context.pagesCount}',
//                      style: pw.Theme.of(context)
//                          .defaultTextStyle
//                          .copyWith(color: PdfColors.grey)));
//                                                                          },
//                                                                          build: (pw.Context context) => <pw.Widget>[
//                                                                            pw.Header(
//                                                                                level: 0,
//                                                                                child: pw.Row(
//                                                                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                                                                    children: <pw.Widget>[
//                                                                                      pw.Text(_title, textScaleFactor: 2),
//                                                                                      pw.PdfLogo()
//                                                                                    ])
//              ),
//              pw.Paragraph(
//                text: _body,
//                style: pw.TextStyle(color: bodyColor)
//              )
//            ]
//          ));
        }
      }
      file.writeAsString(totalText);
      return true;
    }
    return false;
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
}
