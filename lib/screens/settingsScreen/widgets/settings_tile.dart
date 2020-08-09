import 'package:flutter/material.dart';
import 'package:pokemon_pokedex/utils/constants.dart';

class SettingsTile extends StatelessWidget {
  final String leading;
  final String activeSetting;
  final VoidCallback onPressed;

  const SettingsTile({
    Key key,
    this.leading,
    this.activeSetting,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
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
                          fontSize: 15,
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
    );
  }
}
