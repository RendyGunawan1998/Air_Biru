class Banners {
  int id;
  String displayScore;
  String title;
  String image;
  Null extraImage;
  String description;
  String actionUrl;
  String actionUrlLabel;
  String type;
  String createdAt;
  String updatedAt;
  // List<Null> bannerItems;

  Banners({
    required this.id,
    required this.displayScore,
    required this.title,
    required this.image,
    required this.extraImage,
    required this.description,
    required this.actionUrl,
    required this.actionUrlLabel,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    // this.bannerItems
  });

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['id'],
      displayScore: json['display_score'],
      title: json['title'],
      image: json['image'],
      extraImage: json['extra_image'],
      description: json['description'],
      actionUrl: json['action_url'],
      actionUrlLabel: json['action_url_label'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
    // if (json['banner_items'] != null) {
    //   bannerItems = new List<Null>();
    //   json['banner_items'].forEach((v) {
    //     bannerItems.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_score'] = this.displayScore;
    data['title'] = this.title;
    data['image'] = this.image;
    data['extra_image'] = this.extraImage;
    data['description'] = this.description;
    data['action_url'] = this.actionUrl;
    data['action_url_label'] = this.actionUrlLabel;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.bannerItems != null) {
    //   data['banner_items'] = this.bannerItems.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
