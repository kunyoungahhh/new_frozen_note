//here we show read books like apple pay card styles

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_frozen_note/models/book_db_model.dart';
import 'package:new_frozen_note/models/book_detail_model.dart';
import 'package:new_frozen_note/services/database_service.dart';
import 'package:new_frozen_note/widgets/book_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required User user}) : _user = user;

  final User _user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final curUid = "v9dIFSD2Y5SY6cL3u475keKVRNj1";
  late User _user;
  bool isPrefLoaded = false;

  // var _tabController =
  // DefaultTabController(
  //   length: 3,
  //   child: Scaffold(appBar: AppBar(bottom: TabBar(tabs: [Tab(icon: Icon(Icons.check_box,)), Tab(icon: Icon(Icons.sync,)), Tab(icon: Icon(Icons.stars,)),]),)),
  // )

  // late final Future<List<BookDetailModel>> books
  // late final Future<BookDBModel> bookDB;

  @override
  void initState() {
    // print("prefs set");
    _user = widget._user;
    super.initState();

    // initPrefs();

    // books = isPrefLoaded
    //     ? AladinApiService.getBookListByIsbn(readBooksIsbnList)
    //     : AladinApiService.getBookListByIsbn([]);
  }

  @override
  Widget build(BuildContext context) {
    // print(webtoons);
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    late final Future<List<BookDetailModel>> readBooks =
        DataBaseService().getUsersReadBookModels(_user.uid);
    late final Future<List<BookDetailModel>> readingBooks =
        DataBaseService().getUsersReadingBookModels(_user.uid);
    late final Future<List<BookDetailModel>> wantToReadBooks =
        DataBaseService().getUsersWantToReadBookModels(_user.uid);

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: true,
                title: const Text('꽁꽁노트'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.sync),
                    onPressed: () async {
                      print("hello button pressed!!");
                      // print(_user);
                      // print("users uid is: ${_user.uid}");

                      DocumentSnapshot curUserData = await fireStore
                          .collection("UserData")
                          .doc(_user.uid)
                          .get();
                      print(curUserData.data());
                      var datatest = curUserData.data() as Map;
                      print(datatest["readBooks"]);
                      setState(() {
                        print(_user);
                      });
                    },
                  ),
                ],
                bottom: const TabBar(
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                      text: "읽은 책",
                    ),
                    Tab(
                      text: "읽는 중",
                    ),
                    Tab(
                      text: "읽고 싶은 책",
                    ),
                  ],
                ),
                // bottom: ,
              ),
            ];
          },
          body:

              // Other Sliver Widgets
              // SliverList(
              //   delegate: SliverChildListDelegate([
              //     SizedBox(
              //       height: 400,
              //       child:
              // SliverFillRemaining(
              //   child: DefaultTabController(
              //     length: 3,
              //     child: Scaffold(
              //       appBar: AppBar(
              //         bottom: const TabBar(
              //           indicatorWeight: 4,
              //           tabs: [
              //             Tab(
              //               text: "읽은 책",
              //             ),
              //             Tab(
              //               text: "읽는 중",
              //             ),
              //             Tab(
              //               text: "읽고 싶은 책",
              //             ),
              //           ],
              //         ),
              //       ),
              TabBarView(
            children: [
              FutureBuilder(
                future: readBooks,
                builder: (context, snapshot1) {
                  print("inside read builder");

                  // if (isPrefLoaded) {
                  if (snapshot1.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: makeReadList(snapshot1),
                        )
                      ],
                    );
                  }
                  // }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: readingBooks,
                builder: (context, snapshot2) {
                  print("inside reading builder");

                  // if (isPrefLoaded) {
                  if (snapshot2.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: makeReadingList(snapshot2),
                        )
                      ],
                    );
                  }
                  // }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: wantToReadBooks,
                builder: (context, snapshot3) {
                  print("inside wannaread builder");

                  // if (isPrefLoaded) {
                  if (snapshot3.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: makeWantToReadList(snapshot3),
                        )
                      ],
                    );
                  }
                  // }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      //     Center(
      //   child: Text("Hello This is Home"),
      // ),
    );
    //     ),
    //   ]),
    // ),
    //       ],
    //     ),
    //   ),
    // );
  }

  ListView makeReadList(AsyncSnapshot<List<BookDetailModel>> snapshot) {
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
          readStat: "READ",
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 32),
    );
  }

  ListView makeReadingList(AsyncSnapshot<List<BookDetailModel>> snapshot) {
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
          readStat: "READING",
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 32),
    );
  }

  ListView makeWantToReadList(AsyncSnapshot<List<BookDetailModel>> snapshot) {
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
          readStat: "WANTTOREAD",
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 32),
    );
  }

  ListView testMakeList(AsyncSnapshot<List<BookDBModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        // print(index);
        var book = snapshot.data![index];
        return Book(
          title: book.book.title,
          author: book.book.author,
          pubDate: book.book.pubDate,
          cover: book.book.cover,
          isbn: book.isbn,
          readStat: book.status,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 32),
    );
  }
  // Future<List<BookDetailModel>> fetchUserBookList() async {

  //   return;
  // }
}
