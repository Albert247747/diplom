import 'package:diplom/ui/common/bloc/auth/auth_state.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/common/widgets/text_fields/base_text_field.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/bloc/auth/auth_cubit.dart';

class SignInWeb extends StatelessWidget {
  const SignInWeb({super.key});

  @override
  Widget build(BuildContext context) => SignInWebView();
}

class SignInWebView extends StatefulWidget {
  const SignInWebView({super.key});

  @override
  State<SignInWebView> createState() => _SignInWebViewState();
}

class _SignInWebViewState extends State<SignInWebView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    context.read<CubitAuth>().login(email, password);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: mainBackground,
    body: BlocConsumer<CubitAuth, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoginLoading) {
          return Center(child: CircularProgressIndicator(color: mainGreen));
        }
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 640;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 16 : 32,
                    vertical: isCompact ? 16 : 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isCompact ? 20 : 100,
                        vertical: isCompact ? 32 : 60,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(
                          isCompact ? 18 : 25,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.t.signIn.dashboard,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: isCompact ? 24 : 30,
                            ),
                          ),
                          const SizedBox(height: 32),
                          BaseTextFieldWidget(
                            hintText: context.t.signIn.emailHint,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 16),
                          BaseTextFieldWidget(
                            hintText: context.t.signIn.passwordHint,
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 46),
                          SizedBox(
                            height: 60,
                            child: BaseButton(
                              width: double.infinity,
                              backgroundColor: greenButtonMain,
                              onPressed: _onLoginPressed,
                              child: Text(context.t.signIn.title),
                            ),
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
      },
    ),
  );
}
