///TODO class này dùng để thực hiện các GET,PUT,DELETE,... từ API
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_request_1/contanst/base_url.dart';
import 'package:http_request_1/model/JobApi.dart';
import 'package:http_request_1/model/post/Post.dart';
import 'package:logger/logger.dart';

class Service {
  var logger = Logger();
  ///Tạo method get data từ api
  ///Cái trong <dynamic> là giá trị trả về của api
  ///
  /// /Get All
  Future<JobApi?> getJob() async {
    JobApi jobApi;
    ///khởi tạo Uri
    try {
      Uri uri = Uri.parse(BaseUrl.url);
      ///Gửi yêu cầu HTTP GET với các tiêu đề đã cho đến URL đã cho.
      ///Tham số truyền vào là uri
      final response = await http.get(uri);
      ///sau khi thực hiện xong thi body dạng byte(decode)
      ///
      Map<String, dynamic> mapResponse = json.decode(response.body);
      ///decode xong->>  {"ok":"ok1"}
      ///
      /// Map json to object
      jobApi = JobApi.fromJson(mapResponse);
      logger.v('${jobApi.jobs}');
      return jobApi;
    } catch (e) {
      print(e);
    }
  }
  ///Tiếp phần post nhé;))))))
  ///Create one
  ///
  Future<bool> createPost(Post post) async {
    ///thực hiện request post
    ///Basic là truyền 2 tham số là [Uri] và Body truyền lên
    ///
    /// Khởi tạo objec là kiểu map[post.toJson()]
    // Object body =
    final response =
    /// vì đây là kiểu map<String,dynamic> nên body sẽ [encoding] ở đây mặc định là dạng utf8
    /// ngược lại với get là decode
    await http.post(Uri.parse(BaseUrl.url),  headers: {
      "Content-Type": 'application/json'
    },
        encoding: Encoding.getByName("utf-8"),
        body:json.encode(post.toJson()));
    print('response ${response.request}');

    ///Status code==201 thì tạo thành công
    if (response.statusCode == 201) {
      ///biến true fasle này mình phục vụ cho việc hiển thị bên view
      return true;
    }
    else {
      return false;
    }
  }

  //Cập nhật
  ///Phần này y như post:))))
  Future<bool> updateJobs(Post post,String idJob) async {
    try {
      final response = await http.patch(
        Uri.parse('${BaseUrl.url}/${idJob}'),
          headers: {
            "Content-Type": 'application/json'
          },
          encoding: Encoding.getByName("utf-8"),
          body:json.encode(post.toJson())
        );
      if (response.statusCode == 200) {
        return true;
      }
      else {
        return false;
      }
    }
    catch (e) {
      return false;
    }
  }

  ///Phần này y như post:))))
  //DELETE
  Future<bool> delete(String ?idJob) async {
    try {
      final response = await http.delete(
        Uri.parse('${BaseUrl.url}/${idJob}'),
        encoding: Encoding.getByName("utf-8"),
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      else {
        return false;
      }
    }
    catch (e) {
      return false;
    }
  }
}


