import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/code.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Material(
                  elevation: 18,
                  color: Colors.transparent,
                  child: Text(
                    "book\njungle",
                    textAlign: TextAlign.start,
                    style: appTitleTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextStyle appTitleTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      height: 0.9,
      fontSize: 36,
    ),
  );
}
