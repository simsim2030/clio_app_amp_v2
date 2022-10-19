import 'package:flutter/material.dart';

class DeleteStorageFileDialog extends StatelessWidget {
<<<<<<< HEAD
  const DeleteStorageFileDialog({Key? key}) : super(key: key);
=======
  const DeleteStorageFileDialog({
    super.key,
  });
>>>>>>> c468921250052491e060731c8c4115fe94df3938

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Delete this file?'),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'))
      ],
    );
  }
}
