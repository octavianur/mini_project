import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/book_search_utils.dart';

class BookDetailsScreen extends StatefulWidget {
  final String bookId;

  const BookDetailsScreen(Book book, {required this.bookId, Key? key}) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Future<Book> book;

  @override
  void initState() {
    super.initState();
    book = BookSearchUtils.fetchBookById(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: FutureBuilder<Book>(
        future: book,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final Book book = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${book.title}'),
                  Text('Author: ${book.authors}'),
                  // Add more book details here
                ],
              ),
            );
          } else {
            return Text('No book data available.');
          }
        },
      ),
    );
  }
}
