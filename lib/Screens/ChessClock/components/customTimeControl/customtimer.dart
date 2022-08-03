import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<int?> customTimeDialog(BuildContext context) async {
  TextEditingController timeController = TextEditingController();

  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (((context, setState) => AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Center(
                  child: Text(
                    'Custom Time Control',
                    style: TextStyle(color: Color.fromARGB(220, 255, 255, 255)),
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                labelText: "Time Control (Sec)",
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: timeController,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Center(
                    child: MaterialButton(
                      elevation: 5.0,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Color.fromARGB(220, 255, 255, 255),
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(int.parse(timeController.text));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ))),
        );
      });
}
