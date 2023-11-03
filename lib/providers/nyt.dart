import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:mini_project/models/category.dart';

class NYT with ChangeNotifier {
  bool _loaded = false;
  List<Category> _categories = [];
  final String _selectedCategory = '';

  bool get isLoaded {
    return _loaded;
  }

  List<Category> get allCategories {
    return [..._categories];
  }

  String get selectedCategory {
    return _selectedCategory;
  }

  void setLoading(bool loadingState) {
    _loaded = loadingState;
    notifyListeners();
  }

  Future<List<Category>?> getCategoryList() async {
    // Memanggil API
    const apiKey = 'AIzaSyDVTH4z5GGiiCqdNFexrEPehVZRLoA4tgg'; 
    const url = "https://www.googleapis.com/svc/books/v2/list/names.json?api-key=$apiKey";

    try {
      final response = await https.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('results')) {
          final categoriesJsonList = jsonResponse['results'];

          final categories = categoriesJsonList
              .map((category) => Category(
                    categoryLink: category['list_name_encoded'],
                    categoryTitle: category['display_name'],
                  ))
              .toList();

          return categories;
        }
      }
    } catch (e) {
      // Handle the exception as needed
      print('Error fetching categories: $e');
    }

    return null;
  }
}
