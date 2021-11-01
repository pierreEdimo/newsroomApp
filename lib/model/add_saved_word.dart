class AddSavedWord {
  final String? userId;
  final String? word;

  AddSavedWord({this.userId, this.word});

  factory AddSavedWord.fromJson(Map<String, dynamic> json) => AddSavedWord(
        userId: json['userId'] as String,
        word: json['word'] as String,
      );

  Map<String, dynamic> toJson() => {"userId": userId, "word": word};
}
