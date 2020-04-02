import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String newsUrl;
  ArticleView({this.newsUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer=
  Completer<WebViewController>();

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
          Opacity(opacity: 0,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save),
          ),
          )
        ],
        elevation: 0.0,
      ),
      body:Container(
      child: WebView(
        initialUrl: widget.newsUrl,
        onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);

        }),
      ),
      )
    );
  }
}
