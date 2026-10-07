import '../entities/waiting_group.dart';

abstract class WaitingRepository {
  Future<WaitingGroup> addGroup({
    required String name,
    required int partySize,
  });

  Future<List<WaitingGroup>> getWaitingGroups();

  Future<void> removeGroup(String id);

  Future<void> markAsSeated(String id);

  Future<int> getGroupsAhead(String id);
}