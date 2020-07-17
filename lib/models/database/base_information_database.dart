import 'package:pokemon_pokedex/models/language.dart';
import 'package:pokemon_pokedex/models/pokemon/name.dart';
import 'package:pokemon_pokedex/models/pokemon/pokemon_type.dart';
import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';
import 'package:sqflite/sqflite.dart';

class BaseInformationDatabase {
  final dbName = "pokemonBaseInformation";
  ApiProvider apiProvider;
  Database database;

  // table names
  final String _names = 'names';
  final String _pokemons = 'pokemons';
  final String _types = 'types';
  final String _languages = 'languages';

  // column names
  final String _namesPokemonId = 'names_pokemonId';
  final String _namesLanguageId = 'names_languageId';
  final String _namesName = 'names_name';

  final String _languagesId = 'languages_id';
  final String _languagesShortCode = 'languages_shortCode';
  final String _languagesName = 'languages_name';

  final String _typesTypeId = 'types_typeId';
  final String _typesLanguageId = 'types_languageId';
  final String _typesName = 'types_name';

  final String _pokemonsId = 'pokemons_id';
  final String _pokemonsBack = 'pokemons_back';
  final String _pokemonsFront = 'pokemons_front';
  final String _pokemonsType1Id = 'pokemons_type1Id';
  final String _pokemonsType2Id = 'pokemons_type2Id';

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
    database = await openDatabase(
      '$dbName.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_languages (
            $_languagesId INTEGER PRIMARY KEY,
            $_languagesName TEXT NOT NULL ,
            $_languagesShortCode TEXT NOT NULL
          )
        ''');
        await db.execute('''
          create table $_types (
            $_typesLanguageId integer,
            $_typesTypeId integer,
            $_typesName text not null,
            primary key ($_typesLanguageId, $_typesTypeId),
            constraint fk_language
              foreign key ($_typesLanguageId)
              references $_languages ($_languagesId)
          )
        ''');
        await db.execute('''
          create table $_pokemons (
            $_pokemonsId integer primary key,
            $_pokemonsType1Id text not null,
            $_pokemonsType2Id text null,
            $_pokemonsFront text not null,
            $_pokemonsBack text not null,
            constraint fk_type1
              foreign key ($_pokemonsType1Id)
              references $_types ($_typesTypeId)
            constraint fk_type2
              foreign key ($_pokemonsType2Id)
              references $_types ($_typesTypeId)
          )
        ''');
        await db.execute('''
          create table $_names (
            $_namesPokemonId integer,
            $_namesLanguageId integer,
            $_namesName text not null,
            primary key ($_namesPokemonId, $_namesLanguageId),
            constraint fk_language
              foreign key ($_namesLanguageId)
              references $_languages ($_languagesId)
            constraint fk_pokemonId
              foreign key ($_namesPokemonId)
              references $_pokemons ($_pokemonsId)
          )
        ''');
        print("database init complete");
      },
    );
  }

// Download methods ------------------------------------------------------------

  void updateBaseInformation() async {
    List<Language> languageList = _downloadLanguages();
    List<PokemonType> typeList = await _downloadTypes();
    List<PokemonBaseInformation> pokemonList = await _downloadPokemons();
    List<Name> nameList = await _downloadNames();
    _insertLanguages(languageList);
    _insertTypes(typeList);
    _insertPokemons(pokemonList);
    _insertNames(nameList);
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
      _types,
      {
        _typesTypeId: type.id,
        _typesLanguageId: Language.german()..id,
        _typesName: type.name,
      },
    );
  }

  Future<void> _insertLanguages(List<Language> list) async {
    for (Language language in list) {
      await _insertLanguage(language);
    }
  }

  Future<void> _insertLanguage(Language language) async {
    await database.insert(
      _languages,
      {
        _languagesId: language.id,
        _languagesShortCode: language.shortCode,
        _languagesName: language.name,
      },
    );
  }

  Future<void> _insertPokemons(List<PokemonBaseInformation> list) async {
    for (PokemonBaseInformation pokemon in list) {
      _insertPokemon(pokemon);
    }
  }

  Future<void> _insertPokemon(PokemonBaseInformation pokemon) async {
    await database.insert(
      _pokemons,
      {
        _pokemonsBack: pokemon.backImage,
        _pokemonsFront: pokemon.frontImage,
        _pokemonsId: pokemon.id,
        _pokemonsType1Id: pokemon.type1.id,
        _pokemonsType2Id: pokemon.type2 != null ? pokemon.type2.id : null,
      },
    );
  }

  Future<void> _insertNames(List<Name> list) async {
    for (Name name in list) {
      _insertName(name);
    }
  }

  Future<void> _insertName(Name name) async {
    await database.insert(
      _names,
      {
        _namesLanguageId: name.languageId,
        _namesName: name.name,
        _namesPokemonId: name.pokemonId,
      },
    );
  }

// Helper methods --------------------------------------------------------------

  // Future<bool> _pokemonExists(PokemonBaseInformation pokemon) async {
  //   var result = await database.query(
  //     _pokemons,
  //     columns: [_pokemonsId],
  //     where: '$_pokemonsId = ?',
  //     whereArgs: [pokemon.id],
  //   );

  //   if (result.length == 0) {
  //     return false;
  //   }
  //   return true;
  // }
}
