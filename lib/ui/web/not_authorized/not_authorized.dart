import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class NotAuthorized extends StatelessWidget {
  const NotAuthorized({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width < 1200 ? size.width * 0.9 : 1200,
            maxHeight: size.height < 800 ? size.height * 0.9 : 800,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width < 600 ? 20 : 160,
              vertical: size.height < 600 ? 20 : 60,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.t.signIn.dashboard,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 62),
                  Text(
                    context.t.error.workerInWebError,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 20),
                  ),
                  Text(
                    context.t.web.openMobileAppMessage,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 62),
                  SizedBox(
                    height: 60,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: size.width < 400 ? size.width * 0.6 : 400,
                      ),
                      child: ElevatedButton(
                        onPressed: onBack,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          backgroundColor: colorScheme.primary,
                        ),
                        child: Text(
                          context.t.web.back,
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
