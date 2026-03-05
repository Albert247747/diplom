import 'package:flutter/material.dart';
import '../../../common/theme/colors.dart';

class SelectRoleDropDown extends StatefulWidget {
  const SelectRoleDropDown({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  final String selectedRole;
  final ValueChanged<String?> onRoleChanged;

  @override
  State<SelectRoleDropDown> createState() => _SelectRoleDropDownState();
}

class _SelectRoleDropDownState extends State<SelectRoleDropDown> {
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Role',
        style: TextStyle(color: greenText, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        value: widget.selectedRole,
        items: const [
          DropdownMenuItem(value: 'admin', child: Text('admin')),
          DropdownMenuItem(value: 'worker', child: Text('worker')),
        ],
        onChanged: (value) {
          widget.onRoleChanged(value);
        },
      ),
    ],
  );
}
