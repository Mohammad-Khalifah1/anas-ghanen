enum WaitingGroupStatus {
  waiting,
  seated,
  cancelled,
}

class WaitingGroup {
  final String id;
  final int ticketNumber;
  final String name;
  final int partySize;
  final DateTime createdAt;
  final WaitingGroupStatus status;

  const WaitingGroup({
    required this.id,
    required this.ticketNumber,
    required this.name,
    required this.partySize,
    required this.createdAt,
    this.status = WaitingGroupStatus.waiting,
  });

  WaitingGroup copyWith({
    String? id,
    int? ticketNumber,
    String? name,
    int? partySize,
    DateTime? createdAt,
    WaitingGroupStatus? status,
  }) {
    return WaitingGroup(
      id: id ?? this.id,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      name: name ?? this.name,
      partySize: partySize ?? this.partySize,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}