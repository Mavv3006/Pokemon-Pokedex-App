import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'constants.dart';

class BaseInformationDatabase {
  final dbName = "pokemonBaseInformation";
  ApiProvider apiProvider;
  Database database;

  BaseInformationDatabase({ApiProvider apiProvider}) {
    _init();

    // init apiProvider
    if (apiProvider != null) {
      this.apiProvider = apiProvider;
    } else {
      this.apiProvider = ApiProvider();
    }
  }

// Init Database ---------------------------------------------------------------

  _init() async {
    // await Sqflite.devSetDebugModeOn(true);
    String databasePath = await getDatabasesPath();
    database = await openDatabase(
      join(databasePath, '$dbName.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        _createLanguages(db);
        _createTypes(db);
        _createPokemons(db);
        _createNames(db);
      },
    );
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
    await db.execute('''
          create table $names (
            $namesPokemonId INTEGER,
            $namesLanguageId INTEGER,
            $namesName TEXT not null,
            primary key ($namesPokemonId, $namesLanguageId),
            constraint fk_language
              foreign key ($namesLanguageId)
              references $languages ($languagesId)
            constraint fk_pokemonId
              foreign key ($namesPokemonId)
              references $pokemons ($pokemonsId)
          )
        ''');
  }

// Download methods ------------------------------------------------------------

  void updateBaseInformation() async {
    print("Download started");
    List<Language> languageList = _downloadLanguages();
    List<PokemonType> typeList = await _downloadTypes();
    List<PokemonBaseInformation> pokemonList = await _downloadPokemons();
    List<Name> nameList = await _downloadNames();
    print("Download finished");
    print("Insert started");
    _insertLanguages(languageList);
    _insertTypes(typeList);
    _insertPokemons(pokemonList);
    _insertNames(nameList);
    print("Insert finished");
  }

  List<Language> _downloadLanguages() {
    return Language.getAll();
  }

  Future<List<PokemonType>> _downloadTypes() async {
    return await apiProvider.getAllTypes();
  }

  Future<List<PokemonBaseInformation>> _downloadPokemons() async {
    return await apiProvider.getBaseInformationForAll();
  }

  Future<List<Name>> _downloadNames() async {
    return await apiProvider.getAllNames();
  }

// Insert methods --------------------------------------------------------------

  Future<void> _insertTypes(List<PokemonType> list) async {
    for (PokemonType type in list) {
      await _insertType(type);
    }
  }

  Future<void> _insertType(PokemonType type) async {
    await database.insert(
      types,
      type.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _insertLanguages(List<Language> list) async {
    for (Language language in list) {
      await _insertLanguage(language);
    }
  }

  Future<void> _insertLanguage(Language language) async {
    await database.insert(
      languages,
      language.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _insertPokemons(List<PokemonBaseInformation> list) async {
    for (PokemonBaseInformation pokemon in list) {
      _insertPokemon(pokemon);
    }
  }

  Future<void> _insertPokemon(PokemonBaseInformation pokemon) async {
    await database.insert(
      pokemons,
      pokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _insertNames(List<Name> list) async {
    for (Name name in list) {
      _insertName(name);
    }
  }

  Future<void> _insertName(Name name) async {
    await database.insert(
      names,
      name.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Read methods ----------------------------------------------------------------

  Future<List<PokemonBaseInformation>> getBaseInformation() async {
    return _readPokemon();
  }

  Future<List<PokemonBaseInformation>> _readPokemon() async {
    final String sql = "SELECT * FROM $pokemons";
    List<Map<String, dynamic>> map = await database.rawQuery(sql);
    List<PokemonBaseInformation> pokemon =
        map.map((e) => PokemonBaseInformation().fromMap(e)).toList();
    return pokemon;
  }

// Helper methods --------------------------------------------------------------

}
