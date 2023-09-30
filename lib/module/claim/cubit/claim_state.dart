part of 'claim_cubit.dart';

enum CountryStatus {
  initial,
  loading,
  loaded,
  error,
}

enum ClaimTicketStatus {
  initial,
  loading,
  loaded,
  error,
}

enum BankStatus {
  initial,
  loading,
  loaded,
  error,
}

enum ClaimBankStatus {
  initial,
  loading,
  loaded,
  error,
}

class ClaimState extends Equatable {
  final CountryStatus countryStatus;
  final BankStatus bankStatus;
  final ClaimTicketStatus claimTicketStatus;
  final ClaimBankStatus claimBankStatus;
  final List countryList;
  final List bankList;
  final String currentDate;
  final String errorText;
  final TextEditingController raffleIdCntrllr;
  final TextEditingController countryCntrllr;
  final TextEditingController bankCntrllr;
  final TextEditingController ibanCntrllr;
  const ClaimState({
    required this.countryStatus,
    required this.bankList,
    required this.currentDate,
    required this.countryList,
    required this.bankStatus,
    required this.bankCntrllr,
    required this.countryCntrllr,
    required this.ibanCntrllr,
    required this.raffleIdCntrllr,
    required this.claimTicketStatus,
    required this.errorText,
    required this.claimBankStatus,
  });

  factory ClaimState.initial() {
    return ClaimState(
      countryStatus: CountryStatus.initial,
      bankList: const [],
      currentDate: 'See all',
      countryList: const [],
      bankStatus: BankStatus.initial,
      bankCntrllr: TextEditingController(),
      countryCntrllr: TextEditingController(),
      ibanCntrllr: TextEditingController(),
      raffleIdCntrllr: TextEditingController(),
      claimTicketStatus: ClaimTicketStatus.initial,
      errorText: '',
      claimBankStatus: ClaimBankStatus.initial,
    );
  }

  ClaimState copyWith({
    CountryStatus? countryStatus,
    List? bankList,
    String? currentDate,
    List? countryList,
    BankStatus? bankStatus,
    TextEditingController? raffleIdCntrllr,
    TextEditingController? countryCntrllr,
    TextEditingController? bankCntrllr,
    TextEditingController? ibanCntrllr,
    ClaimTicketStatus? claimTicketStatus,
    String? errorText,
    ClaimBankStatus? claimBankStatus,
  }) {
    return ClaimState(
      currentDate: currentDate ?? this.currentDate,
      countryStatus: countryStatus ?? this.countryStatus,
      bankList: bankList ?? this.bankList,
      countryList: countryList ?? this.countryList,
      bankStatus: bankStatus ?? this.bankStatus,
      bankCntrllr: bankCntrllr ?? this.bankCntrllr,
      countryCntrllr: countryCntrllr ?? this.countryCntrllr,
      ibanCntrllr: ibanCntrllr ?? this.ibanCntrllr,
      raffleIdCntrllr: raffleIdCntrllr ?? this.raffleIdCntrllr,
      claimTicketStatus: claimTicketStatus ?? this.claimTicketStatus,
      errorText: errorText ?? this.errorText,
      claimBankStatus: claimBankStatus ?? this.claimBankStatus,
    );
  }

  @override
  List<Object> get props {
    return [
      countryStatus,
      bankList,
      currentDate,
      bankStatus,
      countryList,
      countryCntrllr,
      bankCntrllr,
      raffleIdCntrllr,
      ibanCntrllr,
      claimTicketStatus,
      errorText,
      claimBankStatus,
    ];
  }
}
