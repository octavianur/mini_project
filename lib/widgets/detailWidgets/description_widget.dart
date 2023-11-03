import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:mini_project/models/books.dart';

class DescriptionWidget extends StatelessWidget {
  final Book book;

  DescriptionWidget(this.book, {Key? key});

  String _parseHtmlString(String htmlString) {
    if (htmlString == null || htmlString.isEmpty) {
      return 'Description not available';
    }

    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.grey),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DESCRIPTION',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Text(
                    _parseHtmlString(book.description.toString()),
                    style: descriptionTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextStyle descriptionTextStyle = GoogleFonts.montserrat(
    fontSize: 14,
    letterSpacing: 0.2,
  );
}
