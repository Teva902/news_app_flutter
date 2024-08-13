import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/app_colors.dart';

class Category {
  String id;

  String title;

  String imagePath;

  Color color;

  Category(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.color});

  static List<Category> getCategories(BuildContext context) {
    return [
      Category(
          id: 'sports',
          title: AppLocalizations.of(context)!.sports,
          imagePath: 'assets/images/ball.png',
          color: AppColors.redColor),
      Category(
          id: 'general',
          title: AppLocalizations.of(context)!.general,
          imagePath: 'assets/images/Politics.png',
          color: AppColors.darkBlueColor),
      Category(
          id: 'health',
          title: AppLocalizations.of(context)!.health,
          imagePath: 'assets/images/health.png',
          color: AppColors.pinkColor),
      Category(
          id: 'business',
          title: AppLocalizations.of(context)!.business,
          imagePath: 'assets/images/bussines.png',
          color: AppColors.brownColor),
      Category(
          id: 'entertainment',
          title: AppLocalizations.of(context)!.entertainment,
          imagePath: 'assets/images/environment.png',
          color: AppColors.blueColor),
      Category(
          id: 'science',
          title: AppLocalizations.of(context)!.science,
          imagePath: 'assets/images/science.png',
          color: AppColors.yellowColor),
      Category(
          id: 'technology',
          title: AppLocalizations.of(context)!.technology,
          imagePath: 'assets/images/bussines.png',
          color: AppColors.darkBlueColor),
    ];
  }
}
