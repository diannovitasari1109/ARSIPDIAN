import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _namaawal = TextEditingController();
  TextEditingController _namaakhir = TextEditingController();

  final _formState = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    _namaawal.text = '';
    _namaakhir.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _namaawal.dispose();
    _namaakhir.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formState,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Center(child: Text("Register page",style: GoogleFonts.caveat(fontSize: 50,color: Colors.blue,fontWeight: FontWeight.w700))),
              SizedBox(height: 30,),
              Image.asset("assets/image/log.png",height: MediaQuery.of(context).size.height*0.2,),
              SizedBox(height: 30,),
              TextFormField(
                  decoration:new InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Masukan Username',
                      prefixIcon: Icon(Icons.person)
                  ),
                  controller: _usernameController,
                  validator: (value) => value!.isEmpty ? 'Tolong masukan username' : null
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration:new InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Masukan Passwordnya',
                      prefixIcon: Icon(Icons.key)
                  ),
                  controller: _passwordController,
                  validator: (value) => value!.isEmpty ? 'Tolong masukan password' : null
              ),

              SizedBox(height: 20,),
              TextFormField(
                  decoration:new InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Masukan Firstname',
                      prefixIcon: Icon(Icons.person_outline)
                  ),
                  controller: _namaawal,
                  validator: (value) => value!.isEmpty ? 'Tolong masukan nama awal' : null
              ),

              SizedBox(height: 20,),
              TextFormField(
                  decoration:new InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Masukan Lastname',
                      prefixIcon: Icon(Icons.person_outline)
                  ),
                  controller: _namaakhir,
                  validator: (value) => value!.isEmpty ? 'Tolong masukan nama akhir' : null
              ),

              SizedBox(height: 20,),

              ElevatedButton(

                onPressed: (){

                  Map creds = {
                    'username' : _usernameController.text,
                    'password' : _passwordController.text,
                    'firstname' : _namaawal.text,
                    'lastname' : _namaakhir.text
                  };

                  if(_formState.currentState!.validate()){
                    Provider.of<Auth>(context, listen: false)
                        .register(creds:creds);
                    Navigator.pop(context,true);
                  }
                },
                child: Text("Daftar",style: TextStyle(color: Colors.white,fontSize: 18),),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),




              ),
            ],
          ),
        ),
      ),


    );
  }
}
