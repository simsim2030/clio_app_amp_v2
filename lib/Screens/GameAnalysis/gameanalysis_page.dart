import 'package:clio_chess_amp_v2/services/api_service.dart';
import 'package:flutter/material.dart';

class GameAnalysis extends StatefulWidget {
  static const routeName = '/gameanalysis_page';

  @override
  State<GameAnalysis> createState() => _GameAnalysisState();
}

class _GameAnalysisState extends State<GameAnalysis> {
  APIService apiservice = APIService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chess'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String sub = await apiservice.fetchCurrentUserAttributes();
            apiservice.createClioMoveList('d2d4', sub);
          },
          child: Text('To create ML'),
        ),
      ),
    );
  }
}
