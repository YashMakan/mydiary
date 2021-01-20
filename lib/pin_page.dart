import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydiary/homescreen.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPage extends StatefulWidget {
  final String title;
  final bool pass;
  final String password;
  final bool remove;
  final bool set;
  const PinPage({Key key, this.title, this.pass, this.password, this.remove, this.set}) : super(key: key);
  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String src;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIndex();
  }

  getIndex()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getInt('in');
    if(v==0){
      setState(() {
        src='assets/background/login@3x.png';
      });
    }
    else if(v==1){
      setState(() {
        src='assets/background/login – 1@3x.png';
      });
    }
    else if(v==2){
      setState(() {
        src='assets/background/login – 2@3x.png';
      });
    }
    else if(v==3){
      setState(() {
        src='assets/background/login – 3@3x.png';
      });
    }
    else if(v==4){
      setState(() {
        src='assets/background/login – 4@3x.png';
      });
    }
    else if(v==null){
      setState(() {
        src='assets/background/login – 1@3x.png';
      });
    }
  }

  setPass(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pass", v);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: src!=null?DecorationImage(
            image: AssetImage(src),fit: BoxFit.fill,):null
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height*0.2,),
        Text(widget.title,style: TextStyle(fontWeight: FontWeight.w800,fontSize: MediaQuery.of(context).size.width*0.07,color: Colors.white),textAlign: TextAlign.center,),
        SizedBox(height: 20,),
        PinEntryTextField(
          onSubmit: (String pin)async{
            if(widget.set!=null){
              if(widget.password==pin){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinPage(title: "Set Password to lock the Diary",)),
                );
              }else{
                Fluttertoast.showToast(
                  msg: "Incorrect Password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                );
              }
            }
            else if(widget.pass==null && widget.remove == null){
              await setPass(pin);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var v=prefs.getBool('pass_banner');
              if(v==null){
                prefs.setBool('pass_banner', true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(spec: "four",)),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }
            }
            else{
              print(pin);
              print(widget.password);
              if(widget.password==pin){
                if(widget.remove!=null){
                  setPass(null);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }else{
                Fluttertoast.showToast(
                  msg: "Incorrect Password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                );
              }
            }
          },
          isTextObscure: true,
        )
      ],),
    ));
  }
}
