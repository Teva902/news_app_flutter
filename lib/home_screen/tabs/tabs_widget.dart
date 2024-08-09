import 'package:flutter/material.dart';
import 'package:news_app/home_screen/news/news_widget.dart';
import 'package:news_app/home_screen/tabs/tab_item.dart';
import 'package:news_app/model/SourceResponse.dart';

class TabsWidget extends StatefulWidget {
  List<Source> sourceList;

  TabsWidget({required this.sourceList});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.sourceList.length,
        child: Column(
          children: [
            TabBar(
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                tabs: widget.sourceList
                    .map((source) => TabItem(
                        isSelected:
                            selectedIndex == widget.sourceList.indexOf(source),
                        source: source))
                    .toList()),
            Expanded(
                child: NewsWidget(source: widget.sourceList[selectedIndex]))
          ],
        ));
  }
}
