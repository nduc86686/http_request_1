class Jobs {
  Jobs({
      this.status, 
      this.id, 
      this.company, 
      this.position, 
      this.createdBy, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Jobs.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    company = json['company'];
    position = json['position'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? status;
  String? id;
  String? company;
  String? position;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['company'] = company;
    map['position'] = position;
    map['createdBy'] = createdBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}