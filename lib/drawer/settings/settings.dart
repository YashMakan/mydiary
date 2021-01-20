import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/drawer/settings/tag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'moodstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'noti.dart';
class Settings extends StatefulWidget {
  final Color color;

  const Settings({Key key, this.color}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List daysWanted=["Auto", "Monday", "Sunday",];
  String day='Auto';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeekDay();
  }
  setWeekDay(v)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('first_day',v);
  }

  getWeekDay()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getInt('first_day');
    print(v);
    setState(() {
      day=daysWanted[v-1];
      _site=v;
    });
  }
  int _site;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(color: Colors.white,fontSize: 15),),
        backgroundColor: widget.color,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Customize',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.038),),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoodStyle(color: widget.color,settings:true)),
                    );
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Image.asset("assets/smiley.png",width: MediaQuery.of(context).size.width*0.07,color: widget.color),
                  ),
                  title: Text("Mood Style",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tag(color: widget.color,)),
                    );
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Image.asset("assets/tag@3x.png",width: MediaQuery.of(context).size.width*0.07,color: widget.color,),
                  ),
                  title: Text("Tag Management",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Noti(color: widget.color,)),
                    );
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Image.asset("assets/bell (1)@3x.png",width: MediaQuery.of(context).size.width*0.07,color: widget.color,),
                  ),
                  title: Text("Notification",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: (){
                    _showDialog();
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Image.asset("assets/calendar@3x.png",width: MediaQuery.of(context).size.width*0.07,color: widget.color,),
                  ),
                  title: Text("First day of the week",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
            ],),
          ),
          Divider(thickness: 1.1,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('About',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.038),),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                ListTile(
                  onTap: (){
                    _launchURL("https://play.google.com/store/apps/details?id=mydiary.journal.diary.diarywithlock.diaryjournal.secretdiary&hl=en&gl=US");
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Icon(Icons.star,size: MediaQuery.of(context).size.width*0.07,color: widget.color,),
                  ),
                  title: Text("Rate Us",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: (){
                    _launchURL("https://play.google.com/store/apps/details?id=mydiary.journal.diary.diarywithlock.diaryjournal.secretdiary&hl=en&gl=US");
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Icon(Icons.feedback,size: MediaQuery.of(context).size.width*0.07,color: widget.color,),
                  ),
                  title: Text("Feedback",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: ()async{
                    const url = 'http://ordlnance.com/privacy.html';
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Image.asset("assets/lock@3x.png",width: MediaQuery.of(context).size.width*0.05,color: widget.color,),
                  ),
                  title: Text("Privacy Policy",style: TextStyle(fontWeight: FontWeight.w400),),
                ),
            ],),
          )
        ],),
      ),
    );
  }
  _showDialog() async {
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(
        builder: (context,setState){
          return AlertDialog(
              title: Row(children: <Widget>[
                Text("First day of the week",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),
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
                          title: Text(daysWanted[0],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
                          leading: Radio(
                            activeColor: widget.color,
                            value: 1,
                            groupValue: _site,
                            onChanged: (value) {
                              setState(() {
                                _site = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(daysWanted[1],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
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
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(daysWanted[2],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),
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
                            SizedBox(width: 5,),
                            RaisedButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  day=daysWanted[_site-1];
                                  setWeekDay(_site);
                                  Navigator.pop(context);
                                });
                              },
                              color: widget.color,
                              textColor: Colors.white,
                              child: Text("Save".toUpperCase(), style: TextStyle(fontSize: 13.2, color: Colors.white)),
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
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }
}
