import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';
import 'package:mini_project/widgets/showcaseWidgets/showcase_bottom_sheet.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowcaseBookItem extends StatelessWidget {
  final Book book;

  ShowcaseBookItem(this.book, {Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showBottomSheet(
          elevation: 18,
          context: context,
          builder: (context) {
            return ShowCaseSearchBottomSheet(book);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: book.thumbnailUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Utils.trimString(book.singleAuthor.toString(), 15),
              textAlign: TextAlign.center,
              softWrap: true,
              style: authorTextStyle,
            ),
            Expanded(
              child: Text(
                Utils.trimString(book.title.toString(), 15),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: titleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final TextStyle authorTextStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.teal,
  );

  final TextStyle titleTextStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1,
  );
}
