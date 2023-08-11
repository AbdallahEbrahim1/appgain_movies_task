// import 'package:flutter/material.dart';
//
// class CastWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
//           child: Text(
//             "castTitle",
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: SizedBox(
//             height: 86,
//             child: ListView.separated(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               scrollDirection: Axis.horizontal,
//               itemCount: 9,
//               itemBuilder: (context, index) => Column(
//                 children: [
//                   Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(
//                           "ct[index].avatarUrl",
//                         ),
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(56)),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "cast[index].name",
//                   ),
//                 ],
//               ),
//               separatorBuilder: (context, index) => const SizedBox(width: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
