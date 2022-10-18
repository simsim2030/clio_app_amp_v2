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


/** This is an auto generated class representing the MyGames type in your schema. */
@immutable
class MyGames extends Model {
  static const classType = const _MyGamesModelType();
  final String id;
  final String? _Title;
  final String? _white;
  final String? _black;
  final String? _date;
  final bool? _downloaded;
  final String? _user;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get Title {
    try {
      return _Title!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get white {
    try {
      return _white!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get black {
    try {
      return _black!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get downloaded {
    return _downloaded;
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
  
  const MyGames._internal({required this.id, required Title, required white, required black, required date, downloaded, user, createdAt, updatedAt}): _Title = Title, _white = white, _black = black, _date = date, _downloaded = downloaded, _user = user, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MyGames({String? id, required String Title, required String white, required String black, required String date, bool? downloaded, String? user}) {
    return MyGames._internal(
      id: id == null ? UUID.getUUID() : id,
      Title: Title,
      white: white,
      black: black,
      date: date,
      downloaded: downloaded,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyGames &&
      id == other.id &&
      _Title == other._Title &&
      _white == other._white &&
      _black == other._black &&
      _date == other._date &&
      _downloaded == other._downloaded &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MyGames {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("Title=" + "$_Title" + ", ");
    buffer.write("white=" + "$_white" + ", ");
    buffer.write("black=" + "$_black" + ", ");
    buffer.write("date=" + "$_date" + ", ");
    buffer.write("downloaded=" + (_downloaded != null ? _downloaded!.toString() : "null") + ", ");
    buffer.write("user=" + "$_user" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MyGames copyWith({String? id, String? Title, String? white, String? black, String? date, bool? downloaded, String? user}) {
    return MyGames._internal(
      id: id ?? this.id,
      Title: Title ?? this.Title,
      white: white ?? this.white,
      black: black ?? this.black,
      date: date ?? this.date,
      downloaded: downloaded ?? this.downloaded,
      user: user ?? this.user);
  }
  
  MyGames.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _Title = json['Title'],
      _white = json['white'],
      _black = json['black'],
      _date = json['date'],
      _downloaded = json['downloaded'],
      _user = json['user'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'Title': _Title, 'white': _white, 'black': _black, 'date': _date, 'downloaded': _downloaded, 'user': _user, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "myGames.id");
  static final QueryField TITLE = QueryField(fieldName: "Title");
  static final QueryField WHITE = QueryField(fieldName: "white");
  static final QueryField BLACK = QueryField(fieldName: "black");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField DOWNLOADED = QueryField(fieldName: "downloaded");
  static final QueryField USER = QueryField(fieldName: "user");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyGames";
    modelSchemaDefinition.pluralName = "MyGames";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.GROUPS,
        groupClaim: "cognito:groups",
        groups: [ "Users" ],
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.TITLE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.WHITE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.BLACK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.DOWNLOADED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: MyGames.USER,
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

class _MyGamesModelType extends ModelType<MyGames> {
  const _MyGamesModelType();
  
  @override
  MyGames fromJson(Map<String, dynamic> jsonData) {
    return MyGames.fromJson(jsonData);
  }
}