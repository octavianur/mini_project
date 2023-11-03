import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';
import 'package:mini_project/widgets/action_button_widget.dart';

class ActionWidget extends StatelessWidget {
  final Book book;

  const ActionWidget(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String availability;
    IconData icon;

    // Determine book availability and set corresponding icon and label
    if (book.accessViewStatus == 'SAMPLE') {
      availability = 'SAMPLE';
      icon = Icons.description;
    } else if (book.accessViewStatus == 'FULL_PUBLIC_DOMAIN') {
      availability = 'READ';
      icon = Icons.book;
    } else {
      availability = 'PAID';
      icon = Icons.attach_money;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.chrome_reader_mode,
          label: "Preview",
          onPressed: () async {
            await Utils.launchURL(book.previewLink.toString());
          },
        ),
        const SizedBox(
          width: 5,
        ),
        ActionButton(
          icon: Icons.shop,
          label: book.saleability != 'FOR_SALE'
              ? 'N/A'
              : '${book.amount} ${book.currencyCode}',
          onPressed: book.saleability != 'FOR_SALE' ? null : () async {
            await Utils.launchURL(book.buyLink.toString());
          },
        ),
        const SizedBox(
          width: 5,
        ),
        ActionButton(
          icon: icon,
          label: availability,
          onPressed: book.saleability != 'FOR_SALE' &&
                  book.accessViewStatus != 'SAMPLE'
              ? null
              : () async {
                  await Utils.launchURL(book.webReaderLink.toString());
                },
        ),
      ],
    );
  }
}
