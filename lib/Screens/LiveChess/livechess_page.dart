import 'package:clio_chess_amp_v2/services/api_service.dart';
import 'package:flutter/material.dart';

class LiveChess extends StatefulWidget {
  static const routeName = '/livechess_page';

  @override
  State<LiveChess> createState() => _LiveChessState();
}

class _LiveChessState extends State<LiveChess> {
  APIService apiservice = APIService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chess'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            apiservice.createClioMoveList('d2d4');
          },
          child: Text('To create ML'),
        ),
      ),
    );
  }
}
