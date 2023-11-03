import 'dart:convert';

import 'package:http/http.dart';
import 'package:mini_project/models/books.dart';
import 'package:mini_project/services/utils.dart';

class BookSearchUtils {
  static Future<Book> fetchBookById(String id) async{
    final url = "https://www.googleapis.com/books/v1/volumes/$id";


    Response response = await get(url as Uri);
    var bookMap = await jsonDecode(response.body);
    return Utils.bookFromJson(bookMap);
  }
  
}