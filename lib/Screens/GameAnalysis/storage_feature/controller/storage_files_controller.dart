import 'dart:io';

import 'package:clio_chess_amp_v2/models/storage_file.dart';
import 'package:clio_chess_amp_v2/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageFilesControllerProvider = Provider<StorageFilesController>((ref) {
  return StorageFilesController(ref: ref);
});

final storageFilesListFutureProvider = FutureProvider<List<StorageFile>>((ref) {
  final storageFilesController = ref.watch(storageFilesControllerProvider);
  return storageFilesController.getStorageFiles();
});

class StorageFilesController {
  StorageFilesController({
    required Ref ref,
  }) : service = ref.read(storageServiceProvider);

  final StorageService service;

  Future<void> uploadFile(File file) async {
    final fileKey = await service.uploadFile(file);
    if (fileKey != null) {
      service.resetUploadProgress();
    }
  }

  Future<void> deleteFile(String fileKey) => service.deleteFile(fileKey);

  ValueNotifier<int> uploadProgress() => service.getUploadProgress();

  Future<List<StorageFile>> getStorageFiles() => service.getStorageFiles();
}
