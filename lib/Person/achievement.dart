import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mydiary/Animation/FadeAnimation.dart';

class Achievement  extends StatefulWidget {
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  bool one,three,four,five,six,seven=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }
  getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      one=prefs.getBool('diary_apprentice');
      three=prefs.getBool('grow');
      four=prefs.getBool('talent');
      five=prefs.getBool('premium_user');
      six=prefs.getBool('backup_first');
      seven=prefs.getBool('pass_banner');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Achievements',style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.9,
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              children: <Widget>[
                roundAchievements('assets/background/quill.png', 'Diary Apprentice',context,one,"You need to write diaries for 6 days to unlock it","You made it! You made a streak of 6 days"),
                roundAchievements('assets/background/plant.png', 'Growing Strong',context,three,"You need to write diaries for 10 days to unlock it","You made it! You made a streak of 10 days"),
                roundAchievements('assets/background/star.png', 'Diary Talent',context,four,"You need to write diaries for 100 days to unlock it","You made it! You made a streak of 100 days"),
                roundAchievements('assets/background/superhero.png', 'MyDiary Hero',context,five,"Join Diary PRO to unlock it","Yeah! You are a premium user now"),
                roundAchievements('assets/background/security-guard.png', 'Data Guarder',context,six,"Backup your diary to unlock this","You have successfully backed up your data"),
                roundAchievements('assets/background/star (1).png', 'Secrets Keeper',context,seven,"Set a diary lock to protect your memories and unlock it","You have successfully added diary lock"),
              ],
            )
          ),
        ),
    );
  }

  Widget roundAchievementsMy(img,name,context,col) {
    return Column(children: <Widget>[
      SizedBox(height: 2,),
      Container(
          foregroundDecoration: col == true?BoxDecoration():BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.saturation,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(img,width: 30,),
          )
      ),
      SizedBox(height: 3,),
      Text(name,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06,color: Colors.black,fontWeight: FontWeight.w700),),
      SizedBox(height: 10,)
    ],);
  }

  achUnlock(img,tit,sub) async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(context: context, builder: (context) {
      return AlertDialog(
          title: roundAchievementsMy(img, tit,context,true),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22.0))),
          content: FadeAnimation(0.7, Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Flexible(child: Text(sub,style: TextStyle(fontSize: 12,color: Colors.black38),textAlign: TextAlign.center,))],))
      );
    });
  }
  Widget roundAchievements(img,name,context,col,sub1,sub2){
    return Column(children: <Widget>[
      SizedBox(height: 2,),
      GestureDetector(
        onTap: (){
          if(col==null){
            achUnlock(img, name,sub1);
          }else{
            achUnlock(img, name,sub2);
          }
        },
        child: Container(
            foregroundDecoration: col == true?BoxDecoration():BoxDecoration(
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(img,width: 30,),
            )
        ),
      ),
      SizedBox(height: 3,),
      Text(name,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.02,color: Colors.black),),
      SizedBox(height: 10,)
    ],);
  }
}
