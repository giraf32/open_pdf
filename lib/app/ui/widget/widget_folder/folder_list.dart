import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/provider_folder.dart';
import 'animated_text_folder.dart';
import 'create_folder_name.dart';
import 'folder_viewer.dart';

@RoutePage()
class FolderList extends StatefulWidget {
  const FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  GlobalKey<ScaffoldState> _globalKey =  GlobalKey<ScaffoldState>();
 // GlobalKey<ScaffoldState> _globalKey2 =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade400,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          this._globalKey.currentState?.showBottomSheet(
              backgroundColor: Theme.of(context).cardColor,
                  (c) => CreateFolderName());
        },
      ),
      body: Consumer<ProviderFolder>(builder: (_, notifier, __) {
        if (notifier.listFolder.isNotEmpty ){
          return GridView.count(
              padding: const EdgeInsets.all(20),
             crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 20,
              children: notifier.listFolder
                  .map((e) => FolderViewer(folderModel: e!))
                  .toList());
        } else {
          if (notifier.notifierStateFolder ==
              NotifierStateFolder.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        return AnimatedTextFolder();
      }),
    );
  }
}
