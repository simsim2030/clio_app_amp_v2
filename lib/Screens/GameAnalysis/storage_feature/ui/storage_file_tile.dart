import 'package:cached_network_image/cached_network_image.dart';
import 'package:clio_chess_amp_v2/models/storage_file.dart';
import 'package:flutter/material.dart';

class StorageFileTile extends StatelessWidget {
  const StorageFileTile({
    required this.storageFile,
    Key? key,
  }) : super(key: key);

  final StorageFile storageFile;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: CachedNetworkImage(
        cacheKey: storageFile.key,
        imageUrl: storageFile.url,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
