import 'dart:developer';

import 'package:easiestdb/easiestdb.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/resources/database/settingsDatabase/settings_storage.dart';
import 'package:sqflite/sqlite_api.dart';

class EasiestDbDatabase extends SettingsStorageProvider {
  static const _dbName = 'settingsDatabase.db';

  static final _tableName = 'settings'.toUpperCase();
  static final _keyColumnName = 'key'.toUpperCase();
  static final _valueColumnName = 'value'.toUpperCase();

  static const _languageKeyName = 'language';
  static const _pokemonPerPageKeyName = 'pokemonPerPage';

  static const _keyColumnIndex = 1;
  static const _valueColumnIndex = 2;
  static const _tableIndex = 0;

  static final Datum _languageKeyColumn = Datum(
    _keyColumnIndex,
    _languageKeyName,
  );
  static final Datum _pokemonPerPageKeyColumn = Datum(
    _keyColumnIndex,
    _pokemonPerPageKeyName,
  );

  Database _database;
  bool _hasBeenInitialized = false;
  int _languageRowId = 0;
  int _pokemonPerPageRowId = 0;

  @override
  Future<void> init() async {
    _database = await EasiestDb.init(
      dbName: _dbName,
      version: 1,
      dbTables: [
        DbTable(_tableName, dbColumns: [
          DbColumn(_keyColumnName, columnDataType: " TEXT UNIQUE "),
          DbColumn(_valueColumnName, columnDataType: ' Integer '),
        ]),
      ],
    );
    _hasBeenInitialized = true;
  }

// Getter ----------------------------------------------------------------------

  @override
  Future<Language> getActiveLanguage() async {
    if (!_hasBeenInitialized) await init();
    List<Map<String, dynamic>> map = await EasiestDb.getOneRowData(
      _tableIndex,
      _languageRowId,
    );
    var languageId = map[0][_valueColumnName] as int;
    log('languageId: $languageId');
    return Language.fromId(languageId);
  }

  @override
  Future<int> getPokemonPerPageCount() async {
    if (!_hasBeenInitialized) await init();
    List<Map<String, dynamic>> map = await EasiestDb.getOneRowData(
      _tableIndex,
      _pokemonPerPageRowId,
    );
    var pokemonPerPageCount = map[0][_valueColumnName] as int;
    log('pokemonPerPageCount: $pokemonPerPageCount');
    return pokemonPerPageCount;
  }

// Setter ----------------------------------------------------------------------

  @override
  Future<void> setActiveLanguage(Language language) async {
    if (!_hasBeenInitialized) await init();
    try {
      _languageRowId = await EasiestDb.addData(
        _tableIndex,
        [
          _languageKeyColumn,
          Datum(_valueColumnIndex, language.id.toString()),
        ],
      );
    } catch (e) {
      await _setLanguageRowId();
      await updateActiveLanguage(language);
    }
    log('active language has been set to ${language}');
  }

  Future<void> _setLanguageRowId() async {
    List<Map<String, dynamic>> map = await _database.rawQuery(
        "SELECT rowid FROM $_tableName WHERE $_keyColumnName = '$_languageKeyName'");
    print(map.toString());
    _languageRowId = map[0]['ID'] as int;
    log('languageRowId: $_languageRowId');
  }

  @override
  Future<void> setPokemonPerPageCount(int count) async {
    if (!_hasBeenInitialized) await init();
    try {
      _pokemonPerPageRowId = await EasiestDb.addData(
        _tableIndex,
        [
          _pokemonPerPageKeyColumn,
          Datum(_valueColumnIndex, count.toString()),
        ],
      );
    } catch (e) {
      await _setPokemonPerPageRowId();
      await updatePokemonPerPageCount(count);
    }
    log('current pokemonPerPageCount has been set to ${count}');
  }

  Future<void> _setPokemonPerPageRowId() async {
    List<Map<String, dynamic>> map = await _database.rawQuery(
        "SELECT rowid FROM $_tableName WHERE $_keyColumnName = '$_pokemonPerPageKeyName'");
    print(map.toString());
    _pokemonPerPageRowId = map[0]['ID'] as int;
    log('pokemonPerPageRowId: $_pokemonPerPageRowId');
  }

// Updater ---------------------------------------------------------------------

  @override
  Future<void> updateActiveLanguage(Language language) async {
    await EasiestDb.updateOneDataById(
      _tableIndex,
      _languageRowId,
      [
        Datum(
          _valueColumnIndex,
          language.id.toString(),
        ),
      ],
    );
    log('active language has been updated to ${language.id}');
  }

  @override
  Future<void> updatePokemonPerPageCount(int count) async {
    await EasiestDb.updateOneDataById(
      _tableIndex,
      _pokemonPerPageRowId,
      [
        Datum(
          _valueColumnIndex,
          count.toString(),
        ),
      ],
    );
    log('current pokemonPerPageCount has been updated to ${count}');
  }
}
