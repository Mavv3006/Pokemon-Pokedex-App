import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/utils/constants.dart';
import 'package:pokemon_pokedex/utils/routes.dart';
import 'package:provider/provider.dart';

class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  int downloader = 0;

  Future<bool> _isUpToDate(
    ApiProvider apiProvider,
    StorageProvider storageProvider,
  ) async {
    int remoteCount = await apiProvider.pokemonCount;
    int localCount = await storageProvider.getCount();
    return localCount == remoteCount;
  }

  _navigate(
    ApiProvider apiProvider,
    StorageProvider storageProvider,
    BuildContext context,
  ) async {
    if (!await _isUpToDate(apiProvider, storageProvider)) {
      await storageProvider.update();
    }
    Navigator.pushReplacementNamed(context, Routes.pokedex);
  }

  @override
  Widget build(BuildContext context) {
    final storageProvider = Provider.of<StorageProvider>(
      context,
      listen: false,
    );
    final apiProvider = Provider.of<ApiProvider>(
      context,
      listen: false,
    );
    if (downloader == 0) {
      setState(() {
        downloader++;
      });
      _navigate(apiProvider, storageProvider, context);
    }
    return Scaffold(
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
    );
  }
}
