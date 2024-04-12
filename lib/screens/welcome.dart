import 'package:closet/model/ScreenSize.dart';
import 'package:closet/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:closet/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Screensize.w(context)*22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
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
                SizedBox(
                  height: Screensize.h(context) * 238,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  ),
                  child: Container(
                    height: Screensize.h(context) * 56,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Screensize.h(context) * 15,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>Register())),
                  child: Container(
                    height: Screensize.h(context) * 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Register",
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
