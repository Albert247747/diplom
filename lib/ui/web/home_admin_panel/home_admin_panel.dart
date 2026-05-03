import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/common/widgets/button/menu_card_buttons.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import '../../common/theme/colors.dart';
import '../../common/theme/style_text.dart';
import '../create_event/create_event.dart';
import '../create_worker/create_worker.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
    body: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 400,
          minHeight: 600,
          maxWidth: 900,
          maxHeight: 700,
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Center(
                  child: Image.asset(
                    "assets/images/hotel.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.t.web.adminPanel,
                    style: context.titleMedium.copyWith(color: whiteColor),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardButton(
                          text: context.t.web.createWorkerButton,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateWorkerPage(),
                            ),
                          ),
                          iconPath: "icons/icons_add_users.svg"
                      ),
                      SizedBox(width: 15,),
                      CardButton(
                          text: context.t.web.createEventButton,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateEventPage(),
                            ),
                          ),
                          iconPath: "icons/icons_list_users.svg",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
