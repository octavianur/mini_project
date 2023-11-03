import 'package:flutter/material.dart';
import 'package:mini_project/models/savedBook.dart';
import 'package:mini_project/services/db_helper.dart';

class Bookshelf with ChangeNotifier {
  late List<SavedBook> _savedBooks = [];

  List<SavedBook> get savedBooks {
    return _savedBooks;
  }

  void addToBookshelf(
      String bookId, String bookTitle, String bookImageUrl, String authors) {
    final bookToSave = SavedBook(
      id: bookId,
      title: bookTitle,
      imageUrl: bookImageUrl,
      authors: authors,
    );
    _savedBooks.add(bookToSave);
    notifyListeners();

    DBHelper.insert('bookshelf', {
      'bookId': bookToSave.id.toString(),
      'bookTitle': bookToSave.title.toString(),
      'authors': bookToSave.authors.toString(),
      'bookImageUrl': bookToSave.imageUrl.toString(),
    });
  }

  Future<void> fetchAndSetBooks() async {
    await DBHelper.database();
    final savedBookList = await DBHelper.getData('bookshelf');
    _savedBooks = savedBookList
        .map((item) => SavedBook(
              id: item['bookId'],
              title: item['bookTitle'],
              authors: item['authors'],
              imageUrl: item['bookImageUrl'],
            ))
        .toList();
  }

  Future<void> removeSavedBook(String id) async {
    await DBHelper.deleteBook(id);
    fetchAndSetBooks();
  }

  Future<bool> checkExistingBook(String id) async {
    return await DBHelper.findBook(id);
  }

  Future<bool> isBookmarked(String bookId) async {
    return await DBHelper.findBook(bookId);
  }
}
