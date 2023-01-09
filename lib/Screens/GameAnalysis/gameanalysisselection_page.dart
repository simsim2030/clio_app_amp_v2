import 'dart:io';

import 'package:clio_chess_amp_v2/Screens/GameAnalysis/AnalysisPage/gameanalysis_page.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/controller/storage_files_controller.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/ui/delete_storage_file_dialog.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/ui/storage_file_tile.dart';
import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/ui/upload_progress_dialog.dart';
import 'package:clio_chess_amp_v2/models/storage_file.dart';
import 'package:clio_chess_amp_v2/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GameAnalysisSelection extends ConsumerWidget {
  static const routeName = '/gameanalysisselection_page';

  GameAnalysisSelection({Key? key}) : super(key: key);

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

  final helloWorldProvider = Provider((_) => 'Hello world');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageItems = ref.watch(storageFilesListFutureProvider);
    // final value = ref.watch(helloWorldProvider);
    // return Text(value); // Hello world
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Post Game Analysis'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uploadImage(
            context: context,
            ref: ref,
          ).then((value) {
            if (value) {
              ref.refresh(storageFilesListFutureProvider);

              Navigator.of(context, rootNavigator: true).pop();
            }
          });
        },
        child: const Icon(Icons.add),
      ),

      body: Container(
        padding: EdgeInsets.all(8.0),
        child: storageItems.when(
          data: (items) => items.isEmpty
              ? const Center(
                  child: Text('No Items'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        key: const Key('StorageItemsGridView'),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 5,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) => InkWell(
                          highlightColor: Colors.red.withOpacity(0.4),
                          splashColor: Colors.amber.withOpacity(0.5),
                          onLongPress: (() {
                            deletestorageFile(context, ref, items[index]);
                          }),
                          child: StorageFileTile(
                            storageFile: items[index],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(GameAnalysisPage.routeName);
                      },
                      child: Text('PGN'),
                    ),
                  ],
                ),
          error: (e, st) => const Center(
            child: Text('Error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
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
