import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';
import 'package:sqflite/sqflite.dart';

// TODO: make class work

class PokemonDatabase {
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

  PokemonDatabase({ApiProvider apiProvider}) {
    _init();

    // init apiProvider
    if (apiProvider != null) {
      this.apiProvider = apiProvider;
    } else {
      this.apiProvider = ApiProvider();
    }
  }

  _init() async {
    await Sqflite.devSetDebugModeOn(true);
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

  void updateBaseInformation() async {
    print("database download started");
    List<PokemonBaseInformation> list = await _getInformationFromApi();
    print("database download complete");
    print("database insert started");
    for (PokemonBaseInformation pokemon in list) {
      if (await _pokemonExists(pokemon)) {
        _updatePokemon(pokemon);
      } else {
        _insertPokemon(pokemon);
      }
    }
    print("database insert completed");
  }

  Future<List<PokemonBaseInformation>> _getInformationFromApi() async {
    return await apiProvider.getBaseInformationForAll();
  }

  Future<bool> _pokemonExists(PokemonBaseInformation pokemon) async {
    var result = await database.query(
      _pokemons,
      columns: [_pokemonsId],
      where: '$_pokemonsId = ?',
      whereArgs: [pokemon.id],
    );

    if (result.length == 0) {
      return false;
    }
    return true;
  }

  _insertPokemon(PokemonBaseInformation pokemon) async {
    database.transaction((Transaction txn) async {
      List<Map<String, dynamic>> languages = await txn.query(
        _languages,
        columns: ['count(*)'],
        where: '$_languagesId = ?',
        whereArgs: [pokemon.language.id],
      );
      Map<String, dynamic> language = languages[0];
      int languageCount = language['count(*)'] as int;
      if (languageCount != 1) {
        await txn.insert(
          _languages,
          {
            _languagesId: pokemon.language.id,
            _languagesName: pokemon.language.name,
            _languagesShortCode: pokemon.language.shortCode,
          },
        );
      }
      await txn.insert(
        _types,
        {
          _typesLanguageId: pokemon.language.id,
          _typesName: pokemon.type1.name,
          _typesTypeId: pokemon.type1.id,
        },
      );
      if (pokemon.type2 != null) {
        await txn.insert(
          _types,
          {
            _typesLanguageId: pokemon.language.id,
            _typesName: pokemon.type2.name,
            _typesTypeId: pokemon.type2.id,
          },
        );
      }
      await txn.insert(
        _pokemons,
        {
          _pokemonsId: pokemon.id,
          _pokemonsBack: pokemon.backImage,
          _pokemonsFront: pokemon.frontImage,
          _pokemonsType1Id: pokemon.type1.id,
          _pokemonsType2Id: pokemon.type2 != null ? pokemon.type2.id : null,
        },
      );
      await txn.insert(
        _names,
        {
          _namesLanguageId: pokemon.language.id,
          _namesName: pokemon.name,
          _namesPokemonId: pokemon.id,
        },
      );
    });

    print(await database.rawQuery('SELECT COUNT(*) FROM $_pokemons'));
  }

  _updatePokemon(PokemonBaseInformation pokemon) async {
    //! Not ready yet
    // database.transaction((Transaction txn) async {
    //   await txn.update(
    //     _languages,
    //     {
    //       _languagesId: pokemon.language.id,
    //       _languagesName: pokemon.language.name,
    //       _languagesShortCode: pokemon.language.shortCode,
    //     },
    //   );
    //   await txn.update(
    //     _types,
    //     {
    //       _typesLanguageId: pokemon.language.id,
    //       _typesName: pokemon.type1.name,
    //       _typesTypeId: pokemon.type1.id,
    //     },
    //   );
    //   if (pokemon.type2 != null) {
    //     await txn.update(
    //       _types,
    //       {
    //         _typesLanguageId: pokemon.language.id,
    //         _typesName: pokemon.type2.name,
    //         _typesTypeId: pokemon.type2.id,
    //       },
    //     );
    //   }
    //   await txn.update(
    //     _pokemons,
    //     {
    //       _pokemonsId: pokemon.id,
    //       _pokemonsBack: pokemon.backImage,
    //       _pokemonsFront: pokemon.frontImage,
    //       _pokemonsType1Id: pokemon.type1.id,
    //       _pokemonsType2Id: pokemon.type2 != null ? pokemon.type2.id : null,
    //     },
    //   );
    //   await txn.update(
    //     _names,
    //     {
    //       _namesLanguageId: pokemon.language.id,
    //       _namesName: pokemon.name,
    //       _namesPokemonId: pokemon.id,
    //     },
    //   );
    // });
  }

  /// retrieves the data from the database.
  // Future<PokemonBaseInformation> getBaseInformation(int pokemonId) async {}

  Future<void> _insertTypes() async {
    //TODO
  }
  Future<void> _insertLanguages() async {
    //TODO
  }
}
