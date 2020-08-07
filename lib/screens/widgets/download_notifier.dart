import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/widgets/pokemon_app_bar.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';
import 'package:provider/provider.dart';

class DownloadNotifier extends StatelessWidget {
  Future<void> _update(StorageProvider storageProvider) async {
    await storageProvider.update();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StorageProvider>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: _update(value),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return child;
            }
            Navigator.pushReplacementNamed(context, Routes.pokedex);
          },
        );
      },
      child: Scaffold(
        backgroundColor: MyColors.DARK_BLUE,
        body: Center(
          child: Container(
            height: 195,
            width: 208,
            decoration: BoxDecoration(
              color: MyColors.BLUE_ACCENT,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Download is\nin progress",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: MyColors.YELLOW,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
