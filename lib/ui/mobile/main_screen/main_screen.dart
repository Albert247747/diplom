import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/main_screen/widgets/vacancy_item.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      appBar: AppBar(
        title: Text(
          context.t.mobile.shifts,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: mainBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 65),
        child: Column(children: [VacancyItem()]),
      ),
    );
  }
}
