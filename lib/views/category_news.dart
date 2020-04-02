import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latenews/helper/news.dart';
import 'package:latenews/model/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latenews/views/article_view.dart';

class CategoryView extends StatefulWidget {
  final String category;
  CategoryView({this.category});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = new List<ArticleModel>();
  GlobalKey<RefreshIndicatorState> refreshKey;

  bool _loading = true;

  String category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshKey = GlobalKey<RefreshIndicatorState>();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();

    await newsClass.getCategoryNews(widget.category);
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  Future<Null> refreshNews() async {
    await Future.delayed(Duration(seconds: 1));
    getCategoryNews();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Late"),
            Text(
              "News",
              style: TextStyle(color: Color.fromRGBO(249, 151, 26, 1.0)),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromRGBO(249, 151, 26, 1.0),
                ),
              ),
            )
          : RefreshIndicator(
              backgroundColor: Color.fromRGBO(249, 151, 26, 1.0),
              key: refreshKey,
              onRefresh: () async {
                await refreshNews();
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                  children: <Widget>[
                    //news
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NewsTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              publishedAt: articles[index].publishedAt,
                              url: articles[index].url,
                            );
                          }),
                    ),
                    Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text("End of the List",style: TextStyle(
                            color: Color.fromRGBO(249, 151, 26, 1.0),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            
                          ),),
                      ),
                    )
                  ],
                )),
              ),
            ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, publishedAt, url;

  const NewsTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.publishedAt,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      newsUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: 500,
                      height: 200,
                    )),
                Container(
                    padding: EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black26),
                    width: 500,
                    height: 200,
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Date&Time:\n" + publishedAt,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(
                color: Colors.black26,
              ),
            )
          ],
        ),
        
      ),
    );
  }
}
