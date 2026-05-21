import 'package:diplom/domain/models/event/event_model.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/mobile/detail_vacancy/detail_vacancy.dart';
import 'package:diplom/ui/mobile/main_screen/bloc/home_cubit.dart';
import 'package:diplom/ui/mobile/main_screen/widgets/profile.dart';
import 'package:diplom/ui/mobile/main_screen/widgets/vacancy_item.dart';
import 'package:diplom/utils/translations.g.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_in_mobile/auth_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const Center(child: Text('Избранное')),
    const Center(child: Text('Сообщения')),
    const Profile(user: 'Гатиятуллин Альберт Рустемович', post: 'Официант'),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const SignInMobile();
        }

        // если пользователь авторизован
        return Scaffold(
          backgroundColor: mainBackground,

          body: pages[currentIndex],

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(25),
            ),

            child: BottomNavigationBar(
              currentIndex: currentIndex,

              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,

              showSelectedLabels: false,
              showUnselectedLabels: false,

              selectedItemColor: mainGreen,
              unselectedItemColor: Colors.grey,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded),
                  label: '',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,

      appBar: AppBar(
        title: Text(
          context.t.mobile.shifts,

          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),

        backgroundColor: mainBackground,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),

        child: StreamBuilder<List<EventModel>>(
          stream: context.read<HomeCubit>().watchWorkerEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final events = snapshot.data ?? const <EventModel>[];

            if (events.isEmpty) {
              return const Center(child: Text('Пока нет доступных смен'));
            }

            return ListView.separated(
              itemCount: events.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final event = events[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider.value(
                              value: context.read<HomeCubit>(),
                              child: DetailVacancy(event: event),
                            ),
                      ),
                    );
                  },
                  child: VacancyItem(
                    title: event.title,
                    role: event.roleTitle,
                    timing: event.formattedTime,
                    dateEvent: event.formattedDate,
                    salary: '${event.salary} руб/час',
                    assignedEmployeesCount: event.assignedCount.toString(),
                    requiredEmployeesCount: event.workerCount.toString(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
