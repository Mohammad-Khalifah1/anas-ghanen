import 'package:flutter/material.dart';

import '../../domain/entities/waiting_group.dart';

class TicketDialog extends StatelessWidget {
  final WaitingGroup group;
  final int groupsAhead;

  const TicketDialog({
    super.key,
    required this.group,
    required this.groupsAhead,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'تمت الإضافة بنجاح',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'رقم التذكرة',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '#${group.ticketNumber}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            group.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            groupsAhead == 0
                ? 'أنت التالي!'
                : 'يوجد $groupsAhead مجموعات أمامك',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('تم'),
        ),
      ],
    );
  }
}