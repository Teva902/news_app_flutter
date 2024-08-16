import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/app_colors.dart';
import 'package:news_app/home_screen/category/web_view.dart';
import 'package:news_app/model/NewsResponse.dart';

class CategoryItemDetails extends StatelessWidget {
  static const String routeName = 'category_item';

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as NewsData;

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
            title: Text('News Title'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fill,
                      imageUrl: args.news.urlToImage ?? '',
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryLightColor,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.whiteColor,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        args.news.author ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.grayColor),
                      ),
                      Text(
                        args.news.title ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        args.news.publishedAt ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.end,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                        ),
                        child: Text(
                          maxLines: 50,
                          args.news.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: AppColors.grayColor),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebView(url: args.news.url ?? ''),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.view_full_page,
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.grayColor),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
    ;
  }
}

class NewsData {
  News news;

  NewsData({
    required this.news,
  });
}
