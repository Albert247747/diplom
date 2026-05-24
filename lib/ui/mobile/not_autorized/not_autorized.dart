import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class NotAuthorizedMobile extends StatelessWidget {
  const NotAuthorizedMobile({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.t.error.adminInWebError,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                context.t.web.openWebSiteMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: blackColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onBack,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    context.t.web.back,
                    style: const TextStyle(color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
