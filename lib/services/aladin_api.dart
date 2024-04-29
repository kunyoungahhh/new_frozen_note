import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;
import 'package:new_frozen_note/models/book_detail_model.dart';
import 'package:new_frozen_note/models/book_model.dart';

class AladinApiService {
  static String baseUrl =
      "https://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbjky9610011425001&output=js&MaxResults=50&Version=20131101&Query=";
  static String isbnUrl =
      "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbjky9610011425001&itemIdType=ISBN&output=js&Version=20131101&ItemId=";
  static const String keyword = "천선란"; //test keyword

  // static Future<List<WebtoonModel>> getTodaysToons() async {
  //   List<WebtoonModel> webtoonInstances = [];
  //   final url = Uri.parse('$baseUrl/$today');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> webtoons = jsonDecode(response.body);
  //     for (var webtoon in webtoons) {
  //       webtoonInstances.add(WebtoonModel.fromJson(webtoon));
  //       // final toon = WebtoonModel.fromJson(webtoon);
  //       // print(toon.title);
  //     }
  //     return webtoonInstances;
  //   }
  //   throw Error();
  // }
  static Future<BookDetailModel> getBookByIsbn(String isbn) async {
    final url = Uri.parse("$isbnUrl$isbn");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final book = jsonDecode(response.body);
      return BookDetailModel.fromJson(book);
    }
    throw Error();
  }

  static Future<List<BookDetailModel>> getBookListByIsbn(List isbns) async {
    List<BookDetailModel> bookDetailInstances = [];

    for (var book in isbns) {
      final url = Uri.parse("$baseUrl$book");
      final response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        final queryResult = jsonDecode(response.body);
        final bookDetail = queryResult;
        bookDetailInstances.add(BookDetailModel.fromJson(bookDetail));
      } else {
        throw Error();
      }
    }
    // print(bookDetailInstances);
    return bookDetailInstances;
  }

  static Future<List<BookModel>> getSearchResults(String keyword) async {
    List<BookModel> bookInstances = [];

    final url = Uri.parse("$baseUrl$keyword");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final queryResult = jsonDecode(response.body);
      // print(queryResult);
      try {
        final books = queryResult["item"];
        for (var book in books) {
          bookInstances.add(BookModel.fromJson(book));
        }
      } catch (e) {
        print("Empty Query!: $e");
      }

      return bookInstances;
    }
    throw Error();
  }
}
