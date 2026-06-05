import 'package:diplom/ui/common/form/base_validation.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/ui/common/widgets/text_fields/base_text_field.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diplom/ui/common/bloc/auth/auth_cubit.dart';

import '../../common/bloc/auth/auth_state.dart';
import '../../common/widgets/button/button.dart';

class SignInMobile extends StatelessWidget {
  const SignInMobile({super.key});

  @override
  Widget build(BuildContext context) => SignInMobileView();
}

class SignInMobileView extends StatefulWidget {
  const SignInMobileView({super.key});

  @override
  State<SignInMobileView> createState() => _SignInMobileViewState();
}

class _SignInMobileViewState extends State<SignInMobileView> {
  final validator = BaseValidation();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BaseValidation _validation = BaseValidation();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    _validation.email = _emailController.text;
    _validation.password = _passwordController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    if (!_validation.validate()) {
      setState(() {});
      return;
    }

    if (email.isEmpty || password.isEmpty) return;

    context.read<CubitAuth>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.t.signIn.title, style: context.titleMedium),
      ),

      /// не забыть добавить отступ под челку
      body: BlocConsumer<CubitAuth, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseTextFieldWidget(
                  controller: _emailController,
                  hintText: context.t.signIn.email,
                  errorText: _validation.errors['email']?.join('\n'),
                ),
                SizedBox(height: 16),
                BaseTextFieldWidget(
                  hintText: context.t.signIn.password,
                  controller: _passwordController,
                  obscureText: true,
                  errorText: _validation.errors['password']?.join('\n'),
                ),
                SizedBox(height: 46),
                BaseButton(
                  borderRadius: BorderRadius.circular(60),
                  backgroundColor: greenButtonMain,
                  onPressed: _onLoginPressed,
                  width: double.infinity,
                  height: 60,
                  child: Text(
                    context.t.signIn.title,
                    style: context.bodyMedium.copyWith(color: whiteColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
