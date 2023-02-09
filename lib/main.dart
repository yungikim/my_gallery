import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/multFile.dart';
import 'package:my_gallery/tilt_sensor.dart';
import 'package:my_gallery/xylophone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: const SensorApp(),
      //home: const MyGalleryApp(),
      //home : const XylophoneApp(),
      home: const MultiFileApp(),
    );
  }
}

class MyGalleryApp extends StatefulWidget {
  const MyGalleryApp({Key? key}) : super(key: key);

  @override
  State<MyGalleryApp> createState() => _MyGalleryAppState();
}

class _MyGalleryAppState extends State<MyGalleryApp> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  int currentPage = 0;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();

    LoadImages();
  }

  Future<void> LoadImages() async {
    images = await _picker.pickMultiImage();

    if (images != null) {
      Timer.periodic(const Duration(seconds: 5), (timer) {
        currentPage++;
        if (currentPage > images!.length - 1) {
          currentPage = 0;
        }

        pageController.animateToPage(currentPage,
            duration: Duration(milliseconds: 350), curve: Curves.easeIn);
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전자액자"),
      ),
      body: images == null
          ? const Center(child: Text("No data"))
          : PageView(
              controller: pageController,
              children: images!.map((image) {
                return FutureBuilder<Uint8List>(
                    future: image.readAsBytes(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (data == null ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Image.memory(
                        data,
                        width: double.infinity,
                      );
                    });
              }).toList(),
            ),
    );
  }
}
