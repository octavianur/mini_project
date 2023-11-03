import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/category.dart';
import 'package:mini_project/screens/spesific_search_screen.dart';

class CategoryItem extends StatefulWidget {
  final Category category;

  const CategoryItem(this.category, {Key? key}) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  double elevation = 18;

  void navigateToSpecificSearchScreen() {
    setState(() {
      elevation = 4;
    });

    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      setState(() {
        elevation = 18;
      });

      // Navigate to the specific search screen with category information
      Navigator.of(context)
          .pushNamed(SpesificSearchScreen.routeName, arguments: {
        'category': widget.category.categoryLink,
        'categoryTitle': widget.category.categoryTitle,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 26, bottom: MediaQuery.of(context).size.height * 0.09 * 1.3),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: elevation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(widget.category.iconLink),
                ),
                const SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    widget.category.categoryTitle.toString(),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Detect tap on the card and navigate to the specific search screen
        ),
        onTap: navigateToSpecificSearchScreen,
      ),
    );
  }
}
