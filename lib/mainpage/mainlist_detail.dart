import 'dart:io';

import 'package:arsipdian/mainpage/mainlist.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class MainListDetail extends StatefulWidget {
  //const MainListDetail({Key? key}) : super(key: key);
  late Map idx;
  MainListDetail({required this.idx});



  @override
  State<MainListDetail> createState() => _MainListDetailState(this.idx);
}

class _MainListDetailState extends State<MainListDetail> {

  Map idx;
  _MainListDetailState(this.idx);

  ///////////////////////////////// tutorial save file

  bool loading = false;
  double progress = 0.0;
  final Dio dio = Dio();

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;

    try{
      if(Platform.isAndroid){
        if(await _requestPermission2(Permission.manageExternalStorage)){await _requestPermission2(Permission.manageExternalStorage);}
        if(await _requestPermission(Permission.storage)){
          directory = (await getExternalStorageDirectory())!;


          //storage/emulated/0/Android/data/com.arsipdian.arsipdian/files
          String newPath = "";
          List<String> folders =  directory.path.split("/");

          for(int x = 1 ; x<folders.length; x++){
            String folder = folders[x];
            if (folder != "Android"){
              newPath += "/"+folder;
            }else{
              break;
            }
          }
          newPath = newPath + "/ArsipDian";
          directory = Directory(newPath);
          print(directory.path);
        }else{
          return false;
        }
      }else{
        if(await _requestPermission(Permission.photos)){
          directory = await getTemporaryDirectory();
        }else{
          return false;
        }

      }

      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      if(await directory.exists()){
        File saveFile = File(directory.path+"/$fileName");
        await dio.download(url, saveFile.path,onReceiveProgress: (downloaded,totalSize){
          setState(() {
            progress = downloaded/totalSize;
          });
        });
        if(Platform.isIOS){
          await ImageGallerySaver.saveFile(saveFile.path,isReturnPathOfIOS: true);
        }
        return true;
      }
    }catch(e){
      print(e);
    }
    return false;

  }

  Future<bool> _requestPermission(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();

      if(result == PermissionStatus.granted){
        return true;
      }else {
        return false;
      }
    }

  }

  Future<bool> _requestPermission2(Permission permission) async {
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();

      if(result == PermissionStatus.granted){
        return true;
      }else {
        return false;
      }
    }

  }

  downloadFile(String namaDoc) async {

    setState(() {
      loading = true;
    });
    print("download proses");
    //bool downloaded = await saveFile("https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
    //bool downloaded = await saveFile("http://10.0.2.2/arsipdian/public/api/download/3uzvHdYgIg1wneVq9ZuL4QTnXiF8Kc.jpg", "3uzvHdYgIg1wneVq9ZuL4QTnXiF8Kc.jpg");
    bool downloaded = await saveFile("http://10.0.2.2/arsipdian/public/api/download/$namaDoc", namaDoc);

    if (downloaded){
      print("File downloaded");
    }else{
      print("Problem download file");
    }

    setState(() {
      loading = false;
    });
  }


  ///////////////////////////////// tutorial save file






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
      body: loading ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
          ),
        ),
      ):SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            )
          ],
        ),
      ),
    );
}

  Container main_container() {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              height: 550,
              width: 340,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Atas Nama : "+idx["atas_nama"],style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.bold)),
                  ),
                  Padding(//untuk garis biru
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue,),),),),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Tanggal Pembuatan Akta",style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10),
                        Text(idx["tanggal_pembuatan"]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Keterangan",style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10),
                        Text(idx["keterangan"]),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Document",style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10),
                        Text(idx["document"].toString()),
                        SizedBox(height: 10),
                        idx["document"].toString()=="null" ? ElevatedButton(onPressed: (){}, child: Text("Download"),style: ElevatedButton.styleFrom(primary: Colors.grey),):ElevatedButton(onPressed: (){print(idx["document"]);/*downloade(idx["document"].toString());*/downloadFile(idx["document"].toString());}, child: Text("Download"),style: ElevatedButton.styleFrom(primary: Colors.blue)),
                        //ElevatedButton(onPressed: (){}, child: Text("DownloadFile")),
                      ],
                    ),
                  ),


                ],
              ),
            );
  }

  void downloade(String document_name) async {
    var dio = Dio();
    Directory directory = await getApplicationDocumentsDirectory();
    Directory? directory2 = await getExternalStorageDirectory();

    print(directory);
    print(directory2);
    String path = "http://10.0.2.2/arsipdian/public/api/download/"+document_name;
    print(path);
    var response = await dio.download(path,'${directory.path}/$document_name');
    var response2 = await dio.download(path,'${directory2!.path}/$document_name');
    //var response = await dio.download(path,'${getExternalStorageDirectory()}/$document_name');

    print("ini response status");
    print(response.statusCode);
    print(response2.statusCode);
  }



  Column background_container(BuildContext context) {
    return Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context, MaterialPageRoute(builder: (BuildContext contex){return mainList();}));
                            },
                            child: Icon(Icons.arrow_back,
                            color: Colors.white,),
                          ),
                          Text('Halaman Detail',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),

                          ),Icon(Icons.download,color: Colors.blue,)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}