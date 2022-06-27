import 'package:amplify_api/amplify_api.dart';
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

  Future<void> createClioMoveList(String move) async {
    try {
      ClioMove chessmove = ClioMove(
        movenumber: 1,
        move: 'd2d4',
        board_fen: '8/8/8/4p1K1/2k1P3/8/8/8 b - - 0 1',
      );
      final request = ModelMutations.create(chessmove);
      final response = await Amplify.API.mutate(request: request).response;

      ClioMove? createdClioMoveList = response.data;
      if (createdClioMoveList == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Mutation result: ' + createdClioMoveList.move);
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  // Future<void> getTODO(String todoname) async {
  //   try {
  //     String graphQLDocument = '''query ListTodos {
  //     listTodos {
  //       items {
  //         id
  //         name
  //         description
  //       }
  //       nextToken
  //     }
  //   }''';

  //     var operation = Amplify.API
  //         .query(request: GraphQLRequest<String>(document: graphQLDocument));

  //     var response = await operation.response;
  //     var data = response.data;

  //     print('Query result: ' + data!);
  //   } on ApiException catch (e) {
  //     print('Query failed: $e');
  //   }
  // }

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

  // Future<void> getTODO1(String todo) async {
  //   try {
  //     final request = ModelQueries.get(Todo.classType, '1');
  //     final response = await Amplify.API.query(request: request).response;
  //     Todo? todo = response.data;
  //     if (todo == null) {
  //       print('errors: ' + response.errors.toString());
  //       return;
  //     }
  //     print('Query result: ' + todo.name);
  //   } on ApiException catch (e) {
  //     print('Query failed: $e');
  //   }
  // }

  Future<void> subscribe(ChessBoardController controller) async {
    final subscriptionRequest = ModelSubscriptions.onCreate(ClioMove.classType);
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
}
