import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:new_frozen_note/models/book_detail_model.dart';
import 'package:new_frozen_note/services/aladin_api.dart';

class DataBaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static String isbnUrl =
      "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=ttbjky9610011425001&itemIdType=ISBN&output=js&Version=20131101&ItemId=";

  Future<List<String>> getUsersReadBookList(String uid) async {
    DocumentSnapshot curUserData =
        await fireStore.collection("UserData").doc(uid).get();
    var mappedData = curUserData.data() as Map;
    var readBooks = mappedData["readBooks"];
    List<String> returningList = [];
    if (readBooks != null) {
      for (var isbn in readBooks.keys) {
        returningList.add(isbn);
      }
    }
    return returningList;
  }

  Future<List<String>> getUsersReadingBookList(String uid) async {
    DocumentSnapshot curUserData =
        await fireStore.collection("UserData").doc(uid).get();
    var mappedData = curUserData.data() as Map;
    var readingBooks = mappedData["readingBooks"];
    List<String> returningList = [];
    if (readingBooks != null) {
      for (var isbn in readingBooks.keys) {
        returningList.add(isbn);
      }
    }
    return returningList;
  }

  Future<List<String>> getUsersWantToReadBookList(String uid) async {
    DocumentSnapshot curUserData =
        await fireStore.collection("UserData").doc(uid).get();
    var mappedData = curUserData.data() as Map;
    var wantToRead = mappedData["wantToRead"];
    List<String> returningList = [];
    if (wantToRead != null) {
      for (var isbn in wantToRead.keys) {
        returningList.add(isbn);
      }
    }
    return returningList;
  }

  Future<List<BookDetailModel>> getUsersReadBookModels(String uid) async {
    var readISBNs = await getUsersReadBookList(uid);
    // var readingISBNs = await getUsersReadingBookList(uid);
    // var wantToReadISBNs = await getUsersWantToReadBookList(uid);

    List<BookDetailModel> bookInstances = [];
    for (var isbn in readISBNs) {
      var tempModel = await AladinApiService.getBookByIsbn(isbn);
      bookInstances.add(tempModel);
    }
    return bookInstances;
  }

  Future<List<BookDetailModel>> getUsersReadingBookModels(String uid) async {
    var readingISBNs = await getUsersReadingBookList(uid);
    // var readingISBNs = await getUsersReadingBookList(uid);
    // var wantToReadISBNs = await getUsersWantToReadBookList(uid);

    List<BookDetailModel> bookInstances = [];
    for (var isbn in readingISBNs) {
      var tempModel = await AladinApiService.getBookByIsbn(isbn);
      bookInstances.add(tempModel);
    }
    return bookInstances;
  }

  Future<List<BookDetailModel>> getUsersWantToReadBookModels(String uid) async {
    var wantToReadISBNs = await getUsersWantToReadBookList(uid);
    // var readingISBNs = await getUsersReadingBookList(uid);
    // var wantToReadISBNs = await getUsersWantToReadBookList(uid);

    List<BookDetailModel> bookInstances = [];
    for (var isbn in wantToReadISBNs) {
      var tempModel = await AladinApiService.getBookByIsbn(isbn);
      bookInstances.add(tempModel);
    }
    return bookInstances;
  }

  // Future<List<BookDBModel>> getTestBookReadDBModels(String uid) async {
  //   var wantToReadISBNs = await getUsersWantToReadBookList(uid);
  //   // var readingISBNs = await getUsersReadingBookList(uid);
  //   // var wantToReadISBNs = await getUsersWantToReadBookList(uid);

  //   List<BookDBModel> bookInstances = [];
  //   for (var isbn in wantToReadISBNs) {
  //     var tempModel = await AladinApiService.getBookByIsbn(isbn);
  //     bookInstances.add(tempModel);
  //   }
  //   return bookInstances;
  // }

  // Future<BookDBModel> getBookDBBModelyIsbn(String isbn, String savedStatus) async {
  //   FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   final url = Uri.parse("$isbnUrl$isbn");
  //   final response = await http.get(url);
  //   final db = await fireStore.collection("UserData").doc(auth.currentUser!.uid).get();

  //   if (response.statusCode == 200) {
  //     final book = jsonDecode(response.body);
  //     var bookDetail = BookDetailModel.fromJson(book);
  //     var bookRatingComment = db.data();
  //     var isbn = bookDetail.isbn;
  //     var rating = bookRatingComment[savedStatus][isbn]["rating"];
  //     var comment = bookRatingComment[savedStatus][isbn]["comment"];
  //     var status = savedStatus;

  //     return BookDBModel(book: BookDetailModel.fromJson(book), isbn: BookDetailModel.fromJson(book).isbn, rating: rating, comment: comment, status: status);
  //   }
  //   throw Error();
  // }
//   var userBookList = <dynamic>{};

//   dynamic getLeafNodes(input) async {
//     //BASE CONDITION
//     if (input is List) {
//       userBookList.add(input);
//     }
//     //recursive condition
//     else if (input is Map) {
//       for (var child in input.keys) {
//         getLeafNodes(input[child]);
//       }
//     }
//     // initial = false;
//     return userBookList.toList();
//   }
}


// " {
//readBooks: {
//  8954442684: {
//    rating: 4.5, comment: so touching , status: testtest
//              }
//  }, 
//readingBooks: {K882632470: {rating: 0, comment: reading, status: reading}}, wantToRead: }"
