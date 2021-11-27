class Post {
  String createdAt = "";
  String updatedAt = "";
  int id = 0;
  int userId = 0;
  String title = "";
  String description = "";
  String content = "";

  Post(this.createdAt, this.updatedAt, this.id, this.userId, this.title, this.description, this.content);

  Post.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['content'] = this.content;
    return data;
  }
}