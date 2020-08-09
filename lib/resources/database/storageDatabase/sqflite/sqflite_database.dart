import 'package:pokemon_pokedex/models/database_insert_model.dart';
import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/storageDatabase/storage.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase extends StorageProvider {
  ApiProvider apiProvider;

  SqfliteDatabase({this.apiProvider});

// Read methods ----------------------------------------------------------------
  @override
  Future<List<PokemonBaseInformation>> getAll(Language language) async {
    List<Map<String, dynamic>> map = await _readAll(language);
    return _mapToModel(map);
  }

  Future<List<Map<String, dynamic>>> _readAll(Language language) async {
    final String sql = """
      select 	p.$pokemonsId , 
        n.$namesName ,
        p.$pokemonsFront , 
        p.$pokemonsBack,
        t2.$typesTypeId as $pokemonsType1Id,
        t2.$typesName as $typesName1,
        t3.$typesName as $typesName2,
        t3.$typesTypeId as $pokemonsType2Id 
      from $pokemons p 
      inner join $names n on n.$namesPokemonId =p.$pokemonsId 
      inner join $types t2 on t2.$typesTypeId =p.$pokemonsType1Id
      left outer join $types t3 on t3.$typesTypeId =p.$pokemonsType2Id 
      where n.$namesLanguageId = ${language.id} 
        and t2.$typesLanguageId = ${language.id} 
        and (t3.$typesLanguageId =6 or t3.$typesLanguageId is null)
      ORDER BY p.$pokemonsId 
    """;
    Database database = await SqfliteHelper.instance.database;
    return await database.rawQuery(sql);
  }

  List<PokemonBaseInformation> _mapToModel(List<Map<String, dynamic>> map) {
    List<PokemonBaseInformation> pokemon =
        map.map((e) => PokemonBaseInformation().fromMap(e)).toList();
    return pokemon;
  }

// Download methods ------------------------------------------------------------
  @override
  Future<void> update() async {
    print("Download started");
    DatabaseInsertModel model = await _downloadAll();
    print("Download finished");
    print("Insert started");
    await _insertAll(model);
    print("Insert finished");
  }

  Future<DatabaseInsertModel> _downloadAll() async {
    DatabaseInsertModel model = DatabaseInsertModel();
    model.languageList = _downloadLanguages();
    model.typeList = await _downloadTypes();
    model.pokemonList = await _downloadPokemons();
    model.nameList = await _downloadNames();
    return model;
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

  Future<void> _insertAll(DatabaseInsertModel model) async {
    _insertLanguages(model.languageList);
    _insertTypes(model.typeList);
    _insertPokemons(model.pokemonList);
    _insertNames(model.nameList);
  }

  Future<void> _insertTypes(List<PokemonType> list) async {
    for (PokemonType type in list) {
      await _insertType(type);
    }
  }

  Future<void> _insertType(PokemonType type) async {
    Database database = await SqfliteHelper.instance.database;
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
    Database database = await SqfliteHelper.instance.database;
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
    Database database = await SqfliteHelper.instance.database;
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
    Database database = await SqfliteHelper.instance.database;
    await database.insert(
      names,
      name.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// search methods --------------------------------------------------------------

  @override
  Future<List<PokemonBaseInformation>> search(String query) async {
    List<Map<String, dynamic>> map = await _performSearch(query);
    return _mapToSearchModel(map);
  }

  Future<List<Map<String, dynamic>>> _performSearch(String query) async {
    final String sql = """
        SELECT *
        from $names n 
        where n.$namesName like "%$query%" or n.$namesPokemonId like "%$query%"
      """;
    Database database = await SqfliteHelper.instance.database;
    return await database.rawQuery(sql);
  }

  List<PokemonBaseInformation> _mapToSearchModel(
      List<Map<String, dynamic>> map) {
    List<PokemonBaseInformation> list = [];
    for (Map<String, dynamic> map in map) {
      PokemonBaseInformation pokemon =
          PokemonBaseInformation.fromDatabaseSearchResult(map);
      list.add(pokemon);
    }
    return list;
  }

// isUpToDate methods ----------------------------------------------------------
  @override
  Future<int> getCount() async {
    Database database = await SqfliteHelper.instance.database;
    List<Map<String, dynamic>> databaseReturn = await database.query(
      pokemons,
      columns: ['count(*) as sum'],
    );
    Map<String, dynamic> firstValue = databaseReturn[0];
    int sum = firstValue['sum'] as int;
    return sum;
  }

// getMultiple methods ---------------------------------------------------------

  @override
  Future<List<PokemonBaseInformation>> getMultiple(
    int offset,
    int limit,
    Language language,
  ) async {
    final String sql = """
      select 	p.$pokemonsId , 
        n.$namesName ,
        p.$pokemonsFront , 
        p.$pokemonsBack,
        t2.$typesTypeId as $pokemonsType1Id,
        t2.$typesName as $typesName1,
        t3.$typesName as $typesName2,
        t3.$typesTypeId as $pokemonsType2Id 
      from $pokemons p 
      inner join $names n on n.$namesPokemonId = p.$pokemonsId
      inner join $types t2 on t2.$typesTypeId = p.$pokemonsType1Id
      left outer join $types t3 on t3.$typesTypeId = p.$pokemonsType2Id 
      where n.$namesLanguageId = ${language.id} 
        and t2.$typesLanguageId = ${language.id} 
        and (t3.$typesLanguageId =6 or t3.$typesLanguageId is null)
        and p.$pokemonsId > $offset
        and p.$pokemonsId <= ${offset + limit}
      ORDER BY p.$pokemonsId 
    """;
    Database database = await SqfliteHelper.instance.database;
    List<Map<String, dynamic>> map = await database.rawQuery(sql);
    return _mapToModel(map);
  }
}
