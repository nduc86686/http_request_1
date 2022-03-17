import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_request_1/model/post/Post.dart';
import 'package:http_request_1/service/service.dart';

class UpdateScreen extends StatefulWidget {

  ///Quên khôn truyền id))))
  final String ?company;
  final String ?position;
  final String ?id;
  const UpdateScreen({Key? key,required this.company,required this.position,required this.id}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<UpdateScreen> {


  TextEditingController controller_company=TextEditingController();
  TextEditingController controller_position=TextEditingController();
  String company='';
  String position='';
  Service? service;
  @override
  void initState() {
    ///B1:Khởi tạo thằng servive
    service=Service();
    controller_company.text=widget.company!;
    controller_position.text=widget.position!;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Update Data'),),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller_company,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company',
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: controller_position,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Position',
              ),
            ),
            SizedBox(height: 20,),

            ///TODO dùng inkwell để sử dụng các thao tác như ontap,onpress,.... vào view
            InkWell(
              onTap: (){
                ///:lấy giá trị từ ô nhập liệu
                company=controller_company.text.trim();
                position=controller_position.text.trim();
                ///B2:Thực hiện gọi hàm post
                Post post=Post(position: controller_position.text.trim(),company: controller_company.text.trim());
                ///TODO chỗ này thay api update thui
                service?.updateJobs(post,widget.id!).then((value){
                  print(value);
                  ///sau khi thực hiện post hàm sẽ trả về 2 giá true or false
                  ///nếu true -->> thành công ngược lại thất bại:)))
                  ///ở đây true cho tớ tạm showToas nhé
                  if(value==true){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Update thành công"),
                    ));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Thất bại"),
                    ));
                  }
                });


              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Text('Add Job'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
