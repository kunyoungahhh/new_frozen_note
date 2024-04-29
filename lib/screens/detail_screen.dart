// import 'package:flutter/material.dart';

// class DetailScreen extends StatefulWidget {
//   final String title, thumb, id;

//   const DetailScreen({
//     super.key,
//     required this.title,
//     required this.thumb,
//     required this.id,
//   });

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   late Future<WebtoonDetailModel> webtoon;
//   late Future<List<WebtoonEpisodeModel>> episodes;
//   late SharedPreferences prefs;
//   bool isLiked = false;

//   Future initPrefs() async {
//     prefs = await SharedPreferences.getInstance();
//     final likedToons = prefs.getStringList('likedToons');
//     if (likedToons != null) {
//       if (likedToons.contains(widget.id) == true) {
//         setState(() {
//           isLiked = true;
//         });
//       }
//     } else {
//       await prefs.setStringList('likedToons', []);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     webtoon = ApiService.getToonById(widget.id);
//     episodes = ApiService.getLatestEpisodeById(widget.id);
//     initPrefs();
//   }

//   // onButtonTap() async {
//   //   // final url = Uri.parse("https://google.com");
//   //   await launchUrlString("https://google.com");
//   // }
//   onHeartTap() async {
//     final likedToons = prefs.getStringList('likedToons');
//     if (likedToons != null) {
//       if (isLiked) {
//         likedToons.remove(widget.id);
//       } else {
//         likedToons.add(widget.id);
//       }
//       await prefs.setStringList('likedToons', likedToons);
//       setState(() {
//         isLiked = !isLiked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(widget.title,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w400,
//             )),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.green,
//         elevation: 2,
//         actions: [
//           IconButton(
//               onPressed: onHeartTap,
//               icon: Icon(
//                 isLiked ? Icons.favorite : Icons.favorite_outline,
//               ))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(50),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Hero(
//                     tag: widget.id,
//                     child: Container(
//                       width: 250,
//                       clipBehavior: Clip.hardEdge,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 15,
//                             offset: const Offset(10, 10),
//                             color: Colors.black.withOpacity(0.3),
//                           ),
//                         ],
//                       ),
//                       child: Image.network(
//                         widget.thumb,
//                         headers: const {
//                           "User-Agent":
//                               "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               FutureBuilder(
//                   future: webtoon,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             snapshot.data!.about,
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             '${snapshot.data!.genre} / ${snapshot.data!.age}',
//                             style: const TextStyle(
//                                 fontSize: 16, fontStyle: FontStyle.italic),
//                           ),
//                         ],
//                       );
//                     }
//                     return const Text('...');
//                   }),
//               const SizedBox(
//                 height: 25,
//               ),
//               FutureBuilder(
//                 future: episodes,
//                 builder: ((context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Column(
//                       children: [
//                         for (var episode in snapshot.data!)
//                           Episode(episode: episode, webtoonId: widget.id)
//                       ],
//                     );
//                   }
//                   return Container();
//                 }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
