import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class VacancyItem extends StatelessWidget {
  const VacancyItem({
    required this.title,
    required this.role,
    required this.timing,
    required this.dateEvent,
    required this.salary,
    required this.assignedEmployeesCount,
    required this.requiredEmployeesCount,
    super.key,
  });

  final String salary;

  final String title;

  final String role;

  final String dateEvent;

  final String timing;

  final String assignedEmployeesCount;

  final String requiredEmployeesCount;

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
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            RowBloc(
              leftText: Text(
                role.isEmpty ? context.t.mobile.vacancy.role : role,
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              rightText: Text(
                salary,
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            RowBloc(
              leftText: Text(
                dateEvent,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w300,
                  color: greyText,
                ),
              ),
              rightText: Text(
                timing,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w300,
                  color: greyText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: Row(
                children: [
                  Text(
                    context.t.mobile.vacancy.seats,
                    style: context.bodyMedium.copyWith(
                      color: greenText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: assignedEmployeesCount,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: mainGreen,
                          ),
                        ),
                        TextSpan(
                          text: '/$requiredEmployeesCount',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: mainGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
