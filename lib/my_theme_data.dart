import 'package:flutter/material.dart';
import 'package:news_app/app_colors.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLightColor,
      appBarTheme: AppBarTheme(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryLightColor,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)))),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
          titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
          bodyMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
          bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: AppColors.grayColor),
          headlineSmall: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.grayColor),
          titleSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor)));
}
