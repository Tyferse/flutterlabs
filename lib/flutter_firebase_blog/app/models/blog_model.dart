class BlogsModel {
  late String id, title, description;
  late DateTime time;

  BlogsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time});

  BlogsModel.fromJson(String blog_id, Map<String, dynamic> map) {
    id = blog_id;
    title = map['title'];
    description = map['description'];
    time = map['time'].toDate();
  }
}
