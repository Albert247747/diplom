import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplom/data/data_provider/create_worker_data_provider/create_worker_data_provider.dart';
import 'package:diplom/data/repositories/create_worker_repositories/create_worker_data_repository.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/web/create_worker/bloc/cubit.dart';
import 'package:diplom/ui/web/create_worker/bloc/state.dart';
import 'package:diplom/ui/web/create_worker/widgets/select_role_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWorkerPage extends StatelessWidget {
  CreateWorkerPage({super.key});

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateWorkerCubit(
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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
    body: BlocConsumer<CreateWorkerCubit, CreateWorkerState>(
      listener: (context, state) {
        if (state is SuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Сотрудник успешно создан!',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Ошибка, попробуйте еще раз',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: errorColor,
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
              padding:
              const EdgeInsets.symmetric(horizontal: 266, vertical: 92),
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
                            title: 'Email',
                            controller: _emailController,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _textFieldBlock(
                            title: 'Password',
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
                            title: 'Name',
                            controller: _nameController,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _textFieldBlock(
                            title: 'Last Name',
                            controller: _lastNameController,
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
                            title: 'Surname',
                            controller: _surNameController,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: SelectRoleDropDown(
                            selectedRole: _selectedRole!,
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
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedRole != null) {
                          context.read<CreateWorkerCubit>().createWorker(
                            _emailController.text,
                            _passwordController.text,
                            _selectedRole!,
                            _nameController.text,
                            _lastNameController.text,
                            _surNameController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Выберите роль')),
                          );
                        }
                      },
                      child: const Text('Создать Работника'),
                    ),
                  ],
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
        Text(title, style: TextStyle(
          color: greenText,
          fontWeight: FontWeight.bold
        ),),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
        ),
      ],
    );
  }

}
