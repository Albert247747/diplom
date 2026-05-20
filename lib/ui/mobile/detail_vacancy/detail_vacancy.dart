import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/mobile/detail_vacancy/widgets/custom_label_widget.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/bottom_sheets/bottom_sheets.dart';

class DetailVacancy extends StatelessWidget {
  const DetailVacancy({
    required this.post,
    required this.price,
    required this.date,
    required this.time,
    required this.totalUser,
    required this.currentUser,
    required this.comment,
    required this.requirements,
    super.key
  });

  final String post;
  final double price;
  final String date;
  final String time;
  final String comment;
  final String requirements;
  final int currentUser;
  final int totalUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.mobile.vacancy.booking),
        centerTitle: true,
        backgroundColor: mainBackground,
      ),
      backgroundColor: mainBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(21, 48, 21, 0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: whiteColor
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       RowBloc(
                           leftText: Text(post),
                           rightText: Text(price.toString())
                       ),
                       RowBloc(
                           leftText: Text(date),
                           rightText: Text(time)
                       ),
                       CustomLabelWidget(
                           title: context.t.mobile.vacancy.seats,
                           current: currentUser,
                           total: totalUser,
                         padding: const EdgeInsets.only(bottom: 20),
                       ),
                       Text(context.t.mobile.vacancy.requirements,
                       style: context.titleMedium.copyWith(fontSize: 16,
                       fontWeight: FontWeight.bold),),
                       Text(requirements, style: context.titleSmall,),
                       SizedBox(height: 20,),
                       Text(context.t.mobile.vacancy.comment,
                         style: context.titleMedium.copyWith(fontSize: 16,
                             fontWeight: FontWeight.bold)),
                       Text(comment, style: context.titleSmall,),
                       SizedBox(height: 20,),
                       Center(
                         child: BaseButton(
                            height: 60,
                             width: 170,
                             backgroundColor: mainGreen,
                             onPressed: () => baseBottomSheet(
                                 context,
                                 context.t.mobile.vacancy.successShift,
                                 () => Navigator.pop(context),
                                 context.t.mobile.vacancy.ok
                             ),
                            borderRadius: BorderRadius.circular(25),
                             child: Text(context.t.mobile.vacancy.book ,style:
                               TextStyle(color: whiteColor),),
                         ),
                       ),
                     ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      )
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
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 20),
      child: Row(children: [leftText, Spacer(), rightText]),
    );
  }
}
