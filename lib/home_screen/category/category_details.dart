import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home_screen/tabs/tabs_widget.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  Category category;

  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var provide = Provider.of<AppConfigProvider>(context);
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(
        widget.category.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryLightColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('Something went wrong'),
              ElevatedButton(
                  onPressed: () {
                    ApiManager.getSources(
                      widget.category.id,
                    );
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueColor),
                  child: Text(
                    'Try Again',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColors.whiteColor),
                  ))
            ],
          );
        }
        if (snapshot.data!.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data!.message!),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(
                    widget.category.id,
                  );
                  setState(() {});
                },
                child: Text(
                  'Try Again',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.whiteColor),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor),
              )
            ],
          );
        }
        var sourceList = snapshot.data!.sources!;
        return TabsWidget(sourceList: sourceList);
      },
    );
  }
}
