import 'package:diplom/data/data_provider/firebase_data_provider/firebase_data_provider.dart';
import 'package:diplom/data/repositories/home_repository/home_repository.dart';
import 'package:diplom/domain/models/worker/worker_model.dart';
import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/style_text.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class WorkerList extends StatelessWidget {
  WorkerList({super.key})
    : _repository = HomeRepository(provider: FirebaseDataProvider());

  final HomeRepository _repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      appBar: AppBar(
        backgroundColor: mainBackground,
        title: Text(context.t.web.listWorker),
      ),
      body: StreamBuilder<List<WorkerModel>>(
        stream: _repository.watchWorkers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final workers = snapshot.data ?? const <WorkerModel>[];

          if (workers.isEmpty) {
            return const Center(child: Text('Сотрудников пока нет'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 640;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: ListView.separated(
                    padding: EdgeInsets.all(isCompact ? 16 : 24),
                    itemCount: workers.length,
                    separatorBuilder:
                        (context, index) =>
                            SizedBox(height: isCompact ? 10 : 12),
                    itemBuilder: (context, index) {
                      return _WorkerCard(
                        worker: workers[index],
                        onDelete: () => _deleteWorker(context, workers[index]),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteWorker(BuildContext context, WorkerModel worker) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Удалить сотрудника?'),
            content: Text(
              '${worker.fullName}\n\nСотрудник будет удален из списка и из записей на мероприятия.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  context.t.web.createWorker.delete,
                  style: const TextStyle(color: redColor),
                ),
              ),
            ],
          ),
    );

    if (shouldDelete != true) return;

    try {
      await _repository.deleteWorker(worker.uid);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Сотрудник удален'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: redColor,
        ),
      );
    }
  }
}

class _WorkerCard extends StatelessWidget {
  const _WorkerCard({required this.worker, required this.onDelete});

  final WorkerModel worker;
  final VoidCallback onDelete;

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      worker.fullName,
                      style: context.titleMedium.copyWith(
                        fontSize: isCompact ? 19 : 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: onDelete,
                    color: redColor,
                    tooltip: context.t.web.createWorker.delete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoRow(title: 'Фамилия', value: worker.lastName),
              _InfoRow(title: 'Имя', value: worker.name),
              _InfoRow(title: 'Отчество', value: worker.surname),
              _InfoRow(title: 'Должность', value: worker.roleTitle),
              _InfoRow(title: 'Email', value: worker.email),
              SelectionArea(child: _InfoRow(title: 'UID', value: worker.uid)),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: context.bodyMedium,
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value.isEmpty ? '-' : value),
          ],
        ),
      ),
    );
  }
}
