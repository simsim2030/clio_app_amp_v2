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


/** This is an auto generated class representing the ClioMove type in your schema. */
@immutable
class ClioMove extends Model {
  static const classType = const _ClioMoveModelType();
  final String id;
  final String? _board_fen;
  final int? _movenumber;
  final String? _move;
  final String? _user;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get board_fen {
    try {
      return _board_fen!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  String? get user {
    return _user;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ClioMove._internal({required this.id, required board_fen, required movenumber, required move, user, createdAt, updatedAt}): _board_fen = board_fen, _movenumber = movenumber, _move = move, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ClioMove({String? id, required String board_fen, required int movenumber, required String move, String? user}) {
    return ClioMove._internal(
      id: id == null ? UUID.getUUID() : id,
      board_fen: board_fen,
      movenumber: movenumber,
      move: move,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClioMove &&
      id == other.id &&
      _board_fen == other._board_fen &&
      _movenumber == other._movenumber &&
      _move == other._move &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ClioMove {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("board_fen=" + "$_board_fen" + ", ");
    buffer.write("movenumber=" + (_movenumber != null ? _movenumber!.toString() : "null") + ", ");
    buffer.write("move=" + "$_move" + ", ");
    buffer.write("user=" + "$_user" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ClioMove copyWith({String? id, String? board_fen, int? movenumber, String? move, String? user}) {
    return ClioMove._internal(
      id: id ?? this.id,
      board_fen: board_fen ?? this.board_fen,
      movenumber: movenumber ?? this.movenumber,
      move: move ?? this.move,
      user: user ?? this.user);
  }
  
  ClioMove.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _board_fen = json['board_fen'],
      _movenumber = (json['movenumber'] as num?)?.toInt(),
      _move = json['move'],
      _user = json['user'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'board_fen': _board_fen, 'movenumber': _movenumber, 'move': _move, 'user': _user, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "clioMove.id");
  static final QueryField BOARD_FEN = QueryField(fieldName: "board_fen");
  static final QueryField MOVENUMBER = QueryField(fieldName: "movenumber");
  static final QueryField MOVE = QueryField(fieldName: "move");
  static final QueryField USER = QueryField(fieldName: "user");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ClioMove";
    modelSchemaDefinition.pluralName = "ClioMoves";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
<<<<<<< HEAD
        authStrategy: AuthStrategy.PUBLIC,
        provider: AuthRuleProvider.APIKEY,
=======
        authStrategy: AuthStrategy.PRIVATE,
        provider: AuthRuleProvider.USERPOOLS,
>>>>>>> 0fbb56fcb386f9914694ea597f1e855266d7220c
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClioMove.BOARD_FEN,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClioMove.MOVENUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClioMove.MOVE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ClioMove.USER,
      isRequired: false,
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

class _ClioMoveModelType extends ModelType<ClioMove> {
  const _ClioMoveModelType();
  
  @override
  ClioMove fromJson(Map<String, dynamic> jsonData) {
    return ClioMove.fromJson(jsonData);
  }
}