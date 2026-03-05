import 'package:diplom/ui/common/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotAuthorized extends StatelessWidget {
  const NotAuthorized({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: mainBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width < 1200 ? size.width * 0.9 : 1200,
            maxHeight: size.height < 800 ? size.height * 0.9 : 800,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width < 600 ? 20 : 160,
              vertical: size.height < 600 ? 20 : 60,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 62),
                  Text(
                    'Данная роль не подходит для авторизации на web-сайте.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Пожалуйста войдите через мобильное приложение.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 62),
                  SizedBox(
                    height: 60,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: size.width < 400 ? size.width * 0.6 : 400,
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: mainGreen,
                        ),
                        child: Text(
                          'Назад',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
