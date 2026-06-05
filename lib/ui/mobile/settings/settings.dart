import 'package:diplom/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../utils/translations.g.dart';
import '../../common/widgets/bottom_sheets/selected_bottom_sheets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, themeMode, _) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          appBar: AppBar(title: Text(context.t.mobile.vacancy.settings)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showThemeBottomSheet(context, themeMode),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: colorScheme.surface,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mode_night_outlined,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 15),
                          Text('Тема', style: theme.textTheme.bodyMedium),
                          const Spacer(),
                          Text(
                            _themeModeTitle(themeMode),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemeBottomSheet(BuildContext context, ThemeMode currentThemeMode) {
    selectedBottomSheet(
      context: context,
      descriptionText: 'Выберите тему приложения',
      items: [
        SelectedBottomSheetItem(
          title: 'Светлая',
          icon: Icons.light_mode_outlined,
          isSelected: currentThemeMode == ThemeMode.light,
          onTap: () => appThemeMode.value = ThemeMode.light,
        ),
        SelectedBottomSheetItem(
          title: 'Темная',
          icon: Icons.dark_mode_outlined,
          isSelected: currentThemeMode == ThemeMode.dark,
          onTap: () => appThemeMode.value = ThemeMode.dark,
        ),
        SelectedBottomSheetItem(
          title: 'Системная',
          icon: Icons.brightness_auto_outlined,
          isSelected: currentThemeMode == ThemeMode.system,
          onTap: () => appThemeMode.value = ThemeMode.system,
        ),
      ],
    );
  }

  String _themeModeTitle(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.light => 'Светлая',
      ThemeMode.dark => 'Темная',
      ThemeMode.system => 'Системная',
    };
  }
}
