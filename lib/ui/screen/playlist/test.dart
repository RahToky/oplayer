import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_file_manager/flutter_file_manager.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider_ex/path_provider_ex.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:permission_handler/permission_handler.dart';
//import package files

//apply this class on home: attribute at MaterialApp()
class MyAudioList extends StatefulWidget {
  static final String routeName = '/test';

  @override
  State<StatefulWidget> createState() {
    return _MyAudioList(); //create state
  }
}

class _MyAudioList extends State<MyAudioList> {
  var files;

  void getFiles() async {
    //asyn function to get list of files
    if (await Permission.storage.request().isGranted) {
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
      var root = storageInfo[0]
          .rootDir; //storageInfo[1] for SD card, geting the root directory
      var fm = FileManager(root: Directory(root)); //
      files = await fm.filesTree(
          excludedPaths: ["/storage/emulated/0/Android"],
          extensions: ["mp3"] //optional, to filter files, list only mp3 files
          );
      setState(() {}); //update the UI
    }
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Audio File list from Storage"),
            backgroundColor: Colors.redAccent),
        body: files == null
            ? Text("Searching Files")
            : ListView.builder(
                //if file/folder list is grabbed, then show here
                itemCount: files?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(files[index].path.split('/').last),
                    leading: Icon(Icons.audiotrack),
                    trailing: Row(),
                    onTap: () {
                      // you can add Play/push code over here
                    },
                  ));
                },
              ));
  }
}
