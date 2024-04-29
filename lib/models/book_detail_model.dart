class BookDetailModel {
  final String title, author, pubDate, cover, description, isbn, readStat;

  BookDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['item'][0]['title'],
        author = json['item'][0]['author'],
        pubDate = json['item'][0]['pubDate'],
        cover = json['item'][0]['cover'],
        description = json['item'][0]['description'],
        isbn = json['item'][0]['isbn'],
        readStat = "NOTSET";
  //this is called named constructor
}
