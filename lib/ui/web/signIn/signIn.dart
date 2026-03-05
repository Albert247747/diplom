import 'dart:io';

import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/widgets/button/button.dart';
import 'package:diplom/ui/web/not_authorized/not_authorized.dart';
import 'package:diplom/ui/common/widgets/text_fields/email_field.dart';
import 'package:diplom/ui/common/widgets/text_fields/password_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import '../../../data/repositories/auth_repositories/auth_repositories.dart';
import '../home_admin_panel/homeAdminPanel.dart';
import 'bloc/sign_in_cubit.dart';
import 'bloc/sign_in_state.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  bool get isWeb => kIsWeb;
  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  @override
  Widget build(BuildContext context) =>
      BlocProvider(
        create:
            (context) =>
            CubitAuth(AuthRepository(firebaseAuth: FirebaseDataProvider())),
        child: SignInView(),
      );
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController(
  );
  final TextEditingController _passwordController = TextEditingController(
  );

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
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: mainBackground,
        body: BlocConsumer<CubitAuth, StateAuth>(
            listener:
                (context, state) async =>
            {
              if (state is LoginSuccess)
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPanel()),
                  ),
                },
              if (state is LoginError)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotAuthorized()),
                  ),
                },

            },
            builder: (context, state) {
              if( state is LoginLoading){
                Center(
                  child: CircularProgressIndicator(color: mainGreen,),
                );
              }
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 1200,
                      maxHeight: 800,
                      minWidth: 800
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 60
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Dashboard', style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),),
                        SizedBox(height: 32,),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 400
                          ),
                          child: EmailField(
                            label: 'Email',
                          ),
                        ),
                        SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 400
                          ),
                          child: PasswordField(
                              label: 'Password'
                          ),
                        ),
                        SizedBox(height: 46,),
                        SizedBox(
                          height: 60,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: 400
                            ),
                            child: Button(
                              backgroundColor: greenButtonMain,
                              onPressed: _onLoginPressed,
                              child: Text('Вход'),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      );
}
