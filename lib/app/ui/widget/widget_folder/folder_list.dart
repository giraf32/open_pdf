import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/provider_folder.dart';
import 'animated_text_folder.dart';
import 'folder_viewer.dart';

class FolderList extends StatelessWidget {
  const FolderList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFolder>(builder: (_, notifier, __) {
      if (notifier.listFolder.isNotEmpty ){
        return GridView.count(
            padding: const EdgeInsets.all(16),
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
    });
  }
}
