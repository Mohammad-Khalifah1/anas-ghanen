import '../../../../core/usecase/usecase.dart';
import '../repositories/waiting_repository.dart';

class RemoveGroup implements UseCase<void, RemoveGroupParams> {
  final WaitingRepository repository;

  const RemoveGroup(this.repository);

  @override
  Future<void> call(RemoveGroupParams params) {
    return repository.removeGroup(params.id);
  }
}

class RemoveGroupParams {
  final String id;

  const RemoveGroupParams({
    required this.id,
  });
}