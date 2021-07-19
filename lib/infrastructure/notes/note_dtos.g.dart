// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteDto _$_$_NoteDtoFromJson(Map<String, dynamic> json) {
  return _$_NoteDto(
    body: json['body'] as String,
    todos: (json['todos'] as List)
        ?.map((e) =>
            e == null ? null : TodoItemDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    serverTimeStamp:
        const ServerTimestampConverter().fromJson(json['serverTimeStamp']),
    color: json['color'] as int,
  );
}

Map<String, dynamic> _$_$_NoteDtoToJson(_$_NoteDto instance) =>
    <String, dynamic>{
      'body': instance.body,
      'todos': instance.todos?.map((e) => e?.toJson())?.toList(),
      'serverTimeStamp':
          const ServerTimestampConverter().toJson(instance.serverTimeStamp),
      'color': instance.color,
    };

_$_TodoItemDto _$_$_TodoItemDtoFromJson(Map<String, dynamic> json) {
  return _$_TodoItemDto(
    id: json['id'] as String,
    name: json['name'] as String,
    done: json['done'] as bool,
  );
}

Map<String, dynamic> _$_$_TodoItemDtoToJson(_$_TodoItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'done': instance.done,
    };
