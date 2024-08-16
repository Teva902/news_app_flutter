import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home_screen/news/news_item.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  Source source;

  NewsWidget({required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late AppConfigProvider provider;
  final ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreNews();
      }
    });
  }

  Future<void> loadMoreNews() async {
    if (isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });
    provider.changePageNumber(provider.page + 1);

    try {
      await ApiManager.getNewsBySourceId(
          widget.source.id ?? '', provider.page, provider.search);
    } catch (error) {
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);

    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(
          widget.source.id ?? '', provider.page, provider.search),
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
                  ApiManager.getNewsBySourceId(
                      widget.source.id ?? '', provider.page, provider.search);
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
                ),
              )
            ],
          );
        }

        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(snapshot.data?.message ?? 'Error'),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getNewsBySourceId(
                      widget.source.id ?? '', provider.page, provider.search);
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
              ),
            ],
          );
        }

        var newsList = snapshot.data?.articles ?? [];

        return ListView.builder(
          controller: scrollController,
          itemCount: newsList.length + 1,
          itemBuilder: (context, index) {
            if (index < newsList.length) {
              return NewsItem(news: newsList[index]);
            } else if (isLoadingMore) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryLightColor,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
