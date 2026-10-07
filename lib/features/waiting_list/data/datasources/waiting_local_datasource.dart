import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../models/waiting_group_model.dart';
import '../../domain/entities/waiting_group.dart';

class WaitingLocalDataSource {
  static const String groupsBoxName = 'groups';
  static const String metaBoxName = 'meta';

  static const String ticketDateKey = 'ticket_date';
  static const String lastTicketNumberKey = 'last_ticket_number';

  final Box<dynamic> groupsBox;
  final Box<dynamic> metaBox;
  final Uuid uuid;

  const WaitingLocalDataSource({
    required this.groupsBox,
    required this.metaBox,
    required this.uuid,
  });

  Future<WaitingGroupModel> addGroup({
    required String name,
    required int partySize,
  }) async {
    final now = DateTime.now();
    final ticketNumber = await _getNextTicketNumber(now);

    final model = WaitingGroupModel(
      id: uuid.v4(),
      ticketNumber: ticketNumber,
      name: name.trim(),
      partySize: partySize,
      createdAt: now,
      status: WaitingGroupStatus.waiting,
    );

    await groupsBox.put(
      model.id,
      model.toMap(),
    );

    return model;
  }

  Future<List<WaitingGroupModel>> getAllGroups() async {
    final models = <WaitingGroupModel>[];

    for (final value in groupsBox.values) {
      if (value is! Map) {
        continue;
      }

      final model = WaitingGroupModel.fromMap(value);

      models.add(model);
    }

    models.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );

    return models;
  }

  Future<void> updateGroup(WaitingGroupModel model) async {
    await groupsBox.put(
      model.id,
      model.toMap(),
    );
  }

  Future<void> cancelGroup(String id) async {
    final group = await _findGroupById(id);

    if (group == null) {
      return;
    }

    final cancelledGroup = group.copyWith(
      status: WaitingGroupStatus.cancelled,
    );

    await updateGroup(cancelledGroup);
  }

  Future<void> markAsSeated(String id) async {
    final group = await _findGroupById(id);

    if (group == null) {
      return;
    }

    final seatedGroup = group.copyWith(
      status: WaitingGroupStatus.seated,
    );

    await updateGroup(seatedGroup);
  }

  Future<int> getGroupsAhead(String id) async {
    final group = await _findGroupById(id);

    if (group == null) {
      return 0;
    }

    final groups = await getAllGroups();

    return groups.where((other) {
      return other.status == WaitingGroupStatus.waiting &&
          other.createdAt.isBefore(group.createdAt);
    }).length;
  }

  Future<int> _getNextTicketNumber(DateTime now) async {
    final today = _formatDate(now);

    final storedDate = metaBox.get(ticketDateKey) as String?;

    if (storedDate != today) {
      await metaBox.put(ticketDateKey, today);
      await metaBox.put(lastTicketNumberKey, 1);

      return 1;
    }

    final lastTicketNumber =
        metaBox.get(lastTicketNumberKey) as int? ?? 0;

    final nextTicketNumber = lastTicketNumber + 1;

    await metaBox.put(
      lastTicketNumberKey,
      nextTicketNumber,
    );

    return nextTicketNumber;
  }

  Future<WaitingGroupModel?> _findGroupById(String id) async {
    final value = groupsBox.get(id);

    if (value is! Map) {
      return null;
    }

    return WaitingGroupModel.fromMap(value);
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}