// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $PassTable extends Pass with TableInfo<$PassTable, Pas> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _binaryPassMeta =
      const VerificationMeta('binaryPass');
  @override
  late final GeneratedColumn<Uint8List> binaryPass = GeneratedColumn<Uint8List>(
      'binary_pass', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, binaryPass];
  @override
  String get aliasedName => _alias ?? 'pass';
  @override
  String get actualTableName => 'pass';
  @override
  VerificationContext validateIntegrity(Insertable<Pas> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('binary_pass')) {
      context.handle(
          _binaryPassMeta,
          binaryPass.isAcceptableOrUnknown(
              data['binary_pass']!, _binaryPassMeta));
    } else if (isInserting) {
      context.missing(_binaryPassMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pas map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pas(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      binaryPass: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}binary_pass'])!,
    );
  }

  @override
  $PassTable createAlias(String alias) {
    return $PassTable(attachedDatabase, alias);
  }
}

class Pas extends DataClass implements Insertable<Pas> {
  final String id;
  final Uint8List binaryPass;
  const Pas({required this.id, required this.binaryPass});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['binary_pass'] = Variable<Uint8List>(binaryPass);
    return map;
  }

  PassCompanion toCompanion(bool nullToAbsent) {
    return PassCompanion(
      id: Value(id),
      binaryPass: Value(binaryPass),
    );
  }

  factory Pas.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pas(
      id: serializer.fromJson<String>(json['id']),
      binaryPass: serializer.fromJson<Uint8List>(json['binaryPass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'binaryPass': serializer.toJson<Uint8List>(binaryPass),
    };
  }

  Pas copyWith({String? id, Uint8List? binaryPass}) => Pas(
        id: id ?? this.id,
        binaryPass: binaryPass ?? this.binaryPass,
      );
  @override
  String toString() {
    return (StringBuffer('Pas(')
          ..write('id: $id, ')
          ..write('binaryPass: $binaryPass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, $driftBlobEquality.hash(binaryPass));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pas &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.binaryPass, this.binaryPass));
}

class PassCompanion extends UpdateCompanion<Pas> {
  final Value<String> id;
  final Value<Uint8List> binaryPass;
  final Value<int> rowid;
  const PassCompanion({
    this.id = const Value.absent(),
    this.binaryPass = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PassCompanion.insert({
    required String id,
    required Uint8List binaryPass,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        binaryPass = Value(binaryPass);
  static Insertable<Pas> custom({
    Expression<String>? id,
    Expression<Uint8List>? binaryPass,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (binaryPass != null) 'binary_pass': binaryPass,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PassCompanion copyWith(
      {Value<String>? id, Value<Uint8List>? binaryPass, Value<int>? rowid}) {
    return PassCompanion(
      id: id ?? this.id,
      binaryPass: binaryPass ?? this.binaryPass,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (binaryPass.present) {
      map['binary_pass'] = Variable<Uint8List>(binaryPass.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PassCompanion(')
          ..write('id: $id, ')
          ..write('binaryPass: $binaryPass, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PassTable pass = $PassTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pass];
}
