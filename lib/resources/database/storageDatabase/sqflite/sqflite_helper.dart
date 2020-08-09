import 'package:path/path.dart';
import 'package:pokemon_pokedex/resources/database/storageDatabase/storage.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static final _dbName = "pokemonBaseInformation.db";
  static final _databaseVersion = 1;

  static Database _database;

  SqfliteHelper._privateContructor();
  static final SqfliteHelper instance = SqfliteHelper._privateContructor();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _init();
    return _database;
  }

  Future<Database> _init() async {
    String databasePath = await getDatabasesPath();
    return await openDatabase(
      join(databasePath, _dbName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    _createLanguages(db);
    _createTypes(db);
    _createPokemons(db);
    _createNames(db);
  }

  _createLanguages(Database db) async {
    await db.execute('''
          CREATE TABLE $languages (
            $languagesId INTEGER PRIMARY KEY,
            $languagesName TEXT NOT NULL ,
            $languagesShortCode TEXT NOT NULL
          )
        ''');
  }

  _createTypes(Database db) async {
    await db.execute('''
          create table $types (
            $typesLanguageId INTEGER,
            $typesTypeId INTEGER,
            $typesName TEXT not null,
            primary key ($typesLanguageId, $typesTypeId),
            constraint fk_language
              foreign key ($typesLanguageId)
              references $languages ($languagesId)
          )
        ''');
  }

  _createPokemons(Database db) async {
    await db.execute('''
          create table $pokemons (
            $pokemonsId INTEGER primary key,
            $pokemonsType1Id TEXT not null,
            $pokemonsType2Id TEXT null,
            $pokemonsFront TEXT not null,
            $pokemonsBack TEXT not null,
            constraint fk_type1
              foreign key ($pokemonsType1Id)
              references $types ($typesTypeId)
            constraint fk_type2
              foreign key ($pokemonsType2Id)
              references $types ($typesTypeId)
          )
        ''');
  }

  _createNames(Database db) async {
    await db.execute(
      '''
        create table $names (
          $namesPokemonId INTEGER not null,
          $namesLanguageId INTEGER not null,
          $namesName TEXT not null,
          primary key ($namesPokemonId, $namesLanguageId, $namesName),
          constraint fk_language
            foreign key ($namesLanguageId)
            references $languages ($languagesId)
          constraint fk_pokemonId
            foreign key ($namesPokemonId)
            references $pokemons ($pokemonsId)
        )
      ''',
    );
  }
}
