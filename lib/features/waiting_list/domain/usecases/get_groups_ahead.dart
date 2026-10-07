import '../../../../core/usecase/usecase.dart';
import '../repositories/waiting_repository.dart';

class GetGroupsAhead implements UseCase<int, GetGroupsAheadParams> {
  final WaitingRepository repository;

  const GetGroupsAhead(this.repository);

  @override
  Future<int> call(GetGroupsAheadParams params) {
    return repository.getGroupsAhead(params.id);
  }
}

class GetGroupsAheadParams {
  final String id;

  const GetGroupsAheadParams({
    required this.id,
  });
}