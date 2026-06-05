import 'package:diplom/data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import 'package:diplom/data/repositories/home_repository/home_repository.dart';
import 'package:diplom/domain/models/event/event_model.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:flutter/material.dart';

class ShiftsList extends StatelessWidget {
  ShiftsList({super.key})
    : _repository = HomeRepository(provider: FirebaseDataProvider());

  final HomeRepository _repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      appBar: AppBar(
        backgroundColor: mainBackground,
        title: const Text('Список мероприятий'),
      ),
      body: StreamBuilder<List<EventModel>>(
        stream: _repository.watchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final events = snapshot.data ?? const <EventModel>[];

          if (events.isEmpty) {
            return const Center(child: Text('Пока нет мероприятий'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 640;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView.separated(
                    padding: EdgeInsets.all(isCompact ? 16 : 24),
                    itemCount: events.length,
                    separatorBuilder:
                        (context, index) =>
                            SizedBox(height: isCompact ? 12 : 16),
                    itemBuilder:
                        (context, index) => _EventCard(event: events[index]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;

        return Container(
          padding: EdgeInsets.all(isCompact ? 18 : 24),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(isCompact ? 18 : 25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: context.titleMedium.copyWith(
                        fontSize: isCompact ? 20 : 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${event.assignedCount}/${event.workerCount}',
                    style: context.bodyMedium.copyWith(
                      color: mainGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('${event.formattedDate}  ${event.formattedTime}'),
              const SizedBox(height: 8),
              Text('Место: ${event.location}'),
              const SizedBox(height: 8),
              Text('Должность: ${event.roleTitle}'),
              const SizedBox(height: 8),
              Text('Оплата: ${event.salary} руб/час'),
              const SizedBox(height: 12),
              Text(event.description),
              const SizedBox(height: 20),
              Text(
                'Записались',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (event.assignedWorkers.isEmpty)
                const Text('Пока никто не записался')
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      event.assignedWorkers
                          .map((worker) => _WorkerChip(worker: worker))
                          .toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _WorkerChip extends StatelessWidget {
  const _WorkerChip({required this.worker});

  final Map<String, dynamic> worker;

  @override
  Widget build(BuildContext context) {
    final name = _workerName(worker);
    final role = EventModel.roleTitleFromRole(worker['role']?.toString() ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: backgroundTextFieldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text('$name, $role', overflow: TextOverflow.ellipsis),
    );
  }

  String _workerName(Map<String, dynamic> worker) {
    final lastName = worker['lastName']?.toString() ?? '';
    final name = worker['name']?.toString() ?? '';
    final surname = worker['surname']?.toString() ?? '';
    final fullName = [
      lastName,
      name,
      surname,
    ].where((part) => part.trim().isNotEmpty).join(' ');

    if (fullName.isNotEmpty) {
      return fullName;
    }

    return worker['email']?.toString() ?? 'Без имени';
  }
}
