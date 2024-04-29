import 'package:new_frozen_note/models/book_detail_model.dart';

class BookDBModel {
  final BookDetailModel book;
  final String isbn;
  final double rating;
  final String comment;
  final String status;

  BookDBModel({
    required this.book,
    required this.isbn,
    required this.rating,
    required this.comment,
    required this.status,
  });
}
