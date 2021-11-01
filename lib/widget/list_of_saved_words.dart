import 'package:flutter/material.dart';
import 'package:newsroom/service/saved_word_service.dart';
import 'package:newsroom/widget/saved_word_container.dart';
import 'package:provider/provider.dart';

class ListOFSavedWords extends StatefulWidget {
  final TextEditingController? controller;
  const ListOFSavedWords({Key? key, this.controller}) : super(key: key);

  @override
  _ListOFSavedWordsState createState() => _ListOFSavedWordsState();
}

class _ListOFSavedWordsState extends State<ListOFSavedWords> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SavedWordService>(context, listen: false)
          .fetchSavedWords(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          List<String> words = snapshot.data!;

          return words.length < 1
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                      left: 25.0,
                    ),
                    child: Text(
                      "There are no search yet",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    left: 25.0,
                    right: 25.0,
                  ),
                  children: words
                      .map(
                        (String savedWord) => InkWell(
                          onTap: () {
                            setState(() {
                              widget.controller!.text = savedWord;
                            });
                          },
                          child: savedWordContainer(savedWord),
                        ),
                      )
                      .toList(),
                );
        }
        return Container();
      },
    );
  }
}
