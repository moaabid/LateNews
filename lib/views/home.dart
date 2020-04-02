import 'package:flutter/material.dart';
import 'package:latenews/helper/data.dart';
import 'package:latenews/helper/news.dart';
import 'package:latenews/model/article_model.dart';
import 'package:latenews/model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:latenews/views/article_view.dart';
import 'package:latenews/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  GlobalKey<RefreshIndicatorState> refreshKey;

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    refreshKey = GlobalKey<RefreshIndicatorState>();

    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  Future<Null> refreshNews() async {
    await Future.delayed(Duration(seconds: 1));
    getNews();
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
              backgroundColor:  Color.fromRGBO(249, 151, 26, 1.0),
              key: refreshKey,
              onRefresh: () async {
                await refreshNews();
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 1),
                        child: Text(
                          'Categories :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),

                      //Categories
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          height: 70,
                          child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryTile(
                                  imageAsset: categories[index].imageAsset,
                                  categoryName: categories[index].categoryName,
                                );
                              })),
                       Container(
                        padding: EdgeInsets.only(top: 16),
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 1),
                        child: Text(
                          'Top Headlines :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      //news
                      Container(
                        padding: EdgeInsets.only(top: 5),
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
                  ),
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageAsset, categoryName;

  CategoryTile({this.imageAsset, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(
                      category: categoryName.toLowerCase(),
                    )));
      },
      
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                imageAsset,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black26),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
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
