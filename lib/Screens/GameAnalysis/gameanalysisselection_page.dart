import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
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
import 'package:path_provider/path_provider.dart';

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

  Future<void> createAndUploadFile() async {
    // Create a dummy file
    const exampleString = '3';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File(tempDir.path + '/example.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: 'ExampleKey',
          onProgress: (progress) {
            safePrint('Fraction completed: ${progress.getFractionCompleted()}');
          });
      safePrint('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
    }
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

  Future<void> downloadFile() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/Game1.csv';
    print('hi');
    print(filepath);
    final file = File(filepath);

    try {
      final result = await Amplify.Storage.downloadFile(
        key: 'Game1.csv',
        local: file,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      final contents = result.file.readAsStringSync();
      // Or you can reference the file that is created above
      // final contents = file.readAsStringSync();
      safePrint('Downloaded contents: $contents');
    } on StorageException catch (e) {
      safePrint('Error downloading file: $e');
    }
  }

  Future<int> readCounter() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final filepath = documentsDir.path + '/example.txt';
      print('hi2');
      print(filepath);
      final file = File(filepath);

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  final helloWorldProvider = Provider((_) => 'Hello world');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageItems = ref.watch(storageFilesListFutureProvider);
    StorageService storageservice = StorageService();
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(GameAnalysisPage.routeName);
                            downloadFile();
                          },
                          child: StorageFileTile(
                            storageFile: items[index],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createAndUploadFile();
                        // Send command to AWS to do python send csv.
                      },
                      child: Text('Create and upload test file'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        int a = await readCounter();
                        print(a);
                        // Send command to AWS to do python send csv.
                      },
                      child: Text('Read file'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(GameAnalysisPage.routeName);
                        // Send command to AWS to do python send csv.
                        downloadFile();
                        // Download to mobile memory
                      },
                      child: Text('PGN'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.refresh(storageFilesListFutureProvider);
                      },
                      child: Text('refresh'),
                    )
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
    );
  }
}
