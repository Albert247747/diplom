import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import '../../../common/theme/colors.dart';

class SelectRoleDropDown extends StatefulWidget {
  const SelectRoleDropDown({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  final String? selectedRole;
  final ValueChanged<String?> onRoleChanged;

  @override
  State<SelectRoleDropDown> createState() => _SelectRoleDropDownState();
}

class _SelectRoleDropDownState extends State<SelectRoleDropDown> {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        context.t.web.createWorker.role,
        style: TextStyle(color: greenText, fontWeight: FontWeight.bold),
      ),
      DropdownButtonFormField<String>(
        isDense: true,
        value: widget.selectedRole,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: [
          DropdownMenuItem(
            value: 'bartender',
            child: Text(
              context.t.web.createWorker.roles.bartender,
              style: context.bodyMedium,
            ),
          ),
          DropdownMenuItem(
            value: 'waiter',
            child: Text(
              context.t.web.createWorker.roles.waiter,
              style: context.bodyMedium,
            ),
          ),
          DropdownMenuItem(
            value: 'cook',
            child: Text(
              context.t.web.createWorker.roles.cook,
              style: context.bodyMedium,
            ),
          ),
        ],
        onChanged: (value) {
          widget.onRoleChanged(value);
        },
      ),
    ],
  );
}
