import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raspisanie2/screens/raspscreens.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 4600), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  Widget _anumtext_widget_center(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 21.0,
            fontFamily: 'Agne',
            color: Color.fromRGBO(76, 76, 76, 1),
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Добро пожаловать',
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 200)),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ),
    );
  }

  Widget _anumtext_widget_bottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height % 2 + 230,
      ),
      child: SizedBox(
        width: 100.0,
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 15.0,
            fontFamily: 'Agne',
            color: Color.fromRGBO(76, 76, 76, 1),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('@efedotov',
                    textAlign: TextAlign.center,
                    speed: const Duration(milliseconds: 200)),
              ],
              totalRepeatCount: 1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _anumtext_widget_center(context),
              _anumtext_widget_bottom(context),
            ],
          ),
        ],
      ),
    );
  }
}
