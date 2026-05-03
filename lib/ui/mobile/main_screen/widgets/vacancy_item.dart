import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class VacancyItem extends StatelessWidget {
  const VacancyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            RowBloc(
              rightText: Text(context.t.mobile.vacancy.role),
              leftText: Text(context.t.mobile.vacancy.salary),
            ),
            RowBloc(
              rightText: Text(context.t.mobile.vacancy.date),
              leftText: Text(context.t.mobile.vacancy.time),
            ),
          ],
        ),
      ),
    );
  }
}

class RowBloc extends StatelessWidget {
  const RowBloc({required this.leftText, required this.rightText, super.key});

  final Widget leftText;
  final Widget rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      child: Row(children: [leftText, Spacer(), rightText]),
    );
  }
}
