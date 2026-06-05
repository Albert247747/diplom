import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/colors.dart';

class CardButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String iconPath;
  final double width;

  const CardButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.iconPath,
    this.width = 180,
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
            width: width,
            height: 112,
            padding: const EdgeInsets.fromLTRB(18, 34, 18, 18),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: greenButtonMain.withValues(alpha: 0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withValues(alpha: 0.16),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: greenButtonMain,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SvgPicture.asset(iconPath, width: 50, height: 50),
          ),
        ],
      ),
    );
  }
}
