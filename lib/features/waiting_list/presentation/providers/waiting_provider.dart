import 'package:flutter/foundation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/waiting_group.dart';
import '../../domain/usecases/add_group.dart';
import '../../domain/usecases/get_groups_ahead.dart';
import '../../domain/usecases/get_waiting_groups.dart';
import '../../domain/usecases/mark_as_seated.dart';
import '../../domain/usecases/remove_group.dart';

class WaitingProvider extends ChangeNotifier {
  final AddGroup addGroup;
  final GetWaitingGroups getWaitingGroups;
  final RemoveGroup removeGroup;
  final MarkAsSeated markAsSeated;
  final GetGroupsAhead getGroupsAhead;

  WaitingProvider({
    required this.addGroup,
    required this.getWaitingGroups,
    required this.removeGroup,
    required this.markAsSeated,
    required this.getGroupsAhead,
  });

  List<WaitingGroup> _groups = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<WaitingGroup> get groups => List.unmodifiable(_groups);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> loadGroups() async {
    await _execute(
      action: () async {
        final groups = await getWaitingGroups(const NoParams());

        _groups = groups;
      },
    );
  }

  Future<WaitingGroup?> addNewGroup({
    required String name,
    required int partySize,
  }) async {
    WaitingGroup? createdGroup;

    await _execute(
      action: () async {
        createdGroup = await addGroup(
          AddGroupParams(
            name: name,
            partySize: partySize,
          ),
        );

        _groups = [
          ..._groups,
          createdGroup!,
        ];
      },
    );

    return createdGroup;
  }

  Future<void> seatGroup(String id) async {
    await _execute(
      action: () async {
        await markAsSeated(
          MarkAsSeatedParams(id: id),
        );

        _groups = _groups
            .where((group) => group.id != id)
            .toList();
      },
    );
  }

  Future<void> cancelGroup(String id) async {
    await _execute(
      action: () async {
        await removeGroup(
          RemoveGroupParams(id: id),
        );

        _groups = _groups
            .where((group) => group.id != id)
            .toList();
      },
    );
  }

  Future<int> groupsAhead(String id) {
    return getGroupsAhead(
      GetGroupsAheadParams(id: id),
    );
  }

  Future<void> _execute({
    required Future<void> Function() action,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      await action();
    } catch (error) {
      _errorMessage = 'حدث خطأ أثناء تنفيذ العملية.';
      debugPrint('WaitingProvider error: $error');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }
}