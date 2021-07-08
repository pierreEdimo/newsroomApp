import 'package:flutter/material.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  Future<List<Article>>? _articles;

  Future<List<Article>> _fechtArticles(
    context,
    String url,
  ) async {
    return await Provider.of<ArticleService>(context, listen: false)
        .fetchArticles(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.keyboard_arrow_left_outlined),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                    hintText: "search...",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = "";
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    value = _controller.text;
                    setState(() {
                      _articles = _fechtArticles(context,
                          "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}");
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        120.0,
      ),
      body: _controller.text.isEmpty
          ? Container()
          : listOfArticles(
              _articles!,
              "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}",
              context),
    );
  }
}
