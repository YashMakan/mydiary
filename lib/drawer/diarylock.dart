import 'package:flutter/material.dart';
import 'package:mydiary/pin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryLock extends StatefulWidget {
  final Color color;

  const DiaryLock({Key key, this.color}) : super(key: key);
  @override
  _DiaryLockState createState() => _DiaryLockState();
}

class _DiaryLockState extends State<DiaryLock> {
  bool isSwitched = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPass();
  }
  getPass()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getString("pass");
    if(v!=null){
      setState(() {
        isSwitched=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Diary Lock',style: TextStyle(color: Colors.white,fontSize: 15),),
        backgroundColor: widget.color,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(left:5),
            title: Text('Diary Lock',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037),),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value){
                setState(() async{
                  if(!isSwitched){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PinPage(title: "Set Password to lock the Diary",)),
                    );
                  }else{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var n=prefs.getString("pass");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PinPage(title: "Enter Password to remove lock",remove:true,password: n,)),
                    );
                  }
                });
              },
              activeTrackColor: Colors.grey,
              activeColor: widget.color,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text('Set a passcode to protect your diary.',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
            ),
          ),
          ListTile(
            onTap: ()async{
              if(isSwitched){
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var n=prefs.getString("pass");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinPage(title: "Enter old Password to change", password:n, set:true)),
                );
              }else{
                //
              }
            },
            contentPadding: EdgeInsets.only(left:5),
            title: Text('Change Passcode',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037,color: isSwitched?Colors.black:Colors.black38),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text('change your passcode.',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
            ),
          ),
//          ListTile(
//            contentPadding: EdgeInsets.only(left:5),
//            title: Text('Set Security Question',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037),),
//            subtitle: Padding(
//              padding: const EdgeInsets.only(top:10.0),
//              child: Text('It will be used if in case you forgot your passcode.',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
//            ),
//          ),
        ],),
      ),
    );
  }
}
