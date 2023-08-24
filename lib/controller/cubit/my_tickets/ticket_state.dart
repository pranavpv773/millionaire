// ignore_for_file: must_be_immutable
part of 'ticket_cubit.dart';

enum MyTicketStatus {
  initial,
  loading,
  loaded,
  error,
}

class TicketState extends Equatable {
  final List<MyTicketData> myTickets;
  final MyTicketStatus myticketStatus;

  const TicketState({
    required this.myTickets,
    required this.myticketStatus,
  });

  factory TicketState.initial() {
    return const TicketState(
      myTickets: [],
      myticketStatus: MyTicketStatus.initial,
    );
  }

  TicketState copyWith({
    List<MyTicketData>? myTickets,
    final MyTicketStatus? myticketStatus,
  }) {
    return TicketState(
      myTickets: myTickets ?? this.myTickets,
      myticketStatus: myticketStatus ?? this.myticketStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      myTickets,
      myticketStatus,
    ];
  }
}
