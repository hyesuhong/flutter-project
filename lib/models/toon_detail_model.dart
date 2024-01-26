class ToonDetailModel {
  final String title, about, age, thumb;
  final List<String> genre;

  ToonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'].toString().split(', '),
        age = json['age'],
        thumb = json['thumb'];
}
