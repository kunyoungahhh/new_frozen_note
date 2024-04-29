//here we show read books like apple pay card styles

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:new_frozen_note/models/book_model.dart';
import 'package:new_frozen_note/screens/search_result_screen.dart';
import 'package:new_frozen_note/widgets/book_widget.dart';

class SearchScreen extends StatefulWidget {
  // final String keyword;
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final myController = TextEditingController();
  // String keyword = "삼체";
  //아직 모르겟다..ㅠ
  bool isValueEntered = false;
  // late SharedPreferences prefs;
  // // late List<String> readBooks;
  // // final readBooks = ["8954442684", "8995132221"];
  // Future initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   // readBooks = prefs.getStringList('readBooks')!;
  //   // if (readBooks.isEmpty) {
  //   //   await prefs.setStringList('readBooks', []);
  //   // }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  // late Future<List<BookDetailModel>> books =
  //     AladinApiService.getBookListByIsbn(keyword);
  // late Future<List<BookModel>> books;

  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text(
              '책 검색',
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onSubmitted: (value) {
                      // Get.to(SearchResultScreen(keyword: myController.text));
                      setState(() {
                        isValueEntered = true;
                      });
                    },
                    controller: myController,
                    decoration: InputDecoration(
                      hintText: '  책 제목 또는 작가명을 검색해 보세요',
                      // prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Get.to(
                          //     SearchResultScreen(keyword: myController.text));
                          setState(() {
                            isValueEntered = true;
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     SizedBox(
          //       height: 400,
          //       child:
          SliverFillRemaining(
            child: Center(
              child: isValueEntered
                  ? SearchResultScreen(keyword: myController.text)
                  : const Text("꽁꽁 얼어붙은 노트 위로 고양이가 걸어갑니다."),
            ),
          ),
          //     ),
          //   ]),
          // ),
        ],
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
