/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ChessMove type in your schema. */
@immutable
class ChessMove extends Model {
  static const classType = const _ChessMoveModelType();
  final String id;
  final String? _board_fen;
  final int? _movenumber;
  final String? _move;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get board_fen {
    return _board_fen;
  }
  
  int get movenumber {
    try {
      return _movenumber!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get move {
    try {
      return _move!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ChessMove._internal({required this.id, board_fen, required movenumber, required move, createdAt, updatedAt}): _board_fen = board_fen, _movenumber = movenumber, _move = move, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ChessMove({String? id, String? board_fen, required int movenumber, required String move}) {
    return ChessMove._internal(
      id: id == null ? UUID.getUUID() : id,
      board_fen: board_fen,
      movenumber: movenumber,
      move: move);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChessMove &&
      id == other.id &&
      _board_fen == other._board_fen &&
      _movenumber == other._movenumber &&
      _move == other._move;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ChessMove {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("board_fen=" + "$_board_fen" + ", ");
    buffer.write("movenumber=" + (_movenumber != null ? _movenumber!.toString() : "null") + ", ");
    buffer.write("move=" + "$_move" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ChessMove copyWith({String? id, String? board_fen, int? movenumber, String? move}) {
    return ChessMove._internal(
      id: id ?? this.id,
      board_fen: board_fen ?? this.board_fen,
      movenumber: movenumber ?? this.movenumber,
      move: move ?? this.move);
  }
  
  ChessMove.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _board_fen = json['board_fen'],
      _movenumber = (json['movenumber'] as num?)?.toInt(),
      _move = json['move'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'board_fen': _board_fen, 'movenumber': _movenumber, 'move': _move, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "chessMove.id");
  static final QueryField BOARD_FEN = QueryField(fieldName: "board_fen");
  static final QueryField MOVENUMBER = QueryField(fieldName: "movenumber");
  static final QueryField MOVE = QueryField(fieldName: "move");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChessMove";
    modelSchemaDefinition.pluralName = "ChessMoves";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChessMove.BOARD_FEN,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChessMove.MOVENUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChessMove.MOVE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ChessMoveModelType extends ModelType<ChessMove> {
  const _ChessMoveModelType();
  
  @override
  ChessMove fromJson(Map<String, dynamic> jsonData) {
    return ChessMove.fromJson(jsonData);
  }
}