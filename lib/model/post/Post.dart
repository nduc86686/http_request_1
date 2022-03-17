class Post {
  Post({
      this.company, 
      this.position,});

  Post.fromJson(dynamic json) {
    company = json['company'];
    position = json['position'];
  }
  String? company;
  String? position;


  //hàm retun ra map đây nè
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company'] = company;
    map['position'] = position;
    return map;
  }

}