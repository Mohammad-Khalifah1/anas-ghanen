import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../features/waiting_list/data/datasources/waiting_local_datasource.dart';
import '../../features/waiting_list/data/repositories/waiting_repository_impl.dart';
import '../../features/waiting_list/domain/repositories/waiting_repository.dart';
import '../../features/waiting_list/domain/usecases/add_group.dart';
import '../../features/waiting_list/domain/usecases/get_groups_ahead.dart';
import '../../features/waiting_list/domain/usecases/get_waiting_groups.dart';
import '../../features/waiting_list/domain/usecases/mark_as_seated.dart';
import '../../features/waiting_list/domain/usecases/remove_group.dart';

class AppDependencies {
  final WaitingRepository waitingRepository;

  final AddGroup addGroup;
  final GetWaitingGroups getWaitingGroups;
  final RemoveGroup removeGroup;
  final MarkAsSeated markAsSeated;
  final GetGroupsAhead getGroupsAhead;

  const AppDependencies({
    required this.waitingRepository,
    required this.addGroup,
    required this.getWaitingGroups,
    required this.removeGroup,
    required this.markAsSeated,
    required this.getGroupsAhead,
  });
}

Future<AppDependencies> initializeDependencies() async {
  await Hive.initFlutter();

  final groupsBox = await Hive.openBox<dynamic>(
    WaitingLocalDataSource.groupsBoxName,
  );

  final metaBox = await Hive.openBox<dynamic>(
    WaitingLocalDataSource.metaBoxName,
  );

  final localDataSource = WaitingLocalDataSource(
    groupsBox: groupsBox,
    metaBox: metaBox,
    uuid: const Uuid(),
  );

  final waitingRepository = WaitingRepositoryImpl(
    localDataSource: localDataSource,
  );

  final addGroup = AddGroup(waitingRepository);
  final getWaitingGroups = GetWaitingGroups(waitingRepository);
  final removeGroup = RemoveGroup(waitingRepository);
  final markAsSeated = MarkAsSeated(waitingRepository);
  final getGroupsAhead = GetGroupsAhead(waitingRepository);

  return AppDependencies(
    waitingRepository: waitingRepository,
    addGroup: addGroup,
    getWaitingGroups: getWaitingGroups,
    removeGroup: removeGroup,
    markAsSeated: markAsSeated,
    getGroupsAhead: getGroupsAhead,
  );
}