import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data/data_provider/create_event_data_provider/create_event_data_provider.dart';
import 'package:diplom/data/repositories/create_event_repositories/create_event_data_repository.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/web/create_event/bloc/cubit.dart';
import 'package:diplom/ui/web/create_event/bloc/state.dart';
import 'package:diplom/ui/web/create_worker/widgets/select_role_drop_down.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventPage extends StatelessWidget {
  CreateEventPage({super.key});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CreateEventCubit(
            CreateEventRepository(
              dataProvider: CreateEventDataProvider(firestore),
            ),
          ),
      child: const CreateEventView(),
    );
  }
}

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workerCountController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _selectedRole;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _workerCountController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
    appBar: AppBar(
      backgroundColor: mainBackground,
      title: Text(context.t.web.createEvent.title),
    ),
    body: BlocConsumer<CreateEventCubit, CreateEventState>(
      listener: (context, state) {
        if (state is CreateEventSuccess) {
          _clearForm();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.t.web.createEvent.success,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is CreateEventError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.messageError ?? context.t.web.createEvent.genericError,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: redColor,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateEventLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.lightGreen),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 760;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isCompact ? 16 : 32,
                  vertical: isCompact ? 16 : 40,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Container(
                    padding: EdgeInsets.all(isCompact ? 20 : 32),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(isCompact ? 18 : 25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.t.web.createEvent.formTitle,
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: isCompact ? 22 : 24,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _fieldRow(isCompact, [
                          _textFieldBlock(
                            title: context.t.web.createEvent.name,
                            controller: _titleController,
                          ),
                          _textFieldBlock(
                            title: context.t.web.createEvent.location,
                            controller: _locationController,
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _textFieldBlock(
                          title: context.t.web.createEvent.description,
                          controller: _descriptionController,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 24),
                        _fieldRow(isCompact, [
                          _pickerBlock(
                            title: context.t.web.createEvent.date,
                            value:
                                _selectedDate == null
                                    ? context.t.web.createEvent.selectDate
                                    : _formatDate(_selectedDate!),
                            onPressed: _pickDate,
                          ),
                          _pickerBlock(
                            title: context.t.web.createEvent.startTime,
                            value:
                                _startTime == null
                                    ? context.t.web.createEvent.selectTime
                                    : _formatTime(_startTime!),
                            onPressed: () => _pickTime(isStart: true),
                          ),
                          _pickerBlock(
                            title: context.t.web.createEvent.endTime,
                            value:
                                _endTime == null
                                    ? context.t.web.createEvent.selectTime
                                    : _formatTime(_endTime!),
                            onPressed: () => _pickTime(isStart: false),
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _fieldRow(isCompact, [
                          SelectRoleDropDown(
                            selectedRole: _selectedRole,
                            onRoleChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                          ),
                          _textFieldBlock(
                            title: context.t.web.createEvent.workerCount,
                            controller: _workerCountController,
                            keyboardType: TextInputType.number,
                          ),
                          _textFieldBlock(
                            title: context.t.web.createEvent.salary,
                            controller: _salaryController,
                            keyboardType: TextInputType.number,
                          ),
                        ]),
                        const SizedBox(height: 36),
                        Align(
                          alignment:
                              isCompact
                                  ? Alignment.center
                                  : Alignment.centerRight,
                          child: SizedBox(
                            width: isCompact ? double.infinity : null,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _submit,
                              child: Text(context.t.web.createEvent.submit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );

  Widget _fieldRow(bool isCompact, List<Widget> children) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _withSpacing(children, vertical: true),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _withSpacing(
        children.map((child) => Expanded(child: child)).toList(),
        vertical: false,
      ),
    );
  }

  List<Widget> _withSpacing(List<Widget> children, {required bool vertical}) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        result.add(
          SizedBox(width: vertical ? 0 : 24, height: vertical ? 24 : 0),
        );
      }
      result.add(children[i]);
    }
    return result;
  }

  Widget _textFieldBlock({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: greenColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: const InputDecoration(
            filled: true,
            fillColor: backgroundTextFieldColor,
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _pickerBlock({
    required String title,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: greenColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: onPressed,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
    );

    if (date == null) return;
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    final time = await showTimePicker(
      context: context,
      initialTime:
          isStart ? _startTime ?? TimeOfDay.now() : _endTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (time == null) return;
    setState(() {
      if (isStart) {
        _startTime = time;
      } else {
        _endTime = time;
      }
    });
  }

  void _submit() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final location = _locationController.text.trim();
    final workerCount = int.tryParse(_workerCountController.text.trim());
    final salary = int.tryParse(_salaryController.text.trim());

    if (title.isEmpty ||
        description.isEmpty ||
        location.isEmpty ||
        workerCount == null ||
        salary == null ||
        _selectedDate == null ||
        _startTime == null ||
        _endTime == null ||
        _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.web.createEvent.fillAllFields)),
      );
      return;
    }

    if (workerCount <= 0 || salary <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.web.createEvent.enterPositiveNumbers)),
      );
      return;
    }

    final startAt = _combineDateAndTime(_selectedDate!, _startTime!);
    final endAt = _combineDateAndTime(_selectedDate!, _endTime!);

    if (!endAt.isAfter(startAt)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.web.createEvent.endTimeAfterStart)),
      );
      return;
    }

    context.read<CreateEventCubit>().createEvent(
      title: title,
      description: description,
      location: location,
      date: _selectedDate!,
      startAt: startAt,
      endAt: endAt,
      role: _selectedRole!,
      workerCount: workerCount,
      salary: salary,
    );
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _locationController.clear();
    _workerCountController.clear();
    _salaryController.clear();
    setState(() {
      _selectedDate = null;
      _startTime = null;
      _endTime = null;
      _selectedRole = null;
    });
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
