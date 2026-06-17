import 'package:diplom/ui/common/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsWeb extends StatefulWidget {
  const SettingsWeb({super.key, required this.onLogout});

  final Future<void> Function() onLogout;

  @override
  State<SettingsWeb> createState() => _SettingsWebState();
}

class _SettingsWebState extends State<SettingsWeb> {
  bool _isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, themeMode, _) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          appBar: AppBar(title: const Text('Настройки')),
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 680;
                final horizontalPadding = isCompact ? 16.0 : 32.0;

                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: isCompact ? 16 : 32,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 820),
                      child: Container(
                        padding: EdgeInsets.all(isCompact ? 18 : 28),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SettingsHeader(isCompact: isCompact),
                            const SizedBox(height: 28),
                            Text(
                              'Тема интерфейса',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _ThemeModeOptions(
                              isCompact: isCompact,
                              themeMode: themeMode,
                            ),
                            const SizedBox(height: 32),
                            Divider(
                              color: colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                            ),
                            const SizedBox(height: 24),
                            _LogoutSection(
                              isLoading: _isLoggingOut,
                              isCompact: isCompact,
                              onLogout: _confirmLogout,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Выйти из аккаунта?'),
            content: const Text(
              'Для продолжения работы потребуется новый вход.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Отмена'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Выйти'),
              ),
            ],
          ),
    );

    if (shouldLogout != true || _isLoggingOut) {
      return;
    }

    setState(() => _isLoggingOut = true);
    await widget.onLogout();

    if (!mounted) {
      return;
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(Icons.settings_outlined, color: colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Настройки',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: isCompact ? 26 : 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Управление видом веб-приложения и текущей сессией.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.64),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeModeOptions extends StatelessWidget {
  const _ThemeModeOptions({required this.isCompact, required this.themeMode});

  final bool isCompact;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _ThemeModeCard(
        width: isCompact ? double.infinity : 240,
        icon: Icons.light_mode_outlined,
        title: 'Светлая',
        isSelected: themeMode == ThemeMode.light,
        onTap: () => appThemeMode.value = ThemeMode.light,
      ),
      _ThemeModeCard(
        width: isCompact ? double.infinity : 240,
        icon: Icons.dark_mode_outlined,
        title: 'Темная',
        isSelected: themeMode == ThemeMode.dark,
        onTap: () => appThemeMode.value = ThemeMode.dark,
      ),
      _ThemeModeCard(
        width: isCompact ? double.infinity : 240,
        icon: Icons.brightness_auto_outlined,
        title: 'Системная',
        isSelected: themeMode == ThemeMode.system,
        onTap: () => appThemeMode.value = ThemeMode.system,
      ),
    ];

    if (isCompact) {
      return Column(
        children:
            cards
                .map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: card,
                  ),
                )
                .toList(),
      );
    }

    return Wrap(spacing: 12, runSpacing: 12, children: cards);
  }
}

class _ThemeModeCard extends StatelessWidget {
  const _ThemeModeCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final double width;
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedColor = colorScheme.primary;

    return SizedBox(
      width: width,
      height: 92,
      child: Material(
        color:
            isSelected
                ? selectedColor.withValues(alpha: 0.10)
                : theme.scaffoldBackgroundColor.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isSelected
                        ? selectedColor
                        : colorScheme.onSurface.withValues(alpha: 0.10),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: selectedColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color:
                      isSelected
                          ? selectedColor
                          : colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection({
    required this.isLoading,
    required this.isCompact,
    required this.onLogout,
  });

  final bool isLoading;
  final bool isCompact;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Аккаунт',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Завершить текущую сессию администратора.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.64),
          ),
        ),
      ],
    );

    final logoutButton = SizedBox(
      width: isCompact ? double.infinity : null,
      height: 48,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onLogout,
        icon:
            isLoading
                ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : const Icon(Icons.logout),
        label: const Text('Выйти'),
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: Colors.white,
        ),
      ),
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [textBlock, const SizedBox(height: 16), logoutButton],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: textBlock),
        const SizedBox(width: 16),
        logoutButton,
      ],
    );
  }
}
