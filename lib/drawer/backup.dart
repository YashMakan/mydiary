import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mydiary/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NotificationPlugin.dart';

class Restore extends StatefulWidget {
  final Color color;

  const Restore({Key key, this.color}) : super(key: key);
  @override
  _RestoreState createState() => _RestoreState();
}

class _RestoreState extends State<Restore> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String sub="Tap to login";
  String my_rem="weekly";
  String email='';
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('backup',user.email);
    email=user.email;
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    setState(() {
      sub="Tap to login";
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('backup',null);
    print("User Sign Out");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
    notificationPlugin.setListenerForLowerVersions(onNotificationInLowerVersions);
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  getStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getString('backup');
    if(v!=null){
      setState(() {
        sub="Tap to logout";
        email=v;
      });
    }else{
      setState(() {
        sub="Tap to login";
      });
    }
    var rem=prefs.getString('backup_reminder');
    if(rem!=null){
      setState(() {
        my_rem=rem;
      });
    }else{
      setState(() {
        my_rem="weekly";
      });
    }
    setState(() {
      if(my_rem=="daily")
        _site=1;
      else if(my_rem=="weekly")
        _site=2;
      else if(my_rem=="never")
        _site=3;
      else
        _site=2;
    });
  }

  Future getList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('items');
  }

  Future setList(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items',v);
  }
  int _site;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Backup & Restore',style: TextStyle(color: Colors.white,fontSize: 15),),
        backgroundColor: widget.color,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      body: Column(children: <Widget>[
        SizedBox(height: 20,),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15),
          onTap: () {
            sub=="Tap to login"?signInWithGoogle().whenComplete(() {
              setState(() {
                sub="Tap to logout";
              });
            }):signOutGoogle();
          },
          leading: Container(
            width: MediaQuery.of(context).size.width*0.16,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(FlutterIcons.social_google_sli,color: widget.color)),
          ),
          title: Text("Backup Account",style: TextStyle(fontWeight: FontWeight.w400)),
          subtitle: Text(sub ,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 12)),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(thickness: 1,),
        ),
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: ListTile(
            onTap: () async {
              if(sub=="Tap to logout"){
                final databaseReference = FirebaseDatabase.instance.reference();
                List<String> data=await getList();
                databaseReference.child("Users").child(email.split('@')[0]).set({
                  'items':data.toString(),
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var v=prefs.getBool('backup_first');
                if(v==null){
                  prefs.setBool('backup_first', true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(spec: "five",)),
                  );
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                }
                Fluttertoast.showToast(
                    msg: "Data Backup Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                );
              }
            },
            title: Text("Backup Data",style: TextStyle(fontWeight: FontWeight.w400,color: sub=="Tap to logout"?Colors.black:Colors.grey),),
            subtitle: Text("Haven't Synced",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(thickness: 1,),
        ),
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: ListTile(
            onTap: ()async{
              _showDialog();
            },
            title: Text("Backup Reminder",style: TextStyle(fontWeight: FontWeight.w400),),
            subtitle: Text(my_rem,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(thickness: 1,),
        ),
        Padding(
          padding: const EdgeInsets.only(left:15.0),
          child: ListTile(
            onTap: ()async{
              print(email);
              if(sub=="Tap to logout"){
                final databaseReference = FirebaseDatabase.instance.reference();
                databaseReference.once().then((DataSnapshot snapshot) {
                  var data=snapshot.value;
                  List items=[];
                  List<String> news=data["Users"][email.split('@')[0]]["items"].split("\n,");
                  setList(news);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                  Fluttertoast.showToast(
                    msg: "Diary Restored",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                  );
                });
              }
            },
            title: Text("Restore Data",style: TextStyle(fontWeight: FontWeight.w400, color: sub=="Tap to logout"?Colors.black:Colors.grey),),
          ),
        )
      ],),
    );
  }
  _showDialog() async {
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(
        builder: (context,setState){
          return AlertDialog(
              title: Row(children: <Widget>[
                Text("Backup Reminder",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),
              ],),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text("daily",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                          leading: Radio(
                            activeColor: widget.color,
                            value: 1,
                            groupValue: _site,
                            onChanged: (value)async{
                              await notificationPlugin.cancelNotification(0);
                              await notificationPlugin.showDailyAtTime(Time(4, 0, 0));
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('backup_reminder',"daily");
                              setState(() {
                                _site = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text("weekly",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                          leading: Radio(
                            value: 2,
                            activeColor: widget.color,
                            groupValue: _site,
                            onChanged: (value)async{
                              await notificationPlugin.cancelAllNotification();
                              await notificationPlugin.showWeeklyAtDayTime();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('backup_reminder',"weekly");
                              setState(() {
                                _site = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text("never",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                          leading: Radio(
                            value: 3,
                            activeColor: widget.color,
                            groupValue: _site,
                            onChanged: (value)async{
                              await notificationPlugin.cancelAllNotification();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('backup_reminder',"never");
                              setState(() {
                                _site = value;
                              });
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            RaisedButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: widget.color,
                              textColor: Colors.white,
                              child: Text("Cancel".toUpperCase(), style: TextStyle(fontSize: 13.2, color: Colors.white)),
                            ),
                          ],)
                      ],)
                  ),
                ],)
          );
        },
      );
    });
  }
}

// await notificationPlugin.showNotification();
// await notificationPlugin.scheduleNotification();
// await notificationPlugin.showNotificationWithAttachment();
// await notificationPlugin.repeatNotification();
// await notificationPlugin.showDailyAtTime();
// await notificationPlugin.showWeeklyAtDayTime();
// count = await notificationPlugin.getPendingNotificationCount();
// print('Count $count');
// await notificationPlugin.cancelNotification();
// count = await notificationPlugin.getPendingNotificationCount();
// print('Count $count');