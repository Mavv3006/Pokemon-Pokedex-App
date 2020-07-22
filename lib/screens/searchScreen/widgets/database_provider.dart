import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/database/base_information_database.dart';

class DatabaseProvider extends InheritedWidget {
  final BaseInformationDatabase database;

  DatabaseProvider({this.database, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DatabaseProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
}
