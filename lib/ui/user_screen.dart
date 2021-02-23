import 'package:almaty_app/ui/login_page/login_screen.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      width: w,
                      height: 135,
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 16,
                      ),
                      color: Color(0xff2C98F0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: w * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Должность',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Берик Берикович',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: PopupMenuButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                              onSelected: (value) {
                                if(value == 5){
                                  Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),ModalRoute.withName('/'),);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text('Изменить данные'),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text('Настройка'),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Text('Помощь'),
                                ),
                                PopupMenuItem(
                                  value: 4,
                                  child: Divider(),
                                ),
                                PopupMenuItem(
                                  value: 5,
                                  child: Text('Выйти', style: TextStyle(color: Color(0xffF03B3B)),),
                                ),
                              ],
                            ),
                          ),
                          /*Icon(
                            Icons.more_vert_rounded,
                            size: 25,
                            color: Colors.white,
                          ),*/
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //color: Colors.grey,
                          color: Colors.grey,
                        ),
                        //child: Image.network('https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                height: 30,
                margin: EdgeInsets.only(top: 20, left: 16),
                child: Text(
                  'Информация по округу №2',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff2C98F0),
                  ),
                ),
              ),
              Container(
                width: w,
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Площадь, м',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '5,2К',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Население, чел ',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '20 455',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Улицы',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '46',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Количество домов',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '1 849',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Частные дома',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '1752',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: w * 0.5 - 20,
                          padding:
                              EdgeInsets.only(left: 16, top: 12, bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.039),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(
                                    0, 0.25), // changes position of shadow
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.19),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(
                                    0, 0.85), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Организации',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '50',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
