import 'package:diplom/ui/common/theme/styleText.dart';
import 'package:flutter/material.dart';

import '../common/theme/colors.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Админка',
        style: context.titleMedium,),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){},
            child: Text('Создать Работника')
        ),
      ),
    );
  }
}

