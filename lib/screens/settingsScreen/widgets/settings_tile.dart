import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SettingsTile extends StatelessWidget {
  final String leading;
  final String activeSetting;

  const SettingsTile({
    Key key,
    this.leading,
    this.activeSetting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(const Radius.circular(20)),
          boxShadow: kElevationToShadow[3],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leading,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: MyColors.DARK_BLUE,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      activeSetting,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Color(0xA3003A70),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: MyColors.DARK_BLUE,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
