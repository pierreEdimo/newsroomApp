import 'package:flutter/material.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_saved_word.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/saved_word_service.dart';
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
        SafeArea(
          child: Padding(
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
                    autofocus: true,
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
                    onChanged: (value) => _search(value),
                    onFieldSubmitted: (value) {
                      _search(value);
                      _saveWord();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        80.0,
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
