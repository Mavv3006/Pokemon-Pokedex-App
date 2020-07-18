import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/models/language.dart';

class LanguageProvider extends ChangeNotifier {
  final Language german = Language.german();
  final Language english = Language.english();
  Language _active;

  LanguageProvider() : _active = Language.german();

  changeLanguageTo(Language language) {
    this._active = language;
    notifyListeners();
  }

  get active => _active;
}
