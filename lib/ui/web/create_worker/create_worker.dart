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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
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

        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 266,
                vertical: 92,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 400,
                  minHeight: 600,
                  maxWidth: 900,
                  maxHeight: 700,
                ),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _textFieldBlock(
                              title: context.t.web.createWorker.email,
                              controller: _emailController,
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: _textFieldBlock(
                              title: context.t.web.createWorker.password,
                              controller: _passwordController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _textFieldBlock(
                              title: context.t.web.createWorker.name,
                              controller: _nameController,
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: _textFieldBlock(
                              title: context.t.web.createWorker.lastName,
                              controller: _lastNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _textFieldBlock(
                              title: context.t.web.createWorker.surname,
                              controller: _surNameController,
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            child: SelectRoleDropDown(
                              selectedRole: _selectedRole,
                              onRoleChanged: (newRole) {
                                setState(() {
                                  _selectedRole = newRole;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          BaseButton(
                            backgroundColor: greenButtonMain,
                            onPressed: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(Icons.exit_to_app, color: whiteColor),
                          ),
                          Spacer(),
                          BaseButton(
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
                                    SnackBar(
                                      content: Text(
                                        context
                                            .t
                                            .web
                                            .createWorker
                                            .fillAllFields,
                                      ),
                                    ),
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
                                  SnackBar(
                                    content: Text(
                                      context.t.web.createWorker.selectRole,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              context.t.web.createWorker.submit,
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );

  Widget _textFieldBlock({
    required String title,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: greenText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        OutlinedTextField(controller: controller),
      ],
    );
  }
}
