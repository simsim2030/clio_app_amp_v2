import 'package:clio_chess_amp_v2/Screens/GameAnalysis/storage_feature/controller/storage_files_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProgressDialog extends ConsumerWidget {
  const UploadProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ValueListenableBuilder(
          valueListenable:
              ref.read(storageFilesControllerProvider).uploadProgress(),
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 15),
                Text('$value %'),
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.all(20),
                  child: LinearProgressIndicator(
                    value: double.parse(value.toString()) / 100,
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    minHeight: 10,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
