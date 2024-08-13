import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home_screen/news/news_item.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsBySourceId(
          widget.source.id ?? '',
        ),
        builder: (context, snapshot) {
          {
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
                        ApiManager.getNewsBySourceId(
                          widget.source.id ?? '',
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
                      ApiManager.getNewsBySourceId(
                        widget.source.id ?? '',
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
            var newsList = snapshot.data!.articles!;
            return ListView.builder(
              itemBuilder: (context, index) {
                return NewsItem(news: newsList[index]);
              },
              itemCount: newsList.length,
            );
          }
        });
  }
}
