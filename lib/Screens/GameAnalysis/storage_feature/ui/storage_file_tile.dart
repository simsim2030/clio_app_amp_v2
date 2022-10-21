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
    return Container(
      height: 50,
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.white,
        // child: CachedNetworkImage(
        //   cacheKey: storageFile.key,
        // imageUrl: storageFile.url,
        // height: double.infinity,
        // width: double.infinity,
        // fit: BoxFit.cover,
        // ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //new Row(
            // mainAxisSize: MainAxisSize.max,

            //children: <Widget>[
            new Text(
              storageFile.key,
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
        // child: Text(storageFile.key),
      ),
    );
  }
}
