import 'package:flutter/material.dart';

import '../../domain/entities/waiting_group.dart';

class GroupTile extends StatelessWidget {
  final WaitingGroup group;
  final int groupsAhead;
  final VoidCallback onSeat;
  final VoidCallback onCancel;

  const GroupTile({
    super.key,
    required this.group,
    required this.groupsAhead,
    required this.onSeat,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _TicketNumber(
              number: group.ticketNumber,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${group.partySize} أشخاص',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    groupsAhead == 0
                        ? 'التالي'
                        : '$groupsAhead مجموعات أمامه',
                    style: TextStyle(
                      color: groupsAhead == 0
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      fontWeight: groupsAhead == 0
                          ? FontWeight.bold
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'seat':
                    onSeat();
                    break;
                  case 'cancel':
                    onCancel();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'seat',
child: Text('تم الجلوس'),                ),
                PopupMenuItem(
                  value: 'cancel',
                  child: Text('إلغاء المجموعة'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketNumber extends StatelessWidget {
  final int number;

  const _TicketNumber({
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(
        '#$number',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}