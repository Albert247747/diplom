import 'package:diplom/ui/common/widgets/button/menu_card_buttons.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import '../../common/theme/colors.dart';
import '../../common/theme/style_text.dart';
import '../create_event/create_event.dart';
import '../create_worker/create_worker.dart';
import '../shifts_list/shifts_list.dart';
import '../worker_list/worker_list.dart';

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
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/hotel.png",
                          fit: BoxFit.cover,
                        ),
                        Container(color: Colors.black.withValues(alpha: 0.35)),
                      ],
                    ),
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
                        text: context.t.web.listWorker,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkerList(),
                              ),
                            ),

                        /// TODO поправить иконку
                        iconPath: "assets/icons/icons_list_users.svg",
                      ),
                      SizedBox(width: 15),
                      CardButton(
                        text: context.t.web.createWorkerButton,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateWorkerPage(),
                              ),
                            ),
                        iconPath: "assets/icons/icons_add_users.svg",
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardButton(
                        text: context.t.web.createEventButton,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateEventPage(),
                              ),
                            ),
                        iconPath: "assets/icons/icons_list_users.svg",
                      ),
                      SizedBox(width: 15),
                      CardButton(
                        text: context.t.web.eventList,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShiftsList(),
                              ),
                            ),

                        /// TODO поправиьт иконку
                        iconPath: "assets/icons/icons_list_users.svg",
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
