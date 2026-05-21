import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/main_screen/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/translations.g.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
    required this.post
  });

  final String user;

  final String post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.mobile.vacancy.profile,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: mainBackground,
        actions: [
          IconButton(
              onPressed: () async {
              context.read<HomeCubit>().logout();
              },
              icon: Icon(Icons.logout,
              color: redColor,)
          )
        ],
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainBackground,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: mainGreen,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  user,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.t.mobile.vacancy.post),
                        SizedBox(width: 10,),
                        Text(post)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}