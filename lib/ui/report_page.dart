import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:almaty_app/ui/question_form/choose_place_screen.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String dropdownValue;
  bool _isChosen = false;
  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        //useRootNavigator: true,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Сообщить'),
      ),
      body:  _isChosen
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
                    'Спасибо за Ваше сообщение',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Container(
                  width: w * 0.6,
                  margin: EdgeInsets.only(top: 26),
                  child: Text(
                    'Ваше обращение принято в обработку',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.42)),
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
                    'начать новое сообщение'.toUpperCase(),
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
          : Container(
        width: w,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 38),
                width: w,
                height: 35,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  itemHeight: 100.0,
                  hint: Text('Выбрать тип обращения', style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.42)),),
                  isExpanded: true,
                  isDense: true,
                  iconSize: 24,
                  elevation: 1,
                  underline: Container(
                    height: 1,
                    color: dropdownValue == null
                        ? Colors.black.withOpacity(0.42)
                        : Color(0xff2C98F0),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>[
                    'Простаивающие здания',
                    'Стихийные свалки',
                    'Земли самозахвата',
                    'Другое'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.42)),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 6),
                  child: Form(
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
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
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
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
                        contentPadding: EdgeInsets.only(top: 4, bottom: 8),
                        labelText: "Описание",
                      ),
                      validator: (value) {
                        if (value.length == 0)
                          return ("Comments can't be empty!");

                        return value = null;
                      },
                    ),
                  ),
                ),
              ),
              Container(

                width: w,
                height: 50,
                margin: EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(width: 1, color: Colors.black.withOpacity(0.42)),
                  color: Colors.white
                ),
                child: InkWell(
                  onTap: (){
                    _showPicker(context);
                  },
                  child: Center(
                    child: Text(
                      'прикрепить фото'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff2C98F0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: w,
                height: 50,
                margin: EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:
                    Border.all(width: 1, color: Colors.black.withOpacity(0.42)),
                    color: Colors.white
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChoosePlace()));
                  },
                  child: Center(
                    child: Text(
                      'выбрать локацию'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff2C98F0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24, top: 52),
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
