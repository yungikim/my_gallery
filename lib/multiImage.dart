import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MultiImageApp extends StatefulWidget {
  const MultiImageApp({Key? key}) : super(key: key);

  @override
  State<MultiImageApp> createState() => _MultiImageAppState();
}

class _MultiImageAppState extends State<MultiImageApp> {
  List<Asset> imageList = <Asset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('멀티 이미지 선택'),
        ),
        body: Center(
          child: Column(
            children: [
              imageList.isEmpty ? Container()
              : Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (BuildContext context, int index){
                      Asset asset = imageList[index];
                      return AssetThumb(
                        asset: asset, width: 300, height: 300,
                      );
                    }),
              ),
              OutlinedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 250,
                    child: Text(
                      '갤러리',
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
        ));
  }

  getImage() async{
    // ignore: prefer_collection_literals
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(maxImages: 2, enableCamera: true);
    setState(() {
      imageList = resultList;
    });

  }
}
