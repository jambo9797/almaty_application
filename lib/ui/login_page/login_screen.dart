import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:almaty_app/ui/navbar/navbar_class.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameTextController = TextEditingController();

  final TextEditingController _userPasswordTextController =
      TextEditingController();

  String passwordText;
  bool _correct = false;
  String emailText;

  setDataToCheck({String password, String email}) {
    setState(() {
      if (password != null) passwordText = password;
      if (email != null) emailText = email;
      if(passwordText == "123456" && emailText == "test@mail.com") _correct = true;
      print(passwordText);
      print(emailText);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w,
                      height: h * 0.5,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Arc(
                            arcType: ArcType.CONVEX,
                            height: 31.0,
                            child: new Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              width: w,
                              height: h * 0.5 - 50,
                              color: Color(0xff2C98F0),
                            ),
                          ),
                          Container(
                            height: h * 0.5 - 82,
                            width: w,
                            alignment: Alignment.topCenter,
                            child: Arc(
                              arcType: ArcType.CONVEX,
                              height: 31.0,
                              child: Image.asset(
                                'assets/images/background_image.png',
                                height: h * 0.5 - 70,
                                width: w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Column(
                              children: [
                                /*Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 21,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Logo name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: h * 0.28,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        autovalidate: true,
                        child: TextFormField(
                          onChanged: (value) {
                            setDataToCheck(email: value);
                          },
                          autofocus: false,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          controller: _userNameTextController,
                          //initialValue: 'Руслан',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withOpacity(0.42),
                          ),
                          decoration: CommonStyle.textFieldStyle(
                              labelTextStr: "Логин",
                              hintTextStr: "Введите логин"),
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'email is required'),
                              EmailValidator(errorText: 'incorrect email'),
                              // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Form(
                        autovalidate: true,
                        child: TextFormField(
                          onChanged: (value) {
                            setDataToCheck(password: value);
                          },
                          autofocus: false,
                          obscureText: true,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          controller: _userPasswordTextController,
                          //initialValue: 'Руслан',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.42),
                          ),
                          decoration: CommonStyle.textFieldStyle(
                              labelTextStr: "Пароль",
                              hintTextStr: "Введите пароль"),
                          validator: MultiValidator(
                            [
                              RequiredValidator(
                                  errorText: 'password is required'),
                              MinLengthValidator(6, errorText: "too short"),
                              // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            child: Text(
                              'Забыли пароль?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff2C98F0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 22, right: 22, bottom: 50),
                width: w,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xffFFB03A),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFFB03A).withOpacity(0.14),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Color(0xffFFB03A).withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                    BoxShadow(
                      color: Color(0xffFFB03A).withOpacity(0.20),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    if (_correct)
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (context) => TabsPage()));
                    else {
                      print('sdsd');
                      Fluttertoast.showToast(
                          msg: "Invalid data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Center(
                    child: Text(
                      'войти'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonStyle {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xff000000).withOpacity(0.42),
      ),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xff000000).withOpacity(0.42),
      ),
      isDense: true,
      contentPadding: EdgeInsets.only(top: 4, bottom: 8),
      labelText: labelTextStr,
      hintText: hintTextStr,
    );
  }
}
