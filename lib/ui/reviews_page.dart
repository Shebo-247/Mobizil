import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {

  @override
  void initState() {
    super.initState();

    print('Page Reviews Loaded ...');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Reviews Page'),
      ),
    );
  }
}