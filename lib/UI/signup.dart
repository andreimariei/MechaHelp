import 'package:MechaHelp/ServicesScene/services_scene.dart';
import 'package:MechaHelp/UI/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();


  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  Widget build(BuildContext context)  {
    future: Firebase.initializeApp();
    ScreenUtil.instance =
    ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            leading: IconButton(icon:Icon(Icons.arrow_back),
              //onPressed:() => Navigator.pop(context, false),
              color: Colors.black,
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));},
            )
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset('images/image_01.png')),
                Expanded(
                  child: Container(),
                ),
                Image.asset('images/image_02.png'),
              ],
            ),
            SingleChildScrollView(
                child: Padding(
                    padding:
                    EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(400),
                        ),
                    Container(
                    width: double.infinity,
                        height: ScreenUtil.getInstance().setHeight(500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0,
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0,
                            ),

                          ],
                        ),

                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  'Signup',
                                  style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(45),
                                    fontFamily: 'Poppins-Bold',
                                    letterSpacing: .6,
                                  )
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Text(
                                  'E-mail',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                  )
                              ),
                              TextField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                    hintText: 'e-mail',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 )
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Text(
                                  'Password',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                  )
                              ),
                              TextField(
                                obscureText: true,
                                controller: _passwordTextController,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0 )
                                ),
                              ),

                            ],
                          ),
                        )
                    ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  width: ScreenUtil.getInstance().setWidth(300),
                                  height:
                                  ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.deepOrangeAccent,
                                      Colors.redAccent
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        Colors.deepOrangeAccent.withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0,
                                      )
                                    ],
                                  ),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                              email: _emailTextController.text,
                                              password: _passwordTextController.text)
                                              .then((value) {
                                            print("Created New Account");
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => ServicesScene()));
                                          }).onError((error, stackTrace) {
                                            print("Error ${error.toString()}");
                                          });},
                                          child: Center(
                                              child: Text('SIGNUP',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                      'Poppins-Bold',
                                                      fontSize: 18.0,
                                                      letterSpacing: 1.0)))))),
                            )
                          ],
                        ),


                      ],
                    ))),
          ],
        ));
  }
}
