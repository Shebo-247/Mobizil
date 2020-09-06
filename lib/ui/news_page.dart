import 'package:flutter/material.dart';
import 'package:mobizil_app/pojo/news_model.dart';
import 'package:mobizil_app/pojo/post_model.dart';
import 'package:mobizil_app/services/services.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Services services = Services();

  Widget displayAllPosts() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              Post post = snapshot.data[index];
              return Container(
                height: 235,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(post.getPostImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.4),
                    ], begin: Alignment.bottomRight),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 15, right: 15),
                      child: Text(
                        post.getPostTitle,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
      future: services.getAllPosts(),
    );
  }

  Widget displayAllNews() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            padding: EdgeInsets.all(5),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (context, index) {
              if (index != null) {
                News news = snapshot.data[index];
                return Container(
                  height: 125,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 110,
                          height: 125,
                          child: Image(
                            image: NetworkImage(news.getImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                news.getTitle,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      news.getDate,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return Container();
            },
          );
        }

        return Container();
      },
      future: services.getAllNews(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 235,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.tealAccent),
            child: displayAllPosts(),
          ),
          Container(
            height: (20 * 125).toDouble() + 10.0,
            width: double.infinity,
            child: displayAllNews(),
          ),
        ],
      ),
    );
  }
}
