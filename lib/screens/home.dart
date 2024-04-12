import 'package:closet/components/displayRow.dart';
import 'package:closet/components/profileElem.dart';
import 'package:closet/screens/images.dart';
import 'package:closet/screens/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:closet/model/ScreenSize.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _tshirt = [];
  List _jeans = [];
  List _jacket = [];
  List _shoes = [];

  Future<dynamic> fetchingData()async{
    var _db = FirebaseFirestore.instance; 
    QuerySnapshot snapshot1 = await _db.collection("user_clothes").doc(FirebaseAuth.instance.currentUser!.uid).collection("T-shirt").get();
    QuerySnapshot snapshot2 = await _db.collection("user_clothes").doc(FirebaseAuth.instance.currentUser!.uid).collection("Jacket").get();
    QuerySnapshot snapshot3 = await _db.collection("user_clothes").doc(FirebaseAuth.instance.currentUser!.uid).collection("Shoes").get();
    QuerySnapshot snapshot4 = await _db.collection("user_clothes").doc(FirebaseAuth.instance.currentUser!.uid).collection("Jeans").get();

    try{
      setState(() {
        _tshirt = snapshot1.docs.map((doc) => doc.data()).toList();
        _jeans = snapshot4.docs.map((doc) => doc.data()).toList();
        _jacket = snapshot2.docs.map((doc) => doc.data()).toList();
        _shoes = snapshot3.docs.map((doc) => doc.data()).toList();
      });

      print("Something: ${_jacket}");
      return true;
    }catch(e){
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: FutureBuilder(
        future: fetchingData(),
        builder: (context,snapshot)=> snapshot.hasData? Padding(
          padding: EdgeInsets.only(left: Screensize.w(context) * 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Screensize.h(context) * 51,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()));
                      },
                      child: ProfileElem(),
                    ),
                    SizedBox(
                      width: Screensize.w(context) * 12,
                    ),
                    Text(
                      "Hi, Anaria",
                      style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: Screensize.w(context) * 174,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageScreen(updateData: (category,url){
                          if (category == "Jacket"){
                            _jacket.add({"url":url});
                          }
                          else if (category == "T-Shirt"){
                            _tshirt.add({"url":url});
                          }
                          else if (category == "Jeans"){
                            _jeans.add({"url":url});
                          }
                          else if (category == "Shoes"){
                            _shoes.add({"url":url});
                          }
                        },)));
                      },
                      child: CircleAvatar(
                        radius: 17,
                        child: Center(child: Icon(Icons.add)),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screensize.h(context) * 10,
                ),
                SizedBox(
                    height: Screensize.h(context) * 170,
                    child: DisplayRow(title: "T-Shirts",data: _tshirt,)),
                SizedBox(
                  height: Screensize.h(context) * 10,
                ),
                SizedBox(
                    height: Screensize.h(context) * 170,
                    child: DisplayRow(title: "Jeans",data: _jeans,)),
                SizedBox(
                  height: Screensize.h(context) * 10,
                ),
                SizedBox(
                    height: Screensize.h(context) * 170,
                    child: DisplayRow(title: "Jacket",data: _jacket,)),
                SizedBox(
                  height: Screensize.h(context) * 10,
                ),
                SizedBox(
                    height: Screensize.h(context) * 170,
                    child: DisplayRow(title: "Shoes",data: _shoes,)),
                SizedBox(
                  height: Screensize.h(context) * 10,
                ),
              ],
            ),
          ),
        ): Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
