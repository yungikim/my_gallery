import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MultiFileApp extends StatefulWidget {
  const MultiFileApp({Key? key}) : super(key: key);

  @override
  State<MultiFileApp> createState() => _MultiFileAppState();
}

class _MultiFileAppState extends State<MultiFileApp> {
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File picker demo"),
      ),
      body:


      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (result != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected file : ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: result?.files.length ?? 0,
                    itemBuilder: (context, index){
                      return Text(result?.files[index].name ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),);
                    })
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result == null) {
                  print('No File selected');
                } else {
                  setState(() {
                    result?.files.forEach((element) {
                      print(element.name);
                    });
                  });
                }
              },
              child: Text('File Picker'),
            ),
          )
        ],
      ),
    );
  }
}
