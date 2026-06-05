import 'package:diplom/ui/common/theme/colors.dart';
import 'package:flutter/material.dart';

void selectedBottomSheet({
  required BuildContext context,
  required String descriptionText,
  required List<SelectedBottomSheetItem> items,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: mainGreen.withValues(alpha: 0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder:
        (context) =>
            SelectedBottomSheet(descriptionText: descriptionText, items: items),
  );
}

class SelectedBottomSheetItem {
  const SelectedBottomSheetItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
}

class SelectedBottomSheet extends StatelessWidget {
  const SelectedBottomSheet({
    required this.descriptionText,
    required this.items,
    super.key,
  });

  final String descriptionText;
  final List<SelectedBottomSheetItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            descriptionText,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Column(
            children:
                items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pop(context);
                        item.onTap();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color:
                              item.isSelected
                                  ? colorScheme.primary.withValues(alpha: 0.14)
                                  : colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                item.isSelected
                                    ? colorScheme.primary
                                    : greyColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color:
                                  item.isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurface,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.title,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            if (item.isSelected)
                              Icon(Icons.check, color: colorScheme.primary),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
