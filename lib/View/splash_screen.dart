import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WorldStatesScreen()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(child: Image.asset('images/virus.png')),
                ),
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
            }),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            Align(
                alignment: Alignment.center,
                child: Text('Covid Tracker App',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.white),)),
          ],
        ),
      ),
    );
  }
}
