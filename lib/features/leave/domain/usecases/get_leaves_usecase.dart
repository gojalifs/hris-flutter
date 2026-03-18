import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeavesUseCase extends UseCase<List<LeaveEntity>, GetLeavesParams> {
  final LeaveRepository repository;

  GetLeavesUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveEntity>>> call(GetLeavesParams params) {
    return repository.getLeaves(
      employeeId: params.employeeId,
      status: params.status,
    );
  }
}

class GetLeavesParams extends Equatable {
  final String employeeId;
  final String? status;

  const GetLeavesParams({required this.employeeId, this.status});

  @override
  List<Object?> get props => [employeeId, status];
}
