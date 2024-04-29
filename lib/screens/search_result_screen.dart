import 'package:flutter/material.dart';
import 'package:new_frozen_note/models/book_model.dart';
import 'package:new_frozen_note/services/aladin_api.dart';
import 'package:new_frozen_note/widgets/book_widget.dart';

class SearchResultScreen extends StatelessWidget {
  final String keyword;

  SearchResultScreen({
    super.key,
    required this.keyword,
  });

//아직 모르겟다..ㅠ
  // final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  // final Future<List<BookModel>> books = AladinApiService.getSearchResults(keyword);
  late final Future<List<BookModel>> books =
      AladinApiService.getSearchResults(keyword);

  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    return Scaffold(
      body: FutureBuilder(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<BookModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        // print(index);
        var book = snapshot.data![index];
        return Book(
          title: book.title,
          author: book.author,
          pubDate: book.pubDate,
          cover: book.cover,
          isbn: book.isbn,
          readStat: book.readStat,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 32),
    );
  }
}
