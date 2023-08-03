import "package:arsipdian/models/user.dart";
import "package:arsipdian/services/dio.dart";
import "package:dio/dio.dart" as Dio;
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";



class Auth extends ChangeNotifier{
  bool _isLoggedIn = false;
  User? _user;
  String? _token;

  bool get authenticated => _isLoggedIn;
  User? get user => _user;

  final storage = new FlutterSecureStorage();

  void login({required Map creds}) async {
    print(creds);

    try {
        Dio.Response response = await dio().post('/login', data: creds);
        print(response.data.toString());

        String token = response.data.toString();
        this.tryToken(token: token);

        _isLoggedIn = true;

        notifyListeners();

    }catch(e){
      print(e);
    }


  }

  void tryToken({required String token}) async {
    if (token == null){
      return;
    }else{
      try {
        Dio.Response response = await dio().get('/me', options: Dio.Options(headers: {'Authorization' : 'Bearer $token'}));
        this._isLoggedIn = true;
        this._user = User.fromJson(response.data);
        this._token = token;
        this.storeToken(token: token);

        notifyListeners();
        print(_user);
      }catch(e){
        print(e);
      }
    }
  }

  void storeToken({required String token}) async {
      this.storage.write(key: 'token', value: token);
  }
  void logout() async {

    try {
      Dio.Response response = await dio().post('/logout',
      options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));
      cleanUp();
      notifyListeners();
    }catch(e){
      print(e);
    }

  }

  void cleanUp() async {
    this._user = null;
    this._isLoggedIn = false;
    this._token = null;

    await storage.delete(key: 'token');
  }

  ////////////////////////////Create Post
  void buat({required Map creds}) async {
    print(creds);

    try {
      Dio.Response response = await dio().post('/posts', data: creds,options: Dio.Options(headers: {'Authorization' : 'Bearer $_token'}));


      print(response.data.toString());

      //String token = response.data.toString();
      //this.tryToken(token: token);

      //_isLoggedIn = true;

      //notifyListeners();
    }catch(e){
      print(e);
    }
  }

  void register({required Map creds}) async {
    print(creds);

    try {
      Dio.Response response = await dio().post('/register', data: creds);
      print(response.data.toString());

      String token = response.data.toString();

    }catch(e){
      print(e);
    }


  }

  void hapus({required id}) async {
    print(id);

    try {
      Dio.Response response = await dio().delete('/posts/$id');
      print(response.data.toString());

      String token = response.data.toString();

    }catch(e){
      print(e);
    }


  }

}