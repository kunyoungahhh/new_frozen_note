// import 'package:flutter/material.dart';
// import 'package:new_frozen_note/models/webtoon_episode_model.dart';

// class Episode extends StatelessWidget {
//   const Episode({
//     super.key,
//     required this.episode,
//     required this.webtoonId,
//   });

//   final WebtoonEpisodeModel episode;
//   final String webtoonId;

//   onButtonTap() async {
//     // final url = Uri.parse("https://google.com");
//     // const String webtoonId = "";
//     // print(webtoonId);
//     // print(episode.id);
//     await launchUrlString(
//         "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onButtonTap,
//       child: Container(
//           margin: const EdgeInsets.only(bottom: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.green.shade400,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 10,
//               horizontal: 20,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   episode.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.chevron_right_rounded,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
