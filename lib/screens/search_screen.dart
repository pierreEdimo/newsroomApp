import 'package:flutter/material.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_saved_word.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/saved_word_service.dart';
import 'package:newsroom/utilities/constants.dart';
import 'package:newsroom/widget/custom_app_bar.dart';
import 'package:newsroom/widget/list_of_articles.dart';
import 'package:newsroom/widget/list_of_saved_words.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  Future<List<Article>>? _articles;
  SavedWordService service = SavedWordService();
  Future<List<Article>> _fechtArticles(
    context,
    String url,
  ) async {
    return await Provider.of<ArticleService>(context, listen: false)
        .fetchArticles(url);
  }

  @override
  void initState() {
    super.initState();
  }

  _search(String searchWord) async {
    searchWord = _controller.text;
    setState(() {
      _articles = _fechtArticles(context,
          "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}");
    });
  }

  _saveWord() async {
    var userId = await storage.read(key: "userId");
    AddSavedWord newWord = AddSavedWord(userId: userId, word: _controller.text);
    await Provider.of<SavedWordService>(context, listen: false)
        .addSevedWord(newWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          Container(
            padding: horizontalPadding,
            child: TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.search,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "search...",
                border: InputBorder.none,
                prefixIcon: IconButton(
                  onPressed: () => Navigator.of(context).pop() ,
                  icon: Icon(Icons.keyboard_arrow_left_outlined),
                ) ,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.text = "";
                    });
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              onChanged: (value) => _search(value),
              onFieldSubmitted: (value) {
                _search(value);
                _saveWord();
              },
            ),
          ),
      ),
      body: _controller.text.isEmpty
          ? Container(
              child: ListOFSavedWords(
                controller: _controller,
              ),
            )
          : listOfArticles(
              _articles!,
              "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}",
              "Sorry , we did not find an Article with the title ${_controller.text}",
              context),
    );
  }
}
