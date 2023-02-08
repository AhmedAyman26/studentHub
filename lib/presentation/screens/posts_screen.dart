import 'package:flutter/material.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/shared/widgets.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            search_widget(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image(
                            image: AssetImage(
                                "assets/images/man.png"
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'AhmedMohamed',
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // ListView.separated(
            //   shrinkWrap: true,
            //   itemBuilder: (context,index)=>PostCard(),
            //   separatorBuilder: (context,index)=>myDivider(),
            //   itemCount: 10,
            // ),
          ],
        ),
      ),
    );
  }

// Widget PostCard() {
//   return Card(
//     child: Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 25,
//               child: Icon(Icons.person),
//               // backgroundImage: NetworkImage(
//               //     // '${model.image}'
//               //   ''
//               // ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'AhmedMohamed',
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
