
class Post {
  final String title, url;

  Post({
    this.title,
    this.url,
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      url: json["url"],
    );
  }
}