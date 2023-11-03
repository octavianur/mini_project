import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

class MetadataWidget extends StatelessWidget {
  final Book book;

  const MetadataWidget(this.book, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Publisher', style: labelTextStyle),
              Text(
                Utils.trimString(book.publisher.toString(), 20),
                textAlign: TextAlign.center,
                style: valueTextStyle,
                softWrap: true,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pages', style: labelTextStyle),
              Text(
                book.pageCount == null ? '---' : book.pageCount.toString(),
                style: valueTextStyle,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Rating', style: labelTextStyle),
              Text(
                book.averageRating.toString(),
                textAlign: TextAlign.center,
                style: valueTextStyle,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Published', style: labelTextStyle),
              Text(
                book.publishedDate.toString(),
                textAlign: TextAlign.center,
                style: valueTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  final TextStyle labelTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.teal,
  );

  final TextStyle valueTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
}
