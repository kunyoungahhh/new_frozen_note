import 'package:flutter/material.dart';
import 'package:new_frozen_note/screens/rating_screen.dart';

class Book extends StatelessWidget {
  final String title, author, pubDate, cover, isbn, readStat;

  const Book({
    super.key,
    required this.title,
    required this.author,
    required this.pubDate,
    required this.cover,
    required this.isbn,
    required this.readStat,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RatingScreen(
                title: title,
                author: author,
                pubDate: pubDate,
                cover: cover,
                isbn: isbn,
                readStat: readStat,
              ),
              fullscreenDialog: false,
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Hero(
                    tag: isbn,
                    child: Container(
                      // width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: Image.network(
                        cover,
                        headers: const {
                          'Referer': 'https://www.aladin.co.kr',
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        author,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        "출판일: $pubDate",
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
