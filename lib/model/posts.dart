class Posts {
  int id;
  String title;
  String description;
  String type;
  String actionUrl;
  String actionUrlLabel;
  String image;
  String extraImage;
  String createdAt;
  String updatedAt;
  // List<Null> postItems;

  Posts({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.actionUrl,
    required this.actionUrlLabel,
    required this.image,
    required this.extraImage,
    required this.createdAt,
    required this.updatedAt,
    // this.postItems
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      actionUrl: json['action_url'],
      actionUrlLabel: json['action_url_label'],
      image: json['image'],
      extraImage: json['extra_image'] ?? "exaample.png",
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
    // if (json['post_items'] != null) {
    //   postItems = new List<Null>();
    //   json['post_items'].forEach((v) {
    //     postItems.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['action_url'] = this.actionUrl;
    data['action_url_label'] = this.actionUrlLabel;
    data['image'] = this.image;
    data['extra_image'] = this.extraImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.postItems != null) {
    //   data['post_items'] = this.postItems.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
