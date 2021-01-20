import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mydiary/NotificationPlugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Noti extends StatefulWidget {
  final Color color;

  const Noti({Key key, this.color}) : super(key: key);
  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  bool isSwitched = false;
  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationPlugin.setListenerForLowerVersions(onNotificationInLowerVersions);
    getStatus();
  }
  getStatus()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched=prefs.getBool('diary_remind');
    });
  }
  TimeOfDay timeOfDay = TimeOfDay(hour: 7, minute: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(color: Colors.white,fontSize: 15),),
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
            title: Text('Diary Reminder',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037),),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value)async{
                setState(() {
                  isSwitched=value;
                });
                if(isSwitched){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('diary_remind', true);
                  var v=prefs.getString('diary_phrase');
                  if(v!=null){
                    await notificationPlugin.cancelNotification(1);
                    await notificationPlugin.showDailyAtTimeNoti(Time(timeOfDay.hour,timeOfDay.minute,0),v);
                  }else{
                    await notificationPlugin.cancelNotification(1);
                    await notificationPlugin.showDailyAtTimeNoti(timeOfDay,"Don't Forget to Backup your Memories");
                  }
                }
                else{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('diary_remind', false);
                  await notificationPlugin.cancelNotification(1);
                }
              },
              activeTrackColor: Colors.grey,
              activeColor: widget.color,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text('Turn on reminder to avoid forgetting to write a diary.',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left:5),
            onTap: ()async{
              timeOfDay=await showTimePicker(
                  context: context,
                  initialTime: timeOfDay,
              );
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var v=prefs.getString('diary_phrase');
              if(v!=null){
                await notificationPlugin.cancelNotification(1);
                await notificationPlugin.showDailyAtTimeNoti(Time(timeOfDay.hour,timeOfDay.minute,0),v);
              }else{
                await notificationPlugin.cancelNotification(1);
                await notificationPlugin.showDailyAtTimeNoti(Time(timeOfDay.hour,timeOfDay.minute,0),"Don't Forget to Backup your Memories");
              }
            },
            title: Text('Reminder Time',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037,color: isSwitched?Colors.black:Colors.black38),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text('Auto',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033)),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left:5),
            onTap: (){
              _showDialog();
            },
            title: Text('Reminder phrase',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.037,color: isSwitched?Colors.black:Colors.black38),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text('Auto',style: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.033),),
            ),
          ),
        ],),
      ),
    );
  }
  TextEditingController t1 = TextEditingController();
  _showDialog() async {
    await showDialog<String>(
        context: context,
        builder: (context){
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller: t1,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Enter Phrase', hintText: 'Hurry up!!'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('DONE'),
                  onPressed: ()async{
                    if(t1.text.trim()!=""){
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('diary_phrase', t1.text);
                      await notificationPlugin.cancelNotification(1);
                      await notificationPlugin.showDailyAtTimeNoti(Time(timeOfDay.hour,timeOfDay.minute,0),t1.text);
                    }
                    Navigator.pop(context);
                  })
            ],
          );
        }
    );
  }
}
