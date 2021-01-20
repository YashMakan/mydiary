import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer/theme.dart';
import 'homescreen.dart';
import 'pin_page.dart';
class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    wait();
    _controller = AnimationController(vsync: this);
  }
  getPos()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var v=prefs.getString('first');
    if(v==null){
      prefs.setInt('first_day', 1);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThemePage()),
      );
    }else{
      var n=prefs.getString("pass");
        if(n!=null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PinPage(title: "Enter Password to unlock the Diary",pass: true, password:n)),
          );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    }
  }
  wait()async{
    await new Future.delayed(const Duration(seconds : 5));
    getPos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/background/book.json',
            controller: _controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
    );
  }
}