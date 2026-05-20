import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:flutter/material.dart';

void baseBottomSheet(
    BuildContext context,
    String descriptionText,
    VoidCallback onPressed,
    String textButton,
    ) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: mainGreen.withValues(alpha: 0.5),
    isScrollControlled: true, // Позволяет модалке быть выше клавиатуры
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (context) => SupportBottomSheet(
      textButton: textButton,
      onPressed: () {
        Navigator.pop(context); // Закрываем модалку
        onPressed(); // Вызываем переданную функцию
      },
      descriptionText: descriptionText,
    ),
  );
}

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({
    required this.textButton,
    required this.onPressed,
    required this.descriptionText,
    super.key,
  });

  final String descriptionText;
  final String textButton;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            descriptionText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: BaseButton(
                  backgroundColor: mainGreen,
                  onPressed: onPressed,
                  child: Text(
                    textButton,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}