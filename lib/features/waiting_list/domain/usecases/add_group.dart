import '../../../../core/usecase/usecase.dart';
import '../entities/waiting_group.dart';
import '../repositories/waiting_repository.dart';

class AddGroup implements UseCase<WaitingGroup, AddGroupParams> {
  final WaitingRepository repository;

  const AddGroup(this.repository);

  @override
  Future<WaitingGroup> call(AddGroupParams params) {
    return repository.addGroup(
      name: params.name,
      partySize: params.partySize,
    );
  }
}

class AddGroupParams {
  final String name;
  final int partySize;

  const AddGroupParams({
    required this.name,
    required this.partySize,
  });
}