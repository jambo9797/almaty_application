import 'package:almaty_app/ui/question_form/choose_place_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionFormPage extends StatefulWidget {
  @override
  _QuestionFormPageState createState() => _QuestionFormPageState();
}

class _QuestionFormPageState extends State<QuestionFormPage> {
  final TextEditingController _userAddressTextController = TextEditingController();

  bool _isChosen = false;
  String userAddressString = 'Геолокация';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff2C98F0),
        title: Text('Заполните анкету'),
      ),
      body: _isChosen
          ? Container(
              width: w,
              height: h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/success.png',
                        width: w * 0.35,
                      ),
                      Container(
                        width: w * 0.8,
                        margin: EdgeInsets.only(top: 26),
                        child: Text(
                          'Спасибо информация сохранена',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 22, right: 22),
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
                        setState(() {
                          _isChosen = false;
                          print('press');
                        });
                      },
                      child: Center(
                        child: Text(
                          'начать новую анкету'.toUpperCase(),
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
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: TextFormField(

                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Наименование компании",),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        onTap: () {
                          try {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => ChoosePlace()),
                            ).then((value) {
                              Scaffold.of(context).setState(() {
                                _userAddressTextController.text = value;
                                userAddressString = value;
                              });
                              Scaffold.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(content: Text("$value")));
                            });
                          } catch (e) {
                            Scaffold.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(content: Text("$e")));
                          }
                        },
                        readOnly: true,
                        autofocus: false,
                        controller: _userAddressTextController,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: InputDecoration(
                          suffixIcon: new Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xff2C98F0),
                          ),
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
                          labelText: 'Геолокация',
                          hintText: 'Геолокация',
                        ),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        //initialValue: 'Руслан',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Основной ОКЭД",),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Наличие ККМ",
                          showDownButton: true,
                        ),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Вид деятельности",
                          showDownButton: true,
                        ),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Число работников",),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                            labelTextStr: "Участие в госпрограммах",),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 24),
                      child: TextFormField(
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withOpacity(0.42),
                        ),
                        decoration: CommonStyle.textFieldStyle(
                          labelTextStr: "Статус",
                          showDownButton: true,
                        ),
                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
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
                          setState(() {
                            _isChosen = true;
                            print('press');
                          });
                        },
                        child: Center(
                          child: Text(
                            'сохранить'.toUpperCase(),
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
      {String labelTextStr = "",
      String hintTextStr = "",
      bool showDownButton = false}) {
    return InputDecoration(
      suffixIcon: showDownButton
          ? new Icon(
              Icons.arrow_drop_down_sharp,
              size: 20,
              color: Color(0xff666666),
            )
          : null,
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
