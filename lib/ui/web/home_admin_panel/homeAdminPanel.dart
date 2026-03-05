import 'package:diplom/ui/common/theme/styleText.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart' show kIsWeb;
import '../../common/theme/colors.dart';
import '../create_worker/create_worker.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.lightGreen,
      title: Text('Админка', style: context.titleMedium),
    ),
    body: Center(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150,),
            Button(
              backgroundColor: greenButtonMain,
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CreateWorkerPage()),
              ),
              child: Text('Создать работника'),
            ),
          ],
        ),
      ),
    ),
  );
}
