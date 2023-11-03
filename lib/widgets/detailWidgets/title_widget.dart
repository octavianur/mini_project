import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

class TitleWidget extends StatelessWidget {
  final Book book;

   TitleWidget(this.book, {Key?key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FittedBox(
            child: Text(
              Utils.trimString(book.title.toString(), 50),
              textAlign: TextAlign.center,
              style: titleTextStyle,
            ),
          ),
          if (book.subtitle != null)
            Text(
              Utils.trimString(book.subtitle.toString(), 40),
              textAlign: TextAlign.center,
              style: subtitleTextStyle,
            )
        ],
      ),
    );
  }

  final TextStyle titleTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  final TextStyle subtitleTextStyle = GoogleFonts.montserrat(
    fontSize: 12,
  );
}
