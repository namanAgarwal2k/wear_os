import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//below project shows :-
//1. To bound ball in a card
//2. To make it draggable inside it
//3. Updating position with renderObject and Gesture Detector

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: RoomCard(room: Room()),
    ));
  }
}

class Room {}

class RoomCard extends StatefulWidget {
  final Room room;

  const RoomCard({
    super.key,
    required this.room,
  });

  @override
  _RoomCardState createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  double x = 0.0;
  double y = 0.0;

  @override
  Widget build(BuildContext context) {
    //This hight should be known or calculated for the Widget need to be moved
    const double markerHight = 50.0;

    double ymax = context.findRenderObject()?.paintBounds.bottom ?? markerHight;

    return SizedBox(
      height: 300.0,
      width: 400.0,
      child: GestureDetector(
        onPanUpdate: (p) {
          setState(() {
            x += p.delta.dx;
            y = (y + p.delta.dy) > ymax - markerHight
                ? ymax - markerHight
                : y + p.delta.dy;
          });
        },
        child: Card(
          child: Stack(
            children: <Widget>[
              Marker(
                x: x,
                y: y,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Marker extends StatelessWidget {
  final double x;
  final double y;

  const Marker({super.key, this.x = 0.0, this.y = 0.0});

  @override
  Widget build(BuildContext context) {
    print("x: $x, y: $y");
    return Transform(
        transform: Matrix4.translationValues(x, y, 0.0), child: CircleAvatar());
  }
}

///## Below example of tooltip flutter ##///

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:wear/wear.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Tooltip(
//           message: 'Hotspot message here.',
//           decoration: const BoxDecoration(color: Colors.grey),
//           verticalOffset: 20,
//           showDuration: const Duration(seconds: 2),
//           child: IconButton(
//             onPressed: () {},
//             icon: const Icon(CupertinoIcons.plus),
//           ),
//         ),
//       ),
//
//       // Stack(
//       //   children: [
//       //     Column(
//       //       children: [
//       //         Image.network(
//       //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1L6VxC0NULCGUL4C5C9qNVjr2CuUmA3OGwg&usqp=CAU',
//       //           fit: BoxFit.cover,
//       //           width: double.infinity,
//       //         ),
//       //       ],
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }

//////Below project is an example of wearOS flutter //////

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.blue,
//         body: Center(
//           child: WatchShape(
//             builder: (BuildContext context, WearShape shape, Widget? child) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'Shape: ${shape == WearShape.round ? 'round' : 'square'}',
//                   ),
//                   const Icon(CupertinoIcons.bell),
//                   child!,
//                 ],
//               );
//             },
//             child: AmbientMode(
//               builder: (BuildContext context, WearMode mode, Widget? child) {
//                 return Text(
//                   'Mode: ${mode == WearMode.active ? 'Active' : 'Ambient'}',
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
