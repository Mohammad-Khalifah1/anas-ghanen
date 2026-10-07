import '../../domain/entities/waiting_group.dart';

class WaitingGroupModel {
  final String id;
  final int ticketNumber;
  final String name;
  final int partySize;
  final DateTime createdAt;
  final WaitingGroupStatus status;

  const WaitingGroupModel({
    required this.id,
    required this.ticketNumber,
    required this.name,
    required this.partySize,
    required this.createdAt,
    required this.status,
  });

  factory WaitingGroupModel.fromEntity(WaitingGroup entity) {
    return WaitingGroupModel(
      id: entity.id,
      ticketNumber: entity.ticketNumber,
      name: entity.name,
      partySize: entity.partySize,
      createdAt: entity.createdAt,
      status: entity.status,
    );
  }

  WaitingGroup toEntity() {
    return WaitingGroup(
      id: id,
      ticketNumber: ticketNumber,
      name: name,
      partySize: partySize,
      createdAt: createdAt,
      status: status,
    );
  }

  factory WaitingGroupModel.fromMap(Map<dynamic, dynamic> map) {
    return WaitingGroupModel(
      id: map['id'] as String,
      ticketNumber: map['ticketNumber'] as int,
      name: map['name'] as String,
      partySize: map['partySize'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: WaitingGroupStatus.values.byName(
        map['status'] as String,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ticketNumber': ticketNumber,
      'name': name,
      'partySize': partySize,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  WaitingGroupModel copyWith({
    String? id,
    int? ticketNumber,
    String? name,
    int? partySize,
    DateTime? createdAt,
    WaitingGroupStatus? status,
  }) {
    return WaitingGroupModel(
      id: id ?? this.id,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      name: name ?? this.name,
      partySize: partySize ?? this.partySize,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}