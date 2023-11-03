import 'package:flutter/material.dart';
import 'package:mini_project/models/category.dart';

class Categories with ChangeNotifier {
  List<Category> categoriesList = [
    Category(
        categoryTitle: 'Code',
        categoryLink: 'Code',
        iconLink: Icons.code),
    Category(
        categoryTitle: 'Art &\nLiterature',
        categoryLink: 'Art & Literature',
        iconLink: Icons.architecture),
    Category(
        categoryTitle: 'Cooking',
        categoryLink: 'cooking',
        iconLink: Icons.soup_kitchen),
    Category(
        categoryTitle: 'Education',
        categoryLink: 'education',
        iconLink: Icons.cast_for_education),

    Category(
        categoryTitle: 'Historical',
        categoryLink: 'historical',
        iconLink: Icons.history_edu),

    Category(
        categoryTitle: 'Humor',
        categoryLink: 'humor',
        iconLink: Icons.emoji_emotions),
    Category(
        categoryTitle: 'Religious',
        categoryLink: 'religious',
        iconLink: Icons.mosque),
    Category(
        categoryTitle: 'Sport',
        categoryLink: 'sport',
        iconLink: Icons.sports_basketball),

    Category(
        categoryTitle: 'Travel /\n Photography',
        categoryLink: 'travel and photography',
        iconLink: Icons.travel_explore),
  ];
}
