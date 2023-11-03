import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/providers/bookshelf.dart';
import 'package:mini_project/services/utils.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatelessWidget {
  final String bookId;
  final Book book;

  Bookmark({
    Key? key,
    required this.bookId,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<Bookshelf>(context).isBookmarked(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for the result.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error case.
          return Text('Error: ${snapshot.error}');
        } else {
          // The asynchronous operation is complete.
          final isBookmarked = snapshot.data;
          return IconButton(
            onPressed: () {
              if (isBookmarked == true) {
                Provider.of<Bookshelf>(context, listen: false)
                    .removeSavedBook(bookId);
              } else {
                Provider.of<Bookshelf>(context, listen: false).addToBookshelf(
                  bookId.toString(),
                  book.title.toString(),
                  book.thumbnailUrl.toString(),
                  Utils.listToString(book.authors!.toList(), '   '),
                );
              }
            },
            icon: Icon(
              isBookmarked == true
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.black,
            ),
            iconSize: 32,
          );
        }
      },
    );
  }
}
