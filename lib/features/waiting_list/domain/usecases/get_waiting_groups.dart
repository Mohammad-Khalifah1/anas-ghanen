import '../../../../core/usecase/usecase.dart';
import '../entities/waiting_group.dart';
import '../repositories/waiting_repository.dart';

class GetWaitingGroups implements UseCase<List<WaitingGroup>, NoParams> {
  final WaitingRepository repository;

  const GetWaitingGroups(this.repository);

  @override
  Future<List<WaitingGroup>> call(NoParams params) {
    return repository.getWaitingGroups();
  }
}