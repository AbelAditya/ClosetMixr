import 'package:closet/components/customTextField.dart';
import 'package:closet/model/ScreenSize.dart';
import 'package:closet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:closet/components/backButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pswd = TextEditingController();

  final _key = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

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
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Screensize.w(context) * 22),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Screensize.h(context) * 71,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Backbutton(),
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 33,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 80,
                      child: Text(
                        "Welcome back! Glad to see you, Again!",
                        style: GoogleFonts.urbanist(
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 57,
                    ),
                    CustomTextField(
                      cont: _email,
                      hint: "Enter your email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't leave field empty";
                        }
                        return null;
                      },
                      hasSuffix: false,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 15,
                    ),
                    CustomTextField(
                      cont: _pswd,
                      hint: "Enter your password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Can't leave field empty";
                        }
                        return null;
                      },
                      hasSuffix: true,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 90,
                    ),
                    !_isLoading
                        ? GestureDetector(
                            onTap: () async {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  UserCredential user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: _email.text,
                                          password: _pswd.text);
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text("Login Failed"),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                } catch (e) {
                                  print(e);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return;
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text("Login Successful"),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (Route<dynamic> route) => false);
                              } else
                                print("Login Invalid");
                            },
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
                          )
                        : Container(
                            height: Screensize.h(context) * 56,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(color: Colors.white,),
                          ),
                    SizedBox(
                      height: Screensize.h(context) * 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          width: Screensize.w(context) * 5,
                        ),
                        Text(
                          "Or Login with",
                          style: GoogleFonts.urbanist(color: Colors.white),
                        ),
                        SizedBox(
                          width: Screensize.w(context) * 5,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 38,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/facebook_ic.svg"),
                        SizedBox(
                          width: Screensize.w(context) * 20,
                        ),
                        SvgPicture.asset("assets/google_ic.svg"),
                        SizedBox(
                          width: Screensize.w(context) * 20,
                        ),
                        SvgPicture.asset("assets/cib_apple.svg"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
