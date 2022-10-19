import 'dart:io';

import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/controller/storage_files_controller.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/ui/upload_progress_dialog.dart';
import 'package:clio_chess_amp_v2/models/storage_file.dart';
import 'package:clio_chess_amp_v2/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GameAnalysis extends StatefulWidget {
  static const routeName = '/gameanalysis_page';

  @override
  State<GameAnalysis> createState() => _GameAnalysisState();
}

class _GameAnalysisState extends State<GameAnalysis> {
  StorageService storageservice = StorageService();

  Future<bool> uploadImage({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return false;
    }

    final file = File(pickedFile.path);
    showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const UploadProgressDialog();
        });
    await ref.read(storageFilesControllerProvider).uploadFile(file);
    return true;
  }

  Future<void> deletestorageFile(
      BuildContext context, WidgetRef ref, StorageFile storageFile) async {
    var value = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const DeleteStorageFileDialog();
        });
    value ??= false;

    if (value) {
      await ref
          .read(storageFilesControllerProvider)
          .deleteFile(storageFile.key);
      ref.refresh(storageFilesListFutureProvider);
    }
  }

  @override
  void initState() {
    storageservice.listItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chess'),
      ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView(
      //         children: [
      //           ListTile(
      //             title: Text('Game 1 - 20/09/2015'),
      //             subtitle: Text('Sim - Calvin'),
      //             leading: Icon(Icons.label),
      //           ),
      //         ],
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         storageservice.createAndUploadFile();
      //       },
      //       child: Text('update test'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         storageservice.refresh(1);
      //       },
      //       child: Text('refresh'),
      //     )
      //   ],
      // ),
    );
  }
}
