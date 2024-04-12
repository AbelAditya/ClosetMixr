import "package:closet/screens/home.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:closet/screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key,required this.route});
  final route;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget.route? Home():WelcomeScreen(),
          transitionDuration: const Duration(milliseconds: 1500),
        ),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFDFAAFF), Color(0xFF311E3C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                    image: AssetImage("assets/img_splash_screen.png"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: Hero(
              tag: "Intro",
              child: Material(
                color: Colors.transparent,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Closet Mixr\n",
                        style: GoogleFonts.marcellus(
                          textStyle: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "closet organisation app",
                        style: GoogleFonts.marcellus(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [Color(0xFFDFAAFF),Color(0xFF311E3C)],
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //     )
    //     child
    //   ),
    // );
  }
}
