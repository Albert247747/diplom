import 'package:diplom/data/repositories/auth_repositories/auth_repositories.dart';
import 'package:diplom/data/repositories/home_repository/home_repository.dart';
import 'package:diplom/ui/common/bloc/auth/auth_cubit.dart';
import 'package:diplom/ui/common/bloc/auth/auth_state.dart';
import 'package:diplom/ui/common/enums/device_type.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/main_screen/bloc/home_cubit.dart';
import 'package:diplom/ui/mobile/main_screen/main_screen.dart';
import 'package:diplom/ui/mobile/not_autorized/not_autorized.dart';
import 'package:diplom/ui/mobile/sign_in_mobile/widgets/registration_stepper.dart';
import 'package:diplom/ui/web/home_admin_panel/home_admin_panel.dart';
import 'package:diplom/ui/web/not_authorized/not_authorized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import '../../mobile/sign_in_mobile/auth_screen.dart';
import '../../web/sign_in_web/sign_in_web.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({required this.platform, super.key});

  final UserPlatform platform;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isMobileRegistrationStepperCompleted = false;

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
                  backgroundColor: redColor,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginSuccess) {
              if (widget.platform == UserPlatform.mobile) {
                return state.users.isWorker
                    ? BlocProvider(
                      create:
                          (_) => HomeCubit(
                            HomeRepository(provider: FirebaseDataProvider()),
                          ),
                      child: MainScreen(),
                    )
                    : NotAuthorizedMobile(
                      onBack: () => context.read<CubitAuth>().logout(),
                    );
              } else {
                return state.users.isAdmin
                    ? AdminPanel()
                    : NotAuthorized(
                      onBack: () => context.read<CubitAuth>().logout(),
                    );
              }
            }

            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return widget.platform == UserPlatform.mobile
                ? _isMobileRegistrationStepperCompleted
                    ? SignInMobile()
                    : RegistrationStepper(
                      onComplete: () {
                        setState(
                          () => _isMobileRegistrationStepperCompleted = true,
                        );
                      },
                    )
                : SignInWeb();
          },
        ),
      ),
    );
  }
}
