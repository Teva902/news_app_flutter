import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/home_screen/category/category_item.dart';
import 'package:news_app/model/category.dart';

class CategoryFragment extends StatefulWidget {
  Function onCategoryItemClick;

  CategoryFragment({required this.onCategoryItemClick});

  @override
  State<CategoryFragment> createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  late var categoriesList;

  @override
  Widget build(BuildContext context) {
    categoriesList = Category.getCategories(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.categories_title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  widget.onCategoryItemClick(categoriesList[index]);
                },
                child: CategoryItem(
                  category: categoriesList[index],
                  index: index,
                ),
              );
            },
            itemCount: categoriesList.length,
          ))
        ],
      ),
    );
  }
}
