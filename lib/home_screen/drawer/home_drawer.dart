import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  static const int categories = 1;

  static const int settings = 2;

  Function onSideMenuItemClick;

  HomeDrawer({required this.onSideMenuItemClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.1),
          color: AppColors.primaryLightColor,
          child: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 2),
          child: InkWell(
            onTap: () {
              onSideMenuItemClick(categories);
            },
            child: Row(
              children: [
                Icon(
                  Icons.list,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onSideMenuItemClick(settings);
          },
          child: Row(
            children: [
              Icon(
                Icons.settings,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
