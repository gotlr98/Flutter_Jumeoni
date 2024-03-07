// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../database/firebase_user_database.dart';

// class DrinkGridView extends StatelessWidget {
//   List<Image> images = [];
//   DrinkGridView(List<Image> image, {super.key}) {
//     // super.key;
//     images = image;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       scrollDirection: Axis.vertical,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3, //1 개의 한 행에 보여줄 개수
//         childAspectRatio: 1 / 1, //item 의 가로, 세로 비율
//         mainAxisSpacing: 5, //수평 Padding
//         crossAxisSpacing: 5,
//       ), //📲수직 Padding),)
//       itemCount: images.length,
//       itemBuilder: (context, index) {
//         var photo = images[index];
//         return 
//       },
//     );
//   }
// }
