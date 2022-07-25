class PostsModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as int?;
    id = json['id'] as int?;
    title = json['title'] as String?;
    body = json['body'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userId'] = userId;
    json['id'] = id;
    json['title'] = title;
    json['body'] = body;
    return json;
  }
}