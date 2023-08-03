import 'dart:io';

import 'package:arsipdian/mainpage/mainlist.dart';
import 'package:arsipdian/services/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../percobaan4.dart';
import '../services/auth.dart';

class addData extends StatefulWidget {
  const addData({Key? key}) : super(key: key);

  @override
  State<addData> createState() => _addDataState();
}

class _addDataState extends State<addData> {
  final storage = new FlutterSecureStorage();

  ////////////////////////////////////////
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController _atas_nama = TextEditingController();
  TextEditingController _keterangan = TextEditingController();
  TextEditingController _tanggal = TextEditingController();

  ///////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _atas_nama.text = '';
    _keterangan.text = '';
    _tanggal.text = '';
    readToken();
  }


  @override
  void dispose() {
    _atas_nama.dispose();
    _keterangan.dispose();
    _tanggal.dispose();
    super.dispose();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token!);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Tambahkan Data"),backgroundColor: Colors.transparent,elevation: 0,),
        backgroundColor: Color(0xFFffffff),
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              background_container(context),
              Positioned(
                top: 120,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: (MediaQuery.of(context).size.height)*4/5 ,
                  width: (MediaQuery.of(context).size.width)*18/20,
                  child: Center(
                    child: ListView(
                        children: <Widget> [Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: _formKey2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,bottom: 8.0),
                              child: Column(

                                children: [

                                  SizedBox(height: MediaQuery. of(context).size.height*0.04,),
                                  Text("Masukan Data",style: TextStyle(fontSize: 30,color: Colors.black,),),
                                  SizedBox(height: MediaQuery. of(context).size.height*0.04,),


                                  TextFormField(
                                    decoration: new InputDecoration(
                                        hintText: "Masukan Atas Nama",
                                        labelText: "Atas Nama",
                                        border: new OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(20.0)
                                        )
                                    ),
                                    controller: _atas_nama,
                                    validator: (value) => value!.isEmpty ? 'Masukan Atas Nama ' : null,
                                  ),

                                  new Padding(padding: new EdgeInsets.only(top:20.0)),

                                  TextFormField(
                                      readOnly: true,
                                      decoration: new InputDecoration(
                                          //icon: Icon(Icons.calendar_today),
                                          prefixIcon: Icon(Icons.calendar_today),
                                          hintText: "Masukan Tanggal",
                                          labelText: "Tanggal",
                                          border: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(20.0)
                                          )
                                      ),
                                      onTap: () async {
                                        DateTime? pickeddate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100)
                                        );
                                        if (pickeddate != null){
                                          setState(() {
                                            _tanggal.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                                          });
                                        }
                                      },
                                      controller: _tanggal,
                                      validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
                                  ),

                                  new Padding(padding: new EdgeInsets.only(top:20.0)),

                                  TextFormField(
                                    maxLines: 4,
                                      decoration: new InputDecoration(
                                        alignLabelWithHint: true,
                                          hintText: "Masukan Keterangan",
                                          labelText: "Keterangan",
                                          border: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(20.0)
                                          )
                                      ),
                                      controller: _keterangan,
                                      validator: (value) => value!.isEmpty ? 'Masukan Keterangan' : null
                          ),
                                  SizedBox(height: 20,),

                                  ElevatedButton(
                                      onPressed: (){
                                        //_atas_nama.text=="" ? print("masukan atas nama"): _tanggal.text=="" ? print("Masukan tanggal"):_keterangan.text==""?print("Masukan Keterangan"):

                                        if(_formKey2.currentState!.validate()) {
                                          uploadPDF();
                                        }
                                      },
                                      child: Text("Upload File")),
                                  SizedBox(height: 10,),
                                  Text("Belum punya file yang diupload ?"),

                                  TextButton(
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> percobaan4()));
                                      },
                                      child: Text("Scan dulu Document",style: TextStyle(
                                          color: Colors.blue
                                      ),),)

                                  
                                  /*ElevatedButton(
                                    onPressed: (){

                                      Map createData = {
                                        'atas_nama' : _atas_nama.text,
                                        'keterangan' : _keterangan.text,
                                        'tanggal_pembuatan' : _tanggal.text
                                      };

                                      if(_formKey2.currentState!.validate()){
                                        Provider.of<Auth>(context, listen: false)
                                            .buat(creds:createData);
                                        Navigator.pop(context);
                                      }
                                    },

                                    child: Text("Kirim Data"),),*/
                                ],
                              ),
                            ),
                          ),
                        ),]
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Column background_container(BuildContext context) {
    return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height) / 3,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back,color: Colors.white,)

                            ),
                            Text("Input Data",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),),

                            Icon(
                              Icons.attach_file,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
  }

  //////////////////////////// Body center

/*
  Center(
  child: ListView(
  children: <Widget> [Padding(
  padding: const EdgeInsets.only(top: 20.0),
  child: Form(
  key: _formKey2,
  child: Padding(
  padding: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,bottom: 8.0),
  child: Column(

  children: [

  SizedBox(height: MediaQuery. of(context).size.height*0.04,),
  Text("Masukan Data",style: TextStyle(fontSize: 30,color: Colors.black,),),
  SizedBox(height: MediaQuery. of(context).size.height*0.04,),


  TextFormField(
  decoration: new InputDecoration(
  hintText: "Masukan Atas Nama",
  labelText: "Atas Nama",
  border: new OutlineInputBorder(
  borderRadius: new BorderRadius.circular(20.0)
  )
  ),
  controller: _atas_nama,
  validator: (value) => value!.isEmpty ? 'Masukan Atas Nama ' : null,
  ),

  new Padding(padding: new EdgeInsets.only(top:20.0)),

  TextFormField(
  decoration: new InputDecoration(
  hintText: "Masukan Tanggal",
  labelText: "Tanggal",
  border: new OutlineInputBorder(
  borderRadius: new BorderRadius.circular(20.0)
  )
  ),
  controller: _tanggal,
  validator: (value) => value!.isEmpty ? 'Masukan Tanggal' : null
  ),

  new Padding(padding: new EdgeInsets.only(top:20.0)),

  TextFormField(
  decoration: new InputDecoration(
  hintText: "Masukan Keterangan",
  labelText: "Keterangan",
  border: new OutlineInputBorder(
  borderRadius: new BorderRadius.circular(20.0)
  )
  ),
  controller: _keterangan,
  validator: (value) => value!.isEmpty ? 'Masukan Keterangan' : null
  ),

  ElevatedButton(
  onPressed: (){
  uploadPDF();
  },
  child: Text("Upload File")),
  ElevatedButton(
  onPressed: (){

  Map createData = {
  'atas_nama' : _atas_nama.text,
  'keterangan' : _keterangan.text,
  'tanggal_pembuatan' : _tanggal.text
  };

  if(_formKey2.currentState!.validate()){
  Provider.of<Auth>(context, listen: false)
      .buat(creds:createData);
  Navigator.pop(context);
  }
  },

  child: Text("Kirim Data"),),
  ],
  ),
  ),
  ),
  ),]
  ),
  ),
  */

  ////////////////////////////// body center

  Future uploadPDF() async {
    //var dio = Dio();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? " ");

      String fileName = file.path.split('/').last;
      String filePath = file.path;
      print(fileName);

      FormData data = FormData.fromMap({
        'atas_nama': _atas_nama.text,
        'keterangan': _keterangan.text,
        'tanggal_pembuatan': _tanggal.text,
        'file': await MultipartFile.fromFile(filePath, filename: fileName)
      });

      String? token = await storage.read(key: 'token');
      Provider.of<Auth>(context, listen: false).tryToken(token: token!);
      print(token);

      //Dio.Response response = await dio().post('/posts', data: data,options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}),

      Dio.Response response = await dio().post('/posts',
          data: data,
          options: Dio.Options(headers: {'Authorization': 'Bearer $token'}),
          onSendProgress: (int sent, int total) {
        if(sent == total){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data Terkirim"),
          ));

          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>mainList()));
        }
        print('$sent $total');

      });



      print(response);
    } else {
      print("Result is null");
    }
  }
}
