import 'package:flutter/material.dart';

class Category {
  final String? categoryTitle;
  final String? categoryLink;
  final IconData? iconLink;
  final String? oldDate;
  final String? newDate;
  final String? updated;

  Category(
      {this.categoryTitle,
      this.categoryLink,
      this.iconLink,
      this.oldDate,
      this.newDate,
      this.updated});
}
