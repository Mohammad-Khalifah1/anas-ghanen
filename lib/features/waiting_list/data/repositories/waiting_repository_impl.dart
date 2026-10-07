import '../../domain/entities/waiting_group.dart';
import '../../domain/repositories/waiting_repository.dart';
import '../datasources/waiting_local_datasource.dart';

class WaitingRepositoryImpl implements WaitingRepository {
  final WaitingLocalDataSource localDataSource;

  const WaitingRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<WaitingGroup> addGroup({
    required String name,
    required int partySize,
  }) async {
    final model = await localDataSource.addGroup(
      name: name,
      partySize: partySize,
    );

    return model.toEntity();
  }

  @override
  Future<List<WaitingGroup>> getWaitingGroups() async {
    final models = await localDataSource.getAllGroups();

    return models
        .where(
          (model) => model.status == WaitingGroupStatus.waiting,
        )
        .map(
          (model) => model.toEntity(),
        )
        .toList();
  }

  @override
  Future<void> removeGroup(String id) {
    return localDataSource.cancelGroup(id);
  }

  @override
  Future<void> markAsSeated(String id) {
    return localDataSource.markAsSeated(id);
  }

  @override
  Future<int> getGroupsAhead(String id) {
    return localDataSource.getGroupsAhead(id);
  }
}