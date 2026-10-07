import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/waiting_provider.dart';
import '../widgets/add_group_sheet.dart';
import '../widgets/group_tile.dart';

class WaitingListPage extends StatelessWidget {
  const WaitingListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الانتظار'),
        centerTitle: true,
      ),
      body: Consumer<WaitingProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.groups.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.groups.isEmpty) {
            return const _EmptyState();
          }

          return RefreshIndicator(
            onRefresh: provider.loadGroups,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.groups.length,
              itemBuilder: (context, index) {
                final group = provider.groups[index];

                return GroupTile(
                  group: group,
                  groupsAhead: index,
                  onSeat: () {
                    provider.seatGroup(group.id);
                  },
                  onCancel: () {
                    provider.cancelGroup(group.id);
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddGroupSheet(),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text('إضافة مجموعة'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_seat_outlined,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'لا توجد مجموعات في قائمة الانتظار',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'أضف أول مجموعة للبدء',
          ),
        ],
      ),
    );
  }
}