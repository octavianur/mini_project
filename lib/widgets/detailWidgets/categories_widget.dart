import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

class CategoriesWidget extends StatelessWidget {
  final Book book;

  const CategoriesWidget(this.book, {Key? key});

  @override
  Widget build(BuildContext context) {
    if (book.categories == null || book.categories!.isEmpty) {
      return Container();
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(3),
        child: Text(
          Utils.trimString(
            Utils.listToString(book.categories!.toList(), '   '),
            40,
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xff50AE90),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
