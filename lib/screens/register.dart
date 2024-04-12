import 'package:closet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:closet/components/customTextField.dart';
import 'package:closet/components/backButton.dart';
import 'package:closet/model/ScreenSize.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _pswd = TextEditingController();
  TextEditingController _conpswd = TextEditingController();

  final _key = GlobalKey<FormState>();

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
                        "Welcome to Closet Mixr!! Please Sign Up!",
                        style: GoogleFonts.urbanist(
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 56,
                    ),
                    CustomTextField(
                      cont: _username,
                      hint: "Username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter something";
                        }
                        return null;
                      },
                      hasSuffix: false,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 15,
                    ),
                    CustomTextField(
                      cont: _email,
                      hint: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter something";
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
                      hint: "Password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter something";
                        }
                        return null;
                      },
                      hasSuffix: true,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 15,
                    ),
                    CustomTextField(
                      cont: _conpswd,
                      hint: "Confirm password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter something";
                        } else if (_pswd.text != _conpswd.text)
                          return "passwords don't match";
                        else
                          return null;
                      },
                      hasSuffix: true,
                    ),
                    SizedBox(
                      height: Screensize.h(context) * 20,
                    ),
                    !_isLoading
                        ? GestureDetector(
                            onTap: () async {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  UserCredential user = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _pswd.text);
                                } on FirebaseException catch (e) {
                                  
                                  setState(() {
                                    _isLoading = false;
                                  });

                                  if (e.code == "email-already-in-use") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(
                                          child: Text(
                                              "This Email is already registered, please login"),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (e.code == "weak-password") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(
                                          child: Text("Your Password is Weak"),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  return;
                                }

                                setState(() {
                                  _isLoading = false;
                                });

                                final user = FirebaseAuth.instance.currentUser;
                                user!.updateDisplayName(_username.text);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text("Registration Successful!!"),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (Route<dynamic> route) => false);
                              } else {
                                print("Registration Invalid");
                              }
                            },
                            child: Container(
                              height: Screensize.h(context) * 56,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Register",
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
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
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
                      height: Screensize.h(context) * 37,
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
          )
        ],
      ),
    );
  }
}
