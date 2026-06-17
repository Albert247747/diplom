import 'package:diplom/ui/common/bloc/auth/auth_cubit.dart';
import 'package:diplom/ui/common/widgets/button/menu_card_buttons.dart';
import 'package:diplom/ui/web/settings/settings.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/theme/colors.dart';
import '../../common/theme/style_text.dart';
import '../create_event/create_event.dart';
import '../create_worker/create_worker.dart';
import '../shifts_list/shifts_list.dart';
import '../worker_list/worker_list.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Spacer(),
          IconButton(
            onPressed: () {
              final authCubit = context.read<CubitAuth>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsWeb(onLogout: authCubit.logout),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 620;
            final horizontalPadding = isCompact ? 16.0 : 32.0;
            final cardPadding = isCompact ? 12.0 : 24.0;
            final buttonWidth =
                isCompact
                    ? constraints.maxWidth -
                        horizontalPadding * 2 -
                        cardPadding * 2
                    : 180.0;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: isCompact ? 16 : 32,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Container(
                    constraints: BoxConstraints(minHeight: isCompact ? 0 : 600),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(isCompact ? 18 : 25),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: EdgeInsets.all(cardPadding),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    "assets/images/hotel.png",
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.35),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompact ? 24 : 40,
                            vertical: isCompact ? 40 : 64,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                context.t.web.adminPanel,
                                textAlign: TextAlign.center,
                                style: context.titleMedium.copyWith(
                                  color: whiteColor,
                                  fontSize: isCompact ? 28 : 35,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 15,
                                runSpacing: 15,
                                children: [
                                  CardButton(
                                    width: buttonWidth,
                                    text: context.t.web.listWorker,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => WorkerList(),
                                          ),
                                        ),

                                    iconPath:
                                        "assets/icons/icons_list_users.svg",
                                  ),
                                  CardButton(
                                    width: buttonWidth,
                                    text: context.t.web.createWorkerButton,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => CreateWorkerPage(),
                                          ),
                                        ),
                                    iconPath:
                                        "assets/icons/icons_add_users.svg",
                                  ),
                                  CardButton(
                                    width: buttonWidth,
                                    text: context.t.web.createEventButton,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => CreateEventPage(),
                                          ),
                                        ),

                                    /// поправить иконку
                                    iconPath: Icons.event.toString(),
                                  ),
                                  CardButton(
                                    width: buttonWidth,
                                    text: context.t.web.eventList,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ShiftsList(),
                                          ),
                                        ),

                                    /// поправить
                                    iconPath:
                                        Icons.list_alt_outlined.toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
