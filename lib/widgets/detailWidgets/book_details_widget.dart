import 'package:flutter/material.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/widgets/detailWidgets/actions_widget.dart';
import 'package:mini_project/widgets/detailWidgets/authors_widget.dart';
import 'package:mini_project/widgets/detailWidgets/categories_widget.dart';
import 'package:mini_project/widgets/detailWidgets/description_widget.dart';
import 'package:mini_project/widgets/detailWidgets/metadata_widget.dart';
import 'package:mini_project/widgets/detailWidgets/title_widget.dart';

class BookDetailsWidget extends StatelessWidget {
  final Book book;

  const BookDetailsWidget(this.book, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoriesWidget(book),
        const SizedBox(height: 10,),
        AuthorWidget(book),
        const SizedBox(height: 10,),
        TitleWidget(book),
        const Divider(),
        DescriptionWidget(book),
        const SizedBox(height: 10,),
        const Divider(),
        const SizedBox(height: 10,),
        MetadataWidget(book),
        const SizedBox(height: 10,),
        const Divider(),
        ActionWidget(book),
        const SizedBox(height: 10,),
      ],
    );
  }
}
