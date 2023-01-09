import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class AnalysisBoard {
  void readCSV() {
    List<List<dynamic>> _data = [];
  }

  Future<String> loadCSV() async {
    // List<String> added = [];
    final String CurrentFen;
    // print('Enter a file name to read from: ');
    // var fileName = 'assets/position/position.csv';
    final _rawData =
        await rootBundle.loadString("assets/position/position.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    print(csvTable[0][1]);
    print(csvTable[26][1]);
    // print(_rawData);
    // lines.removeAt(0);
    // LineSplitter.split(_rawData).forEach((line) => print('$line'));

    CurrentFen = csvTable[csvTable.length - 1][1];

    return CurrentFen;
  }

  Future<int> getMoveNumber() async {
    // List<String> added = [];
    final String CurrentFen;
    // print('Enter a file name to read from: ');
    // var fileName = 'assets/position/position.csv';
    final _rawData =
        await rootBundle.loadString("assets/position/position.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);

    return csvTable.length - 1;
  }

  Future<String> switchPoistion(moveNumber) async {
    // List<String> added = [];
    final String CurrentFen;
    // print('Enter a file name to read from: ');
    // var fileName = 'assets/position/position.csv';
    final _rawData =
        await rootBundle.loadString("assets/position/position.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(_rawData);
    csvTable[0][1] = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR b KQkq - 0 1';
    print(csvTable.length);
    print(csvTable[moveNumber][1]);
    // print(_rawData);
    // lines.removeAt(0);
    // LineSplitter.split(_rawData).forEach((line) => print('$line'));

    CurrentFen = csvTable[moveNumber][1];

    return CurrentFen;
  }
}
