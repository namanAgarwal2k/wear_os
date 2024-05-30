import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:wear_os/vehicle_task/measure.dart';
import 'coordinates.dart';
import 'hotspot_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.data, required this.imagePath})
      : super(key: key);
  final List<Coordinates> data;
  final String imagePath;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String imagePath = 'assets/images/car.jpg';
  // List<Coordinates> data = [
  //   Coordinates(x: 72, y: 102, name: "24 inch MRF tyre"),
  //   Coordinates(x: 230, y: 44, name: "Left side mirror"),
  // ];

  Size sizeImage = const Size(0, 0);
  double imageWidth = 0;
  double imageHeight = 0;

  void imageSize() async {
    double width;
    double height;
    const Image image = Image(image: AssetImage('assets/images/car.jpg'));
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
        width = info.image.width.toDouble();
        height = info.image.height.toDouble();
        setState(() {
          imageWidth = width;
          imageHeight = height;
        });
      }),
    );
  }

  getCalculatedX(double x, double screenWidth) {
    double diff = screenWidth - imageWidth;
    return (diff / imageWidth) * x + x;
  }

  getCalculatedY(double y, double screenHeight) {
    double diff = screenHeight - imageHeight;
    return y + (diff / imageHeight) * y;
  }

  @override
  Widget build(BuildContext context) {
    imageSize();
    return Stack(children: [
      MeasureSize(
        onChange: (Size size) {
          setState(() {
            sizeImage = size;
          });
        },
        child: Image(
          image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
      ...widget.data
          .map((e) => HotspotButton(
              x: getCalculatedX(e.x, sizeImage.width),
              y: getCalculatedY(e.y, sizeImage.height),
              text: e.name ?? ""))
          .toList()
    ]);
  }
}

// floatingActionButton: FloatingActionButton(
//   backgroundColor: Colors.greenAccent,
//   child: const Icon(Icons.rotate_left_outlined),
//   onPressed: () {
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//     if (isPortrait) {
//       setLandscape();
//     } else {
//       setPortrait();
//     }
//   },
// ),

// Future setLandscape() async => await SystemChrome.setPreferredOrientations(
//     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
//
// Future setPortrait() async => await SystemChrome.setPreferredOrientations(
//     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

// Image.network(
//   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrUCS-OFLnoiJd1a5DKlINcD4C3fJMH21LDBghKWH-aWipieGiDunT8yJz3Hrxpe5pqOs&usqp=CAU',

//
// File image = File('image.png'); // Or any other way to get a File instance.
// var decodedImage = await decodeImageFromList(image.readAsBytesSync());
// print(decodedImage.width);
// print(decodedImage.height);
// return decodedImage as Future<Image>;
