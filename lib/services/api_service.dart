import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:clio_chess_amp_v2/models/ChessMove.dart';
import 'dart:async';

import 'package:clio_chess_amp_v2/models/ModelProvider.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class APIService {
  // Future<void> createTODO(String todoname) async {
  //   try {
  //     Todo todo = Todo(
  //       name: 'my 2nd todo',
  //       description: 'todo description',
  //     );
  //     final request = ModelMutations.create(todo);
  //     final response = await Amplify.API.mutate(request: request).response;

  //     Todo? createdTodo = response.data;
  //     if (createdTodo == null) {
  //       print('errors: ' + response.errors.toString());
  //       return;
  //     }
  //     print('Mutation result: ' + createdTodo.name);
  //   } on ApiException catch (e) {
  //     print('Mutation failed: $e');
  //   }
  // }

  Future<void> createClioMoveList(String move, String sub) async {
    try {
      ClioMove chessmove = ClioMove(
        movenumber: 1,
        move: 'd2d4',
        board_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1',
        user: sub,
      );
      final request = ModelMutations.create(chessmove);
      final response = await Amplify.API.mutate(request: request).response;

      ClioMove? createdClioMoveList = response.data;
      if (createdClioMoveList == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Mutation result: ' + createdClioMoveList.id);
      print('User: ' + sub);
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> updateClioMove(
      ClioMove originalClioMove, String board_Fen) async {
    final ClioMoveWithNewFen = originalClioMove.copyWith(board_fen: board_Fen);

    final request = ModelMutations.update(ClioMoveWithNewFen);
    final response = await Amplify.API.mutate(request: request).response;
    print('Response: $response');
  }

  Future<void> getFEN(String fen) async {
    try {
      final request = ModelQueries.get(
        ClioMove.classType,
        '1',
      );
      final response = await Amplify.API.query(request: request).response;
      ClioMove? chessmove = response.data;
      if (chessmove == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Query result: ' + chessmove.move);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  Future<ClioMove?> queryItem(ClioMove queriedClioMove) async {
    try {
      final request = ModelQueries.get(ClioMove.classType, queriedClioMove.id);
      final response = await Amplify.API.query(request: request).response;
      final cliomove = response.data;
      if (cliomove == null) {
        print('errors: ${response.errors}');
      }
      return cliomove;
    } on ApiException catch (e) {
      print('Query failed: $e');
      return null;
    }
  }

  Future<void> subscribe(ChessBoardController controller) async {
    final subscriptionRequest = ModelSubscriptions.onUpdate(ClioMove.classType);
    final Stream<GraphQLResponse<ClioMove>> operation = Amplify.API.subscribe(
      subscriptionRequest,
      onEstablished: () => print('Subscription established'),
    );
    final StreamSubscription<GraphQLResponse<ClioMove>> subscription =
        operation.listen(
      (event) {
        print('Subscription event data received: ${event.data}');
        ClioMove? chessmove = event.data;
        String? move = chessmove!.board_fen;
        print('move received: ${move}');
        controller.loadFen(move);
      },
      onError: (Object e) => print('Error in subscription stream: $e'),
    );

    // ...

    // Cancel the subscription and close the underlying stream.
    // subscription.cancel();
  }

  Future<String> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();
      String _sub = result.first.value;
      // print('_sub: ' + _sub);
      return _sub;
      // for (final element in result) {
      //   print('key: ${element.userAttributeKey}; value: ${element.value}');
      // }
    } on AuthException catch (e) {
      print(e.message);
      return "error: no user attribute";
    }
  }
}
