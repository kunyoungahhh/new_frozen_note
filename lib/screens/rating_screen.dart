import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:new_frozen_note/models/book_detail_model.dart';
import 'package:new_frozen_note/services/aladin_api.dart';

class RatingScreen extends StatefulWidget {
  final String title, author, pubDate, cover, isbn, readStat;

  const RatingScreen({
    super.key,
    required this.title,
    required this.author,
    required this.pubDate,
    required this.cover,
    required this.isbn,
    required this.readStat,
  });
  // required dynamic userData,
  // }) : _user = userData;

  // final User _user;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late Future<BookDetailModel> book;
  FirebaseAuth auth = FirebaseAuth.instance;

  late User _user;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  // late SharedPreferences prefs;
  bool isRead = false;
  double currentRating = 0;
  String currentComment = "감상평을 남겨라";
  bool ratingFetched = false;
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    book = AladinApiService.getBookByIsbn(widget.isbn);
    _user = auth.currentUser!;
    initInfoFetch();
    // onStarTap();
  }

  // onButtonTap() async {
  //   // final url = Uri.parse("https://google.com");
  //   await launchUrlString("https://google.com");
  // }
  // onHeartTap() async {
  //   final readBooks = prefs.getStringList('readBooks');
  //   if (readBooks != null) {
  //     if (isRead) {
  //       readBooks.remove(widget.isbn);
  //     } else {
  //       readBooks.add(widget.isbn);
  //     }
  //     await prefs.setStringList('readBooks', readBooks);
  //     setState(() {
  //       isRead = !isRead;
  //     });
  //   }
  // }
  initInfoFetch() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    var curUserData =
        await fireStore.collection("UserData").doc(_user.uid).get();
    if (curUserData.data() != null) {
      var userBookData = curUserData.data() as Map;
      var status = "NOTSET";
      if (widget.readStat == "READ") {
        status = "readBooks";
      } else if (widget.readStat == "READING") {
        status = "readingBooks";
      } else if (widget.readStat == "WANTTOREAD") {
        status = "wantToRead";
      }
      if (status != "NOTSET") {
        print(
            "status for ${widget.isbn} is : $status and the data is $userBookData");
        var tempReadBookRC = userBookData[status];
        var existingRating = tempReadBookRC[widget.isbn]["rating"];
        // currentRating = double.parse(existingRating);
        currentRating = existingRating;
        var existingComment = tempReadBookRC[widget.isbn]["comment"];
        currentComment = existingComment;
      } else {
        currentComment = "노트를 남겨보세요";
        currentRating = 0;
      }
      setState(() {
        ratingFetched = true;
      });
    }
  }

  onStarTap({double rating = 0, String comment = "No Comment"}) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    var curUserData =
        await fireStore.collection("UserData").doc(_user.uid).get();
    if (curUserData.data() != null) {
      var userBookData = curUserData.data() as Map;
      var status = "NOTSET";
      if (widget.readStat == "READ") {
        status = "readBooks";
      } else if (widget.readStat == "READING") {
        status = "readingBooks";
      } else if (widget.readStat == "WANTTOREAD") {
        status = "wantToRead";
      }
      if (status != "NOTSET") {
        print(
            "status for ${widget.isbn} is : $status and the data is $userBookData");
        var tempReadBookRC = userBookData[status];
        var existingRating = tempReadBookRC[widget.isbn]["rating"];
        // currentRating = double.parse(existingRating);
        currentRating = existingRating;
        var existingComment = tempReadBookRC[widget.isbn]["comment"];
        currentComment = existingComment;
      } else {
        currentComment = "노트를 남겨보세요";
        currentRating = 0;
      }

      // print(tempReadBookRC[widget.isbn]);
      setState(() {
        ratingFetched = true;
      });
    }
    currentComment = comment;
    currentRating = rating;
    var fetchedData = await fireStore.collection("UserData").doc(_user.uid).set(
      {
        "readBooks": {
          widget.isbn: {
            "rating": currentRating,
            "comment": currentComment,
            "status": "READ"
          }
        },
      },
      SetOptions(merge: true),
    );
    setState(() {});
  }

  // bool ratingFechted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isRead
                    ? Icons.check_box
                    : Icons.check_box_outline_blank_outlined,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.isbn,
                    child: Container(
                      // width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Image.network(
                        widget.cover,
                        headers: const {
                          'Referer': 'https://www.aladin.co.kr',
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: book,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              snapshot.data!.author,
                              style: const TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              snapshot.data!.description,
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ],
                        );
                      }
                      return const Text('...');
                    }),
              ),
              const SizedBox(
                height: 28,
              ),
              RatingBar.builder(
                initialRating: ratingFetched ? currentRating : 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  onStarTap(rating: rating, comment: currentComment);
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                child: TextField(
                  onSubmitted: (value) {
                    // Get.to(SearchResultScreen(keyword: myController.text));
                    setState(() {
                      // isValueEntered = true;
                      onStarTap(
                          rating: currentRating,
                          comment: commentController.text);
                    });
                  },
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: ratingFetched ? currentComment : '감상평을 남겨보세요.',
                    // prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Get.to(
                        //     SearchResultScreen(keyword: myController.text));
                        setState(() {
                          // isValueEntered = true;
                          onStarTap(
                              rating: currentRating,
                              comment: commentController.text);
                        });
                      },
                      icon: const Icon(Icons.check),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     var fetchedData = await fireStore
                  //         .collection("UserData")
                  //         .doc(_user.uid)
                  //         .set(
                  //       {
                  //         "readBooks": {
                  //           widget.isbn: {
                  //             "rating": currentRating,
                  //             "comment": currentComment,
                  //             "status": "READ"
                  //           }
                  //         },
                  //       },
                  //       SetOptions(merge: true),
                  //     );
                  //     // print(fetchedData.data());
                  //   },
                  //   child: const Text("다 읽었어요"),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      var fetchedData = await fireStore
                          .collection("UserData")
                          .doc(_user.uid)
                          .set(
                        {
                          "readingBooks": {
                            widget.isbn: {
                              "rating": currentRating,
                              "comment": currentComment,
                              "status": "READING"
                            }
                          },
                        },
                        SetOptions(merge: true),
                      );
                      // print(fetchedData.data());
                    },
                    child: const Text("읽는 중이에요"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var fetchedData = await fireStore
                          .collection("UserData")
                          .doc(_user.uid)
                          .set(
                        {
                          "wantToRead": {
                            widget.isbn: {
                              "rating": currentRating,
                              "comment": currentComment,
                              "status": "WANTTOREAD"
                            }
                          },
                        },
                        SetOptions(merge: true),
                      );
                    },
                    child: const Text("읽고 싶어요"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
