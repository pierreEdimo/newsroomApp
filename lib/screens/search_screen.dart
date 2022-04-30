import 'package:flutter/material.dart';
import 'package:newsroom/main.dart';
import 'package:newsroom/model/add_saved_word.dart';
import 'package:newsroom/model/article.dart';
import 'package:newsroom/service/article_service.dart';
import 'package:newsroom/service/saved_word_service.dart';
import 'package:newsroom/widget/arrow_back_button.dart';
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

  Future<List<Article>> _fetchArticles(
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
      _articles = _fetchArticles(context,
          "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}");
    });
  }

  _saveWord() async {
    var userId = await storage.read(key: "userId");
    AddSavedWord newWord = AddSavedWord(userId: userId, word: _controller.text);
    await Provider.of<SavedWordService>(context, listen: false)
        .addSavedWord(newWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: ArrowBackButton(),
        title: Container(
          width: double.infinity,
          height: 45.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          child: Center(
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              autofocus: true,
              textInputAction: TextInputAction.search,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "search...",
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.text = "";
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
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
      ),
      body: _controller.text.isEmpty
          ? Container(
              child: ListOFSavedWords(
                controller: _controller,
              ),
            )
          // : listOfArticles(
          //     _articles!,
          //     "https://newsplace.azurewebsites.net/api/Articles/Filter?Title=${_controller.text}",
          //     "Sorry , we did not find an Article with the title ${_controller.text}",
          //     context),
          : SingleChildScrollView(
              child: FutureBuilder(
                future: _articles,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasError)
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  if (snapshot.hasData) {
                    List<Article> articles = snapshot.data!;
                    return ListOfArticles(
                      height: MediaQuery.of(context).size.height * 0.8,
                      shrinkwrap: true,
                      articles: articles,
                      msg:
                          "Sorry , we did not find an Article with the title ${_controller.text}",
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
    );
  }
}
