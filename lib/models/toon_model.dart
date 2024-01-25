class ToonModel {
  final String id, title, thumb;

  // ToonModel({
  //   required this.id,
  //   required this.title,
  //   required this.thumb,
  // });

  ToonModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
}
