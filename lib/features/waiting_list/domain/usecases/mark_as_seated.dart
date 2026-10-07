import '../../../../core/usecase/usecase.dart';
import '../repositories/waiting_repository.dart';

class MarkAsSeated implements UseCase<void, MarkAsSeatedParams> {
  final WaitingRepository repository;

  const MarkAsSeated(this.repository);

  @override
  Future<void> call(MarkAsSeatedParams params) {
    return repository.markAsSeated(params.id);
  }
}

class MarkAsSeatedParams {
  final String id;

  const MarkAsSeatedParams({
    required this.id,
  });
}