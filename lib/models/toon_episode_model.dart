class ToonEpisodeModel {
  final String thumb, id, title, rating, date;

  ToonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        date = json['date'],
        rating = json['rating'],
        thumb = json['thumb'];
}
