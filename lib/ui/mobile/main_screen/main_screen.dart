import 'dart:async';

import 'package:diplom/data/services/push_notification/push_notification.dart';
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
  StreamSubscription<List<EventModel>>? _workerEventsSubscription;
  final Set<String> _knownWorkerEventIds = <String>{};
  bool _didReceiveInitialWorkerEvents = false;

  final List<Widget> pages = [
    const HomePage(),
    const BookedShiftsPage(),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _subscribeToWorkerEvents();
  }

  @override
  void dispose() {
    _workerEventsSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToWorkerEvents() {
    final homeCubit = context.read<HomeCubit>();

    _workerEventsSubscription = homeCubit.watchWorkerEvents().listen((events) {
      final currentEventIds = events.map((event) => event.id).toSet();

      if (!_didReceiveInitialWorkerEvents) {
        _knownWorkerEventIds
          ..clear()
          ..addAll(currentEventIds);
        _didReceiveInitialWorkerEvents = true;
        return;
      }

      final newEvents =
          events.where((event) => !_knownWorkerEventIds.contains(event.id)).toList();

      for (final event in newEvents) {
        pushNotification.showShiftRegistrationStarted(
          eventId: event.id,
          title: 'Открыта запись на смену',
          body:
              '${event.title}, ${event.formattedDate} ${event.formattedTime}',
        );
      }

      _knownWorkerEventIds
        ..clear()
        ..addAll(currentEventIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        currentIndex >= pages.length ? pages.length - 1 : currentIndex;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {
        final colorScheme = Theme.of(context).colorScheme;
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
          body: pages[selectedIndex],

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
            ),

            child: BottomNavigationBar(
              currentIndex: selectedIndex,

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

              selectedItemColor: colorScheme.primary,
              unselectedItemColor: greyColor,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Главная',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: 'Ваши смены',
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Профиль',
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
    return ShiftsPage(
      title: context.t.mobile.shifts,
      emptyMessage: 'Пока нет доступных смен',
      stream: context.read<HomeCubit>().watchWorkerEvents(),
    );
  }
}

class BookedShiftsPage extends StatelessWidget {
  const BookedShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShiftsPage(
      title: 'Мои смены',
      emptyMessage: 'Вы пока не записались на смены',
      stream: context.read<HomeCubit>().watchBookedEvents(),
    );
  }
}

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({
    required this.title,
    required this.emptyMessage,
    required this.stream,
    super.key,
  });

  final String title;
  final String emptyMessage;
  final Stream<List<EventModel>> stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: StreamBuilder<List<EventModel>>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final events = snapshot.data ?? const <EventModel>[];

            if (events.isEmpty) {
              return Center(child: Text(emptyMessage));
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
