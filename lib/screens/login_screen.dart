import 'package:arsipdian/screens/home_screen.dart';
import 'package:arsipdian/screens/register.dart';
import 'package:arsipdian/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Login page",style: GoogleFonts.caveat(fontSize: 50,color: Colors.blue,fontWeight: FontWeight.w700))),
              Image.asset("assets/image/ils3.png",height: 280,fit: BoxFit.cover,),
              SizedBox(height: 20,),
              TextFormField(
                decoration:new InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  labelText: 'Masukan Username',
                  prefixIcon: Icon(Icons.person)
                ),
                controller: _usernameController,
                validator: (value) => value!.isEmpty ? 'please enter valid username' : null
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration:new InputDecoration(

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    labelText: 'Masukan Passwordnya',
                    //prefixIcon: prefixIcon??Icon(Icons.done),
                    prefixIcon: Icon(Icons.key)



                  ),
                  controller: _passwordController,
                  validator: (value) => value!.isEmpty ? 'please enter valid password' : null
              ),


              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun ?"),
                  TextButton(onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: Register()));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Register()));
                  }, child: Text("Buat akun")),
                ],
              ),

              ElevatedButton(

                  onPressed: (){

                    Map creds = {
                      'username' : _usernameController.text,
                      'password' : _passwordController.text
                    };

                    if(_formKey.currentState!.validate()){
                      Provider.of<Auth>(context, listen: false)
                          .login(creds:creds);
                      Navigator.pop(context,true);
                      //Navigator.pop(MaterialPageRoute(builder: (context)=>HomeScreen(boleh:"boleh")));
                    }
                  },
                  child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),




              ),
            ],
          ),
        ),
      ),
    );
  }
}

