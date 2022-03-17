import 'Jobs.dart';

class JobApi {
  JobApi({
      this.jobs, 
      this.count,});

  JobApi.fromJson(dynamic json) {
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(Jobs.fromJson(v));
      });
    }
    count = json['count'];
  }
  ///
  List<Jobs>? jobs;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jobs != null) {
      map['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}