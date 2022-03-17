import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_request_1/model/JobApi.dart';
import 'package:http_request_1/model/Jobs.dart';
import 'package:http_request_1/model/post/Post.dart';
import 'package:http_request_1/service/service.dart';
import 'package:http_request_1/view/update.dart';

import 'add_data_screen.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  JobApi? jobapi;
  List<Jobs>? jobs;

  //đây là hàm khởi tạo đầu tiên
  TextEditingController edt_1 = TextEditingController();
  TextEditingController edt_2 = TextEditingController();
  Service ?s;
  @override
  void initState() {
    getData();
    super.initState();
  }
  ///B3
  getData() async{
    ///Khởi tạo service
    s = Service();
    await  ///call hàm gọi api
    ///.then ở đây là khi nó thực hiện xong việc call api và trả về giá trị là Object
    ///
    s?.getJob().then((value) {
      print('check ${value}');
      if(value!=null){
        ///*Note bắt buộc phải setState
        setState(() {
          jobapi = value;
          ///[jobs] ở đây đang là 1 list
          jobs = jobapi?.jobs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo get '),
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddDataScreen()),
                );
              },
              child: Icon(Icons.add)),
          InkWell(
              onTap: (){
                s?.getJob().then((value) {
                  if(value!=null){
                    setState(() {
                      jobapi = value;
                      jobs = jobapi?.jobs;
                    });
                  }
                });
              },
              child: Icon(Icons.refresh))
        ],
        backgroundColor: Colors.purple,
      ),
      body: Container(
          child: jobs != null
              ? ListView.builder(
                  ///Số phần tử mảng
                  itemCount: jobs?.length,
                  itemBuilder: (context, int) {
                    ///Item bro tự custom
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'company: ${jobs?[int].company}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'position: ${jobs?[int].position}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'createdAt: ${jobs?[int].createdAt}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'status: ${jobs?[int].status}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,

                                        ///Đoạn này truyền dữ liệu từ màn home qua màn update
                                        MaterialPageRoute(builder: (context) =>  UpdateScreen(position: jobs?[int].position,company: jobs?[int].company,id: jobs?[int].id,)),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    )),

                                InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text('Remove Item'),
                                          content: Text(
                                              'Bạn có muốn xóa item ${jobs?[int].id}'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async{
                                             await  s?.delete(jobs?[int].id!).then((value) {
                                               if(value==true){
                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                   content: Text("Update thành công"),
                                                 ));
                                                 Navigator.pop(context);
                                                 s?.getJob().then((value) {
                                                   print('check ${value}');
                                                   if(value!=null){
                                                     setState(() {
                                                       jobapi = value;
                                                       jobs = jobapi?.jobs;
                                                     });
                                                   }
                                                 });
                                               }
                                               else{
                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                   content: Text("Thất bại"),
                                                 ));
                                               }
                                             });
                                      },
                                              child: const Text('OK'),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Center(
                                        child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ))),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

