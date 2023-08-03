import 'package:arsipdian/input/addData.dart';
import 'package:arsipdian/mainpage/mainlist.dart';
import 'package:arsipdian/percobaan4.dart';
import 'package:arsipdian/screens/login_screen.dart';
import 'package:arsipdian/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final storage = new FlutterSecureStorage();
  bool authBool = false;



  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token!);
    print(token);
    if(token == null) {
      authBool = false;
      print("token null");
    }else{
      authBool = true;
      print("token tidak null");
    }
    print(authBool);

  }

  @override
  void initState() {
    super.initState();
    readToken();
  }


  //untuk drawer open dan close
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      /*appBar: AppBar(
        title: Text('Arsip'),
      ),*/
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),

                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      IconButton(
                        //Icons.dashboard,
                        icon: Icon(Icons.menu,size: 30,),
                        //size: 30,
                        color: Colors.white,
                        //onPressed: () => Scaffold.of(context).openDrawer(),
                        onPressed: () => _key.currentState!.openDrawer(),
                      ),
                      Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.blue,
                      )
                    ],),

                    SizedBox(height: 20,),
                    Padding(
                        padding: EdgeInsets.only(left: 3,bottom: 15),
                      child: Text("Hai, Staff Notaris!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,wordSpacing: 2,
                            color: Colors.white
                      ),),
                    ),

                  ],
                ),
              ),


              Padding(
                  padding: EdgeInsets.only(top: 30,left: 30,right: 30),
                  child: Column(

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            InkWell(
                              onTap: (){


                                //authBtn != "" ? Navigator.push(context, MaterialPageRoute(builder: (context) => mainList())):
                                authBool ? Navigator.push(context, MaterialPageRoute(builder: (context) => mainList())):
                                _key.currentState!.openDrawer()
                                ;

                                //Navigator.push(context, MaterialPageRoute(builder: (context) => mainList()));

                                },
                              child: Column(
                                children: [
                                  Container(
                                  height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF6FE08D),
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Icon(Icons.search,color: Colors.white, size: 30),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Cari Data",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7)
                                    ),),],),
                            ),

                          InkWell(
                            onTap: (){

                              authBool ? Navigator.push(context, MaterialPageRoute(builder: (context) => percobaan4())):
                              _key.currentState!.openDrawer()
                              ;

                              //Navigator.push(context, MaterialPageRoute(builder: (context) => percobaan4()))
                              ;},
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF61BDFD),
                                      shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: Icon(Icons.assignment,color: Colors.white, size: 30),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Scan Dokumen",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.7)
                                  ),),],),
                          ),

                          InkWell(
                            onTap: (){

                              authBool ? Navigator.push(context, MaterialPageRoute(builder: (context) => addData())):
                              _key.currentState!.openDrawer()
                              ;

                              },
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFC7F7F),
                                      shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: Icon(Icons.store,color: Colors.white, size: 30),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Input Data",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.7)
                                  ),),],),
                          ),


                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              _key.currentState!.openDrawer();
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFC7F7F),
                                      shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: Icon(Icons.power_settings_new,color: Colors.white, size: 40),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.7)
                                  ),),],),
                          ),
                        ],
                      )



                      //////////////////////inkwell
                      /*GridView.builder(
                        //itemCount: daftarNama.length,
                        itemCount: 4,
                        shrinkWrap:true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1
                          ),
                          itemBuilder: (context, index){

*/

                          /*return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => daftarNav[index]));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: daftarWarna[index],
                                    shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: daftarIcon[index],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  daftarNama[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.7)
                                  ),

                                ),
                              ],
                            ),
                          );},*/
                            ////////////////////////////////inkwell


                      ,SizedBox(height: 10,),





                    ],
                  ),

              ),


            ],

          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/3,
              padding: EdgeInsets.only(top: 15,left: 15,right: 15),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),

                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 3,bottom: 15),
                    child: Column(
                      children: [
                        Text("Jangan Lupa berdoa dan",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,wordSpacing: 2,
                              color: Colors.white
                          ),),
                        Text("Semangat Bekerja !!",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,wordSpacing: 2,
                              color: Colors.white
                          ),),
                      ],
                    ),

                  ),

                ],
              ),
            ),
          ),
        ],
      ),



        //////////////////////////////////////DRAWER
      drawer: Drawer(
        child: Consumer<Auth>(builder: (context, auth,child){
          if (! auth.authenticated){
            return ListView(
              children: [
                ListTile(
                  title: Text("Login"),
                  leading: Icon(Icons.login),
                  onTap: () async{

                    authBool = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                    //Navigator.of(context).pop(MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height/3,),
                Center(child: Text("Harap Login Dulu", style: TextStyle(
                  fontSize: 22,fontWeight: FontWeight.w600
                ),))
              ],
            );
          }else{
            return ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset("assets/image/logoad.png"
                        ,width: 50,height: 50,
                      ),
                      /*CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),*/
                      SizedBox(height: 10,),
                      Text(auth.user!.username.toString(),style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))
                  ),
                ),

                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout,color: Colors.blue,),
                  onTap: (){
                    Provider.of<Auth>(context, listen: false)
                        .logout();
                    authBool = false;
                    /*setState(() {
                      authBool;
                    });*/
                  },
                )
              ],
            );
          }

        }),
      ),
      ////////////////////////////////DRAWER


    );
  }




}

//////////////////////////////List View

/*ListView(
children: <Widget>[
Image.asset("assets/image/ils.png"),
Center(
child: Text('Home Screen')
),
ElevatedButton(
onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
},
child: Text('Login')),

ElevatedButton(
onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> mainList()));
},
child: Text('Searching data')),

ElevatedButton(onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> percobaan2()));
}, child: Text("Percobaan")),

ElevatedButton(onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> addData()));
}, child: Text("Add Data")),

ElevatedButton(onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> percobaan3()));
}, child: Text("Pick Picture")),

ElevatedButton(onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=> percobaan4()));
}, child: Text("Pick Picture 2"))


],
),*/
///////////////////////////////List View
