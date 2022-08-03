import 'package:flutter/material.dart';

import 'customtimer.dart';

Future<int?> createAlertDialog(BuildContext context) async {
  TextEditingController controller = TextEditingController();

  List<bool> _selections = [true, false, false, false];
  List textList = ['5 mins', '10 mins', '15 mins', '20 mins'];
  List _timecontrolMin = [300000, 600000, 900000, 1200000];
  int _timeControl = 300000;

  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) => AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: Center(
                  child: Text(
                    "Time Control",
                    style: TextStyle(color: Color.fromARGB(220, 255, 255, 255)),
                  ),
                ),
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      // TextField(
                      //   controller: controller,
                      // ),

                      Ink(
                        width: 200,
                        height: 200,
                        color: Colors.grey.shade900,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                          children: List.generate(_selections.length, (index) {
                            return InkWell(
                              splashColor: Colors.amber,
                              onTap: () {
                                setState(() {
                                  for (int indexBtn = 0;
                                      indexBtn < _selections.length;
                                      indexBtn++) {
                                    if (indexBtn == index) {
                                      _selections[indexBtn] = true;
                                      // press through the mins and return the duration
                                      _timeControl = _timecontrolMin[indexBtn];
                                    } else {
                                      _selections[indexBtn] = false;
                                    }
                                  }
                                });
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  //set the background color of the button when it is selected/ not selected
                                  color: _selections[index]
                                      ? Colors.orange
                                      : Colors.white24,
                                  // here is where we set the rounded corner
                                  borderRadius: BorderRadius.circular(8),
                                  //don't forget to set the border,
                                  //otherwise there will be no rounded corner
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Center(
                                  child: Text(
                                    textList[index],

                                    //set the color of the icon when it is selected/ not selected
                                    style: TextStyle(
                                        color: _selections[index]
                                            ? Colors.white70
                                            : Colors.white70,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20.0),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.white24,
                      //     ),
                      //     onPressed: () {
                      //       customTimeDialog(context).then((value) {
                      //         _timeControl = value! * 1000;
                      //       });
                      //     },
                      //     child: Text(
                      //       'Custom',
                      //       style: TextStyle(fontSize: 21),
                      //     ),
                      //   ),
                      // ),
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
                        Navigator.of(context).pop(_timeControl);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              )),
        );
      });
}
