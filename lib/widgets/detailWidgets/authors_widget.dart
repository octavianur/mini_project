import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

class AuthorWidget extends StatelessWidget {
  final Book book;

  const AuthorWidget(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Utils.listToString(book.authors!.toList(), '   '),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 12,
        ),
        softWrap: true,
      ),
    );
  }
}
