import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/providers/categories.dart';
import 'package:mini_project/widgets/categoriesWidgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context);

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 22, bottom: 8),
            child: Text(
              'Categories',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              // Handle the tap on the categories section if needed
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width * 0.95,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: categories.categoriesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 0,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, i) =>
                    CategoryItem(categories.categoriesList[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
