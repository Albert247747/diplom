import 'package:diplom/domain/models/event/event_model.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/mobile/detail_vacancy/widgets/custom_label_widget.dart';
import 'package:diplom/ui/mobile/main_screen/bloc/home_cubit.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/bottom_sheets/bottom_sheets.dart';

class DetailVacancy extends StatelessWidget {
  const DetailVacancy({required this.event, super.key});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.mobile.vacancy.booking),
        centerTitle: true,
        backgroundColor: mainBackground,
      ),
      backgroundColor: mainBackground,
      body: StreamBuilder<EventModel?>(
        stream: homeCubit.watchEvent(event.id),
        initialData: event,
        builder: (context, snapshot) {
          final currentEvent = snapshot.data;

          if (currentEvent == null) {
            return const Center(child: Text('Мероприятие не найдено'));
          }

          final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
          final isBooked = currentEvent.isBookedBy(userId);
          final isButtonDisabled = currentEvent.isFull && !isBooked;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(21, 48, 21, 0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentEvent.title,
                            style: context.titleMedium.copyWith(fontSize: 22),
                          ),
                          RowBloc(
                            leftText: Text(currentEvent.roleTitle),
                            rightText: Text('${currentEvent.salary} руб/час'),
                          ),
                          RowBloc(
                            leftText: Text(currentEvent.formattedDate),
                            rightText: Text(currentEvent.formattedTime),
                          ),
                          Text(
                            currentEvent.location,
                            style: context.titleSmall.copyWith(color: greyText),
                          ),
                          const SizedBox(height: 20),
                          CustomLabelWidget(
                            title: context.t.mobile.vacancy.seats,
                            current: currentEvent.assignedCount,
                            total: currentEvent.workerCount,
                            padding: const EdgeInsets.only(bottom: 20),
                          ),
                          Text(
                            context.t.mobile.vacancy.requirements,
                            style: context.titleMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentEvent.roleTitle,
                            style: context.titleSmall,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            context.t.mobile.vacancy.comment,
                            style: context.titleMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentEvent.description,
                            style: context.titleSmall,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: BaseButton(
                              height: 60,
                              width: 190,
                              backgroundColor:
                                  isButtonDisabled ? Colors.grey : mainGreen,
                              onPressed: () {
                                if (isButtonDisabled) return;
                                _toggleBooking(
                                  context,
                                  homeCubit,
                                  currentEvent,
                                  isBooked,
                                );
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Text(
                                _buttonText(isBooked, isButtonDisabled),
                                style: const TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _buttonText(bool isBooked, bool isButtonDisabled) {
    if (isBooked) return 'Отменить запись';
    if (isButtonDisabled) return 'Мест нет';
    return 'Записаться';
  }

  Future<void> _toggleBooking(
    BuildContext context,
    HomeCubit homeCubit,
    EventModel event,
    bool isBooked,
  ) async {
    try {
      if (isBooked) {
        await homeCubit.cancelEventBooking(event.id);
        if (!context.mounted) return;
        baseBottomSheet(
          context,
          'Запись на смену отменена',
          () => Navigator.pop(context),
          context.t.mobile.vacancy.ok,
        );
        return;
      }

      await homeCubit.bookEvent(event.id);
      if (!context.mounted) return;
      baseBottomSheet(
        context,
        context.t.mobile.vacancy.successShift,
        () => Navigator.pop(context),
        context.t.mobile.vacancy.ok,
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: redColor,
        ),
      );
    }
  }
}

class RowBloc extends StatelessWidget {
  const RowBloc({required this.leftText, required this.rightText, super.key});

  final Widget leftText;
  final Widget rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 20),
      child: Row(children: [leftText, Spacer(), rightText]),
    );
  }
}
