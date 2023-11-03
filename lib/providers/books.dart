import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

enum PaginatorCall {
  byTitle,
  byArgs,
}

class Books extends ChangeNotifier {
  List<Book> _searchedBooksList = [];
  final _singleLoadBookCount = 18;
  int startIndex = 0;
  String _searchedString = '';
  Map? _searchedArgs = {};
  late int totalItems;
  bool _isLoading = false;
  bool _reachedEnd = false;
  bool _firstLoad = true;
  late bool _byTitleNotAuthor;
  late bool _free;
  late PaginatorCall calledBy;
  void setLoading(bool loadingState) {
    _isLoading = loadingState;
    notifyListeners();
  }

  bool get firstLoad {
    return _firstLoad;
  }

  void toggleTotalItemsCalculation(bool toggle) {
    _firstLoad = toggle;
  }

  List<Book> get getBooksList {
    return [..._searchedBooksList];
  }

  bool get isLoading {
    return _isLoading;
  }

  int get totalBookCount {
    return totalItems;
  }

  void setStartIndex() {
    startIndex = 0;
  }

  bool get reachedEnd {
    return _reachedEnd;
  }

  void setFirstLoad(bool value) {
    _firstLoad = value;
    notifyListeners();
  }

  bool _spesificScreenLoadingState = false;
  void setSpesificScreenLoadingState(bool value) {
    _spesificScreenLoadingState = value;
    notifyListeners();
  }

  bool get spesificScreenLoadingState => _spesificScreenLoadingState;

  Future<void> getSearchedBookData(
      String searchedString, bool byTitleNotAuthor, bool free) async {
    calledBy = PaginatorCall.byTitle;
    _byTitleNotAuthor = byTitleNotAuthor;
    _free = free;
    _searchedBooksList.clear();
    _searchedString = searchedString;

    String baseUrl = "https://www.googleapis.com/books/b1/volumes?";
    String query = byTitleNotAuthor ? 'intitle' : 'inauthor';

    String fullUrl = !_free
        ? "$baseUrl$query=$searchedString&maxResults=$_singleLoadBookCount&startIndex=$startIndex"
        : "$baseUrl$query=$searchedString&filter=free-ebooks&maxResults=$_singleLoadBookCount&startIndex=$startIndex";

    Uri uri = Uri.parse(fullUrl);

    try {
      _reachedEnd = false;
      setLoading(true);
      https.Response response = await https.get(Uri.parse(uri as String));
      setLoading(false);
      var jsonResponse = await jsonDecode(response.body);
      if (_firstLoad != null) {
        totalItems = jsonResponse['totalItems'];
        setFirstLoad(false);
      }

      List searchedBooksJson = jsonResponse['items'];
      if (searchedBooksJson == null) {
        _reachedEnd = true;
        return;
      }
      List<Book> searchedBooks = [];
      for (var book in searchedBooksJson) {
        searchedBooks.add(Utils.bookFromJson(book));
      }
      _searchedBooksList = searchedBooks;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSearchedBookByArgs(Map searchedArgs) async {
    calledBy = PaginatorCall.byArgs;
    _searchedArgs = searchedArgs;
    _searchedBooksList.clear();
    String? url;
    if (searchedArgs.containsKey('bookTitle') &&
        searchedArgs.containsKey('bookAuthor')) {
      url =
          'https://www.googleapis.com/books/v1/volumes?q=intitle:${searchedArgs['bookTitle']}+inauthor:${searchedArgs['bookAuthor']}&orderBy=newest&maxResults=$_singleLoadBookCount$startIndex=$startIndex';
    }
    if (searchedArgs.containsKey('category')) {
      url =
          'https://www.googleapis.com/books/v1/volumes?q=subject:${searchedArgs['category']}&orderBy=newest&maxResults=$_singleLoadBookCount$startIndex=$startIndex';
    }
    try {
      _reachedEnd = false;
      https.Response response = await https.get(Uri.parse(url!));
      var jsonResponse = await jsonDecode(response.body);
      setSpesificScreenLoadingState(false);
      if (_firstLoad) totalItems = jsonResponse['totalItems'];

      List searchedBooksJson = jsonResponse['items'];
      // ignore: unnecessary_null_comparison
      if (searchedBooksJson == null) {
        _reachedEnd = true;
        return;
      }

      List<Book> searchedBooks = [];
      for (var book in searchedBooksJson) {
        searchedBooks.add(Utils.bookFromJson(book));
      }
      _searchedBooksList = searchedBooks;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void paginate(bool foreword) {
    foreword
        ? startIndex += _singleLoadBookCount
        : startIndex >= _singleLoadBookCount
            ? startIndex -= _singleLoadBookCount
            : startIndex = _singleLoadBookCount;
    calledBy == PaginatorCall.byTitle
        ? getSearchedBookData(_searchedString, _byTitleNotAuthor, _free)
        : getSearchedBookByArgs(_searchedArgs!);
  }

  Book getBookById(String id) {
    return _searchedBooksList.firstWhere((element) => (element.id == id));
  }

  void clearList() {
    _searchedBooksList.clear();
    notifyListeners();
  }
}
