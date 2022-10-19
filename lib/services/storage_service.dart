import 'dart:io';
import 'package:clio_chess_amp_v2/models/storage_file.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import 'package:clio_chess_amp_v2/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show ValueNotifier;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  ValueNotifier<int> uploadProgress = ValueNotifier<int>(0);

  Future<List<StorageFile>> getStorageFiles() async {
    List<StorageFile> storageItemsList = [];

    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> storageItems = result.items;

      if (storageItems.isNotEmpty) {
        storageItems.sort((a, b) => b.lastModified!.compareTo(a.lastModified!));

        await Future.forEach<StorageItem>(storageItems, (file) async {
          final String fileUrl = await getImageUrl(file.key);

          storageItemsList.add(StorageFile(key: file.key, url: fileUrl));
        });
      }
    } on Exception catch (e) {
      logger.e(e);
    }
    return storageItemsList;
  }

  Future<String> getImageUrl(String key) async {
    final GetUrlResult result = await Amplify.Storage.getUrl(
      key: key,
      options: S3GetUrlOptions(expires: 60000),
    );
    return result.url;
  }

  Future<void> deleteFile(String key) async {
    try {
      await Amplify.Storage.remove(key: key);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  ValueNotifier<int> getUploadProgress() => uploadProgress;

  Future<String?> uploadFile(File file) async {
    try {
      final extension = p.extension(file.path);
      final key = const Uuid().v1() + extension;
      await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          uploadProgress.value =
              (progress.getFractionCompleted() * 100).toInt();
        },
      );

      return key;
    } on Exception catch (e) {
      logger.e(e);
      return null;
    }
  }

  void resetUploadProgress() {
    uploadProgress.value = 0;
  }

  //
  //
  //

  Future<void> createAndUploadFile() async {
    // Create a dummy file
    const exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File(tempDir.path + '/example2.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: 'ExampleKey2',
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          });
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> listItems() async {
    try {
      print('In list');
      S3ListOptions options =
          S3ListOptions(accessLevel: StorageAccessLevel.guest);
      ListResult result = await Amplify.Storage.list(options: options);
      print('List Result:');
      for (StorageItem item in result.items) {
        print(
            'Item: { key:${item.key}, eTag:${item.eTag}, lastModified:${item.lastModified}, size:${item.size}');
      }
    } catch (e) {
      print('List Err: ' + e.toString());
    }
  }

  Future<String> refresh(int index) async {
    try {
      print('In list');
      S3ListOptions options =
          S3ListOptions(accessLevel: StorageAccessLevel.guest);
      ListResult result = await Amplify.Storage.list(options: options);
      print('List Result:');
      String PNGName = 'a';
      // for (StorageItem item in result.items) {
      //   print(
      //       'Item: { key:${item.key}, eTag:${item.eTag}, lastModified:${item.lastModified}, size:${item.size}');
      //   PNGName = item.key;
      //   print('test:' + PNGName);
      // }
      PNGName = result.items[index].key;
      print(PNGName);
      return PNGName;
    } catch (e) {
      print('List Err: ' + e.toString());
      return '';
    }
  }
}
