import 'package:MechaHelp/ServicesScene/services_scene.dart';
import 'package:MechaHelp/UI/signup.dart';
import 'package:MechaHelp/Utils/googleAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Utils/googleAuth.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

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

    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);

    return Scaffold(

        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
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
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'images/logo.png',
                              width: ScreenUtil.getInstance().setWidth(110),
                              height: ScreenUtil.getInstance().setHeight(110),
                            ),
                            Text('MechaHelp',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: ScreenUtil.getInstance().setSp(46),
                                  letterSpacing: .6,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(180),
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
                            'Login',
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
                          key: const Key('emailKey'),
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
                          key: const Key('passwordKey'),
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
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      ScreenUtil.getInstance().setWidth(12.0),
                                ),
                                GestureDetector(
                                  onTap: _radio,
                                  child: radioButton(_isSelected),
                                ),
                                SizedBox(
                                  width: ScreenUtil.getInstance().setWidth(8.0),
                                ),
                                Text('Remember me',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Poppins-Medium',
                                    )),
                              ],
                            ),
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
                                          key: const Key('signInKey'),
                                          onTap: () {FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                              email: _emailTextController.text,
                                              password: _passwordTextController.text)
                                              .then((value) {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => ServicesScene()));
                                          }).onError((error, stackTrace) {
                                            print("Error ${error.toString()}");
                                          });},
                                          child: Center(
                                              child: Text('SIGNIN',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'Poppins-Bold',
                                                      fontSize: 18.0,
                                                      letterSpacing: 1.0)))))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            horizontalLine(),
                            Text('Social Login',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins-Medium',
                                )),
                            horizontalLine(),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(40),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                         Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            child: Image.asset('images/google.png'),
                            onPressed: () async {
                              final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
                              provider.googleLogIn();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ServicesScene(
                                    ),
                                  ),
                                );
                            }
                          ),
                        ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil.getInstance().setHeight(30),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'New User? ',
                              style: TextStyle(fontFamily: 'Poppins-Medium'),
                            ),
                            InkWell(
                              onTap: () {Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ));
                              },
                              child: Text('SignUp',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    color: Colors.deepOrangeAccent,
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
          ],
        ));
  }
}
