import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/resources/api/api_provider.dart';
import 'package:pokemon_pokedex/resources/database/storage_provider.dart';
import 'package:pokemon_pokedex/screens/widgets/download_notifier.dart';
import 'package:pokemon_pokedex/utils/routes.dart';
import 'package:provider/provider.dart';

class Download extends StatefulWidget {
  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  Future<bool> _isUpToDate(
    ApiProvider apiProvider,
    StorageProvider storageProvider,
  ) async {
    int remoteCount = await apiProvider.pokemonCount;
    return await storageProvider.isUpToDate(remoteCount) == false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StorageProvider, ApiProvider>(
      builder: (
        BuildContext context,
        StorageProvider storageProvider,
        ApiProvider apiProvider,
        Widget child,
      ) {
        return FutureBuilder(
          future: _isUpToDate(apiProvider, storageProvider),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data as bool) {
                Navigator.pushReplacementNamed(context, Routes.pokedex);
              } else {
                return DownloadNotifier();
              }
            }

            print('failed state');
            return Container();
          },
        );
      },
    );
  }
}
