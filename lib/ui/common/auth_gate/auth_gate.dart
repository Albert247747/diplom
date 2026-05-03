import 'package:diplom/data/repositories/auth_repositories/auth_repositories.dart';
import 'package:diplom/ui/common/bloc/auth/auth_cubit.dart';
import 'package:diplom/ui/common/bloc/auth/auth_state.dart';
import 'package:diplom/ui/common/enums/device_type.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/main_screen/main_screen.dart';
import 'package:diplom/ui/mobile/not_autorized/not_autorized.dart';
import 'package:diplom/ui/web/home_admin_panel/home_admin_panel.dart';
import 'package:diplom/ui/web/not_authorized/not_authorized.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import '../../mobile/sign_in_mobile/auth_screen.dart';
import '../../web/sign_in_web/sign_in_web.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({required this.platform, super.key});

  final UserPlatform platform;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create:
            (context) =>
                CubitAuth(AuthRepository(firebaseAuth: FirebaseDataProvider()))
                  ..checkCurrentUser(),
        child: BlocConsumer<CubitAuth, AuthState>(
          listener: (context, state) {
            if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? state.errorCode),
                  backgroundColor: errorColor,
                ),
              );
            }

            if (state is LoginSuccess && !_isAllowed(state)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.t.error.platformRoleError),
                  backgroundColor: errorColor,
                ),
              );
              context.read<CubitAuth>().logout();
            }
          },
          builder: (context, state) {
            if (state is LoginSuccess) {
              if (platform == UserPlatform.mobile) {
                return state.users.isWorker
                    ? MainScreen()
                    : NotAuthorizedMobile();
              } else {
                return state.users.isAdmin ? AdminPanel() : NotAuthorized();
              }
            }

            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return platform == UserPlatform.mobile
                ? SignInMobile()
                : SignInWeb();
          },
        ),
      ),
    );
  }

  bool _isAllowed(LoginSuccess state) {
    if (platform == UserPlatform.mobile) {
      return state.users.isWorker;
    }

    return state.users.isAdmin;
  }
}
