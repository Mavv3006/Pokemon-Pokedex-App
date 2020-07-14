import 'package:pokemon_pokedex/models/utility/pokemon_base_information.dart';
import 'package:pokemon_pokedex/resources/api_provider.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDatabase {
  final dbName = "pokemonBaseInformation";
  final ApiProvider apiProvider = ApiProvider();
  Database database;

  // table names
  final String _names = 'names';
  final String _pokemons = 'pokemons';
  final String _types = 'types';
  final String _languages = 'languages';

  // column names
  final String _namesPokemonId = 'names.pokemonId';
  final String _namesLanguageId = 'names.languageId';
  final String _namesName = 'names.name';

  final String _languagesId = 'languages.id';
  final String _languagesShortCode = 'languages.shortCode';
  final String _languagesName = 'languages.name';

  final String _typesTypeId = 'types.typeId';
  final String _typesLanguageId = 'types.languageId';
  final String _typesName = 'types.name';

  final String _pokemonsId = 'pokemons.id';
  final String _pokemonsBack = 'pokemons.back';
  final String _pokemonsFront = 'pokemons.front';
  final String _pokemonsType1Id = 'pokemons.type1Id';
  final String _pokemonsType2Id = 'pokemons.type2Id';

  PokemonDatabase() {
    _init();
  }

  _init() async {
    database = await openDatabase(
      '$dbName.db',
      onCreate: (Database db, int version) {
        db.execute('''
          create table $_languages (
            $_languagesId integer primary key ,
            $_languagesName text not null,
            $_languagesShortCode text not null
          )
        ''');
        db.execute('''
          create table $_types (
            $_typesLanguageId integer primary key,
            $_typesTypeId integer primary key,
            $_typesName text not null,
            constraint fk_language
              foreign key ($_typesLanguageId)
              references $_languages ($_languagesId)
          )
        ''');
        db.execute('''
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
        db.execute('''
          create table $_names (
            $_namesPokemonId integer primary key,
            $_namesLanguageId integer primary key,
            $_namesName text not null,
            constraint fk_language
              foreign key ($_namesLanguageId)
              references $_languages ($_languagesId)
            constraint fk_pokemonId
              foreign key ($_namesPokemonId)
              references $_pokemons ($_pokemonsId)
          )
        ''');
      },
    );
  }

  updateBaseInformation() async {
    List<PokemonBaseInformation> list = await _getInformationFromApi();

    for (PokemonBaseInformation pokemon in list) {
      if (await _pokemonExists(pokemon)) {
        _updatePokemon(pokemon);
      } else {
        _insertPokemon(pokemon);
      }
    }
  }

  Future<List<PokemonBaseInformation>> _getInformationFromApi() async {}

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
      await txn.insert(
        _languages,
        {
          _languagesId: pokemon.language.id,
          _languagesName: pokemon.language.name,
          _languagesShortCode: pokemon.language.shortCode,
        },
      );
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

  Future<PokemonBaseInformation> getBaseInformation(int pokemonId) async {}
}
