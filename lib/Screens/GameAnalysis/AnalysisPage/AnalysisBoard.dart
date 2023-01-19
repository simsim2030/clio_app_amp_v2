import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AnalysisBoard {
  double CurrentCP = 0;
  void readCSV() {
    List<List<dynamic>> _data = [];
  }

  Future<String> loadCSV(String gameKey) async {
    final String CurrentFen;

    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$gameKey';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    print(csvTable[0][1]);
    print(csvTable[26][1]);

    CurrentFen = csvTable[csvTable.length - 1][1];

    return CurrentFen;
  }

  Future<int> getMoveNumber(String gameKey) async {
    final String CurrentFen;
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$gameKey';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);

    return csvTable.length - 1;
  }

  Future<String> switchPoistion(moveNumber, String gameKey) async {
    final String CurrentFen;
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$gameKey';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    // print(csvTable.length);
    print(csvTable[moveNumber][1]);

    CurrentFen = csvTable[moveNumber][1];

    return CurrentFen;
  }

  Future<double> getCP(moveNumber, String gameKey) async {
    this.CurrentCP;
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$gameKey';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][2] = 0.0;

    this.CurrentCP = csvTable[moveNumber][2];

    return this.CurrentCP;
  }

  static ValueNotifier<String> cpValue = ValueNotifier('0.0');

  void getCPValue() {
    cpValue.value = this.CurrentCP.toString();
  }

  static ValueNotifier<double> cpValuePercentage = ValueNotifier(0.5);

  void getCPValuePercentage() {
    cpValuePercentage.value = 0.5 + this.CurrentCP / 10;

    if (cpValuePercentage.value < 0) {
      cpValuePercentage.value = 0;
    } else if (cpValuePercentage.value > 1) {
      cpValuePercentage.value = 1;
    } else {
      return;
    }
  }

  static ValueNotifier<List> PGNList = ValueNotifier([]);

  void getPGNList(String gameKey) async {
    final List pgnList = [];
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/$gameKey';
    final file = File(filepath);
    final _rawData = await file.readAsString();
    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    print(csvTable.length);
    csvTable[0][3] = "";

    for (int i = 1; i < csvTable.length; i++) {
      // print(i);
      // print(csvTable[i][3]);

      pgnList.add(csvTable[i][3]);
      print(PGNList);
    }

    PGNList.value = pgnList;
  }

  static ValueNotifier<int> isSelectedMove = ValueNotifier(0);

  void getSelectedMove(SelectedMove) {
    isSelectedMove.value = SelectedMove;
  }
}
