import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home_screen/category/category_details.dart';
import 'package:news_app/home_screen/category/category_fragment.dart';
import 'package:news_app/home_screen/drawer/home_drawer.dart';
import 'package:news_app/home_screen/settings/settings.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppConfigProvider>(context);

    return Stack(
      children: [
        Container(
          color: AppColors.whiteColor,
          child: Image.asset(
            'assets/images/pattern.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: isSearching && selectedCategory != null
                ? TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                    onChanged: (value) {
                      provider.changeSearch(value);
                    },
                  )
                : Text(
                    selectedMenuItem == HomeDrawer.settings
                        ? AppLocalizations.of(context)!.settings
                        : selectedCategory == null
                            ? AppLocalizations.of(context)!.app_title
                            : selectedCategory!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
            actions: selectedCategory != null
                ? [
                    IconButton(
                      icon: Icon(isSearching ? Icons.cancel : Icons.search),
                      onPressed: () {
                        setState(() {
                          if (isSearching) {
                            isSearching = false;
                            searchController.clear();
                            provider.changeSearch('');
                          } else {
                            isSearching = true;
                          }
                        });
                      },
                    ),
                  ]
                : [],
          ),
          drawer: Drawer(
            child: HomeDrawer(
              onSideMenuItemClick: onSideMenuItemClick,
            ),
          ),
          body: selectedMenuItem == HomeDrawer.settings
              ? Settings()
              : selectedCategory == null
                  ? CategoryFragment(
                      onCategoryItemClick: onCategoryItemClick,
                    )
                  : CategoryDetails(
                      category: selectedCategory!,
                    ),
        )
      ],
    );
  }

  Category? selectedCategory;

  void onCategoryItemClick(Category newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }

  int selectedMenuItem = HomeDrawer.categories;

  void onSideMenuItemClick(int newSideMenuItem) {
    selectedMenuItem = newSideMenuItem;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
