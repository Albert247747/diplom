import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data/data_provider/create_worker_data_provider/create_worker_data_provider.dart';
import 'package:diplom/data/repositories/create_worker_repositories/create_worker_data_repository.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/web/create_worker/bloc/cubit.dart';
import 'package:diplom/ui/web/create_worker/bloc/state.dart';
import 'package:diplom/ui/web/create_worker/widgets/select_role_drop_down.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/text_fields/outlined_text_field.dart';

class CreateWorkerPage extends StatelessWidget {
  CreateWorkerPage({super.key});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CreateWorkerCubit(
            CreateWorkerRepository(
              createWorkerDataProvider: CreateWorkerDataProvider(firestore),
            ),
          ),
      child: const CreateWorkerView(),
    );
  }
}

class CreateWorkerView extends StatefulWidget {
  const CreateWorkerView({super.key});

  @override
  State<CreateWorkerView> createState() => _CreateWorkerViewState();
}

class _CreateWorkerViewState extends State<CreateWorkerView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  String? _selectedRole;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _surNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocConsumer<CreateWorkerCubit, CreateWorkerState>(
        listener: (context, state) {
          if (state is SuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.t.web.createWorker.success,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.messageError ?? context.t.web.createWorker.genericError,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: redColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.lightGreen),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 720;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 16 : 32,
                    vertical: isCompact ? 16 : 40,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Container(
                      padding: EdgeInsets.all(isCompact ? 20 : 32),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(
                          isCompact ? 18 : 25,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _fieldRow(isCompact, [
                            _textFieldBlock(
                              title: context.t.web.createWorker.email,
                              controller: _emailController,
                            ),
                            _textFieldBlock(
                              title: context.t.web.createWorker.password,
                              controller: _passwordController,
                            ),
                          ]),
                          const SizedBox(height: 24),
                          _fieldRow(isCompact, [
                            _textFieldBlock(
                              title: context.t.web.createWorker.name,
                              controller: _nameController,
                            ),
                            _textFieldBlock(
                              title: context.t.web.createWorker.lastName,
                              controller: _lastNameController,
                            ),
                          ]),
                          const SizedBox(height: 24),
                          _fieldRow(isCompact, [
                            _textFieldBlock(
                              title: context.t.web.createWorker.surname,
                              controller: _surNameController,
                            ),
                            SelectRoleDropDown(
                              selectedRole: _selectedRole,
                              onRoleChanged: (newRole) {
                                setState(() {
                                  _selectedRole = newRole;
                                });
                              },
                            ),
                          ]),
                          const SizedBox(height: 40),
                          _actionsRow(context, isCompact),
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
  }

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

  Widget _actionsRow(BuildContext context, bool isCompact) {
    final colorScheme = Theme.of(context).colorScheme;

    final backButton = BaseButton(
      width: isCompact ? double.infinity : null,
      backgroundColor: greenButtonMain,
      onPressed: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(100),
      child: Icon(Icons.exit_to_app, color: colorScheme.onPrimary),
    );

    final submitButton = BaseButton(
      width: isCompact ? double.infinity : null,
      backgroundColor: greenButtonMain,
      borderRadius: BorderRadius.circular(100),
      onPressed: () {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        final name = _nameController.text.trim();
        final lastName = _lastNameController.text.trim();
        final surname = _surNameController.text.trim();

        if (_selectedRole != null) {
          if (email.isEmpty ||
              password.isEmpty ||
              name.isEmpty ||
              lastName.isEmpty ||
              surname.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.t.web.createWorker.fillAllFields)),
            );
            return;
          }

          context.read<CreateWorkerCubit>().createWorker(
            email,
            password,
            _selectedRole!,
            name,
            lastName,
            surname,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.t.web.createWorker.selectRole)),
          );
        }
      },
      child: Text(
        context.t.web.createWorker.submit,
        style: TextStyle(color: colorScheme.onPrimary),
      ),
    );

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [submitButton, const SizedBox(height: 12), backButton],
      );
    }

    return Row(children: [backButton, const Spacer(), submitButton]);
  }

  List<Widget> _withSpacing(List<Widget> children, {required bool vertical}) {
    final result = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        result.add(
          SizedBox(width: vertical ? 0 : 32, height: vertical ? 24 : 0),
        );
      }
      result.add(children[i]);
    }
    return result;
  }

  Widget _textFieldBlock({
    required String title,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        OutlinedTextField(controller: controller),
      ],
    );
  }
}
