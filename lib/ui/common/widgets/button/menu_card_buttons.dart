import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String iconPath;

  const CardButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}