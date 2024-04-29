class BookModel {
  final String title, author, pubDate, cover, isbn, readStat;

  BookModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        pubDate = json['pubDate'],
        cover = json['cover'],
        isbn = json['isbn'],
        readStat = "NOTSET";
  //this is called named constructor
}
