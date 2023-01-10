import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AnalysisBoard {
  void readCSV() {
    List<List<dynamic>> _data = [];
  }

  Future<String> loadCSV() async {
    final String CurrentFen;

    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/Game1.csv';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    print(csvTable[0][1]);
    print(csvTable[26][1]);

    CurrentFen = csvTable[csvTable.length - 1][1];

    return CurrentFen;
  }

  Future<int> getMoveNumber() async {
    final String CurrentFen;
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/Game1.csv';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);

    return csvTable.length - 1;
  }

  Future<String> switchPoistion(moveNumber) async {
    final String CurrentFen;
    final documentsDir = await getApplicationDocumentsDirectory();
    final filepath = documentsDir.path + '/Game1.csv';
    final file = File(filepath);
    final _rawData = await file.readAsString();

    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    print(csvTable.length);
    print(csvTable[moveNumber][1]);

    CurrentFen = csvTable[moveNumber][1];

    return CurrentFen;
  }
}
