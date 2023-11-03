import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/screens/spesific_search_screen.dart';
import 'package:mini_project/services/utils.dart';

class ShowCaseSearchBottomSheet extends StatelessWidget {
  final Book book;

  ShowCaseSearchBottomSheet(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    '${book.rank}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SpesificSearchScreen.routeName,
                        arguments: {
                          'bookTitle': book.title,
                          'bookAuthor': book.singleAuthor,
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.thumbnailUrl ?? '', // Use a default image or handle null
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.singleAuthor ?? 'Author Not Available', // Handle null author
                      style: bookAuthorTextStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      book.title ?? 'Title Not Available', // Handle null title
                      style: bookTitleTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            "DESCRIPTION",
            style: descriptionTitleTextStyle,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                book.description?.isNotEmpty == true
                    ? book.description!
                    : 'NOT AVAILABLE',
                style: bookDescriptionTextStyle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Publisher:',
                softWrap: true,
                style: TextStyle(color: Colors.teal),
              ),
              Expanded(
                child: Text(
                  Utils.trimString(book.publisher ?? '', 35), // Handle null publisher
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Utils.launchURL(book.buyLink ?? '');
                },
                child: ImageIcon(
                  AssetImage("assets/images/amazonicon.png"),
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SpesificSearchScreen.routeName, arguments: {
                    'bookTitle': book.title,
                    'bookAuthor': book.singleAuthor,
                  });
                },
                child: const Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final TextStyle bookAuthorTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  final TextStyle bookTitleTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
  );

  final TextStyle descriptionTitleTextStyle = TextStyle(
    color: Colors.teal,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  final TextStyle bookDescriptionTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontSize: 14,
      letterSpacing: 0.2,
    ),
  );
}
