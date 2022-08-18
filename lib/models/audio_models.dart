class AudioModel {
  String title;
  String date;

  AudioModel({
    required this.title,
    required this.date,
  });

  Map toMap() {
    return {
      "title": title,
      "date": date,
    };
  }

  factory AudioModel.fromMap(Map audio) => AudioModel(
        title: audio["title"],
        date: audio["date"],
      );
}
