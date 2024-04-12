import 'package:closet/model/ScreenSize.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayRow extends StatefulWidget {
  final title;
  final data;

  DisplayRow({required this.title,required this.data});

  @override
  State<DisplayRow> createState() => _DisplayRowState();
}

class _DisplayRowState extends State<DisplayRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style: GoogleFonts.publicSans(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w700)),),
        SizedBox(
          height: Screensize.h(context) * 8,
        ),
        widget.data.length!=0? Expanded(
          child: ListView.builder(
            itemCount: widget.data.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>Row(
              children: [
                Container(
                  width: Screensize.w(context)*137,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Image.network(widget.data[index]["url"]),
                ),
                SizedBox(width: Screensize.w(context)*20,)
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
        ):Expanded(
          child: Container(
            width: Screensize.w(context)*137,
            height: Screensize.h(context)*70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Text("Add Items"),
          ),
        ),
      ],
    );
  }
}
