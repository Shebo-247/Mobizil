import 'package:flutter/material.dart';

import 'package:mobizil_app/ui/news_page.dart';
import 'package:mobizil_app/ui/brands_page.dart';
import 'package:mobizil_app/ui/reviews_page.dart';
import 'package:mobizil_app/widgets/nav_item.dart';
import 'package:mobizil_app/pojo/navigation_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> bottomNavWidgets = [
    NewsPage(),
    BrandsPage(),
    ReviewsPage(),
  ];
  List<NavigationItem> navItems = [
    NavigationItem(icon: Icon(Icons.rss_feed), title: Text('News')),
    NavigationItem(icon: Icon(Icons.phone_iphone), title: Text('Brands')),
    NavigationItem(icon: Icon(Icons.rate_review), title: Text('Reviews')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobizil'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navItems.map((navItem) {
            int currentIndex = navItems.indexOf(navItem);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = currentIndex;
                });
              },
              child: BuildNavItem(navItem, _selectedIndex == currentIndex),
            );
          }).toList(),
        ),
      ),
      body: bottomNavWidgets[_selectedIndex],
    );
  }
}
