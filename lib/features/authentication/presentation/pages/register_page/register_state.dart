import 'package:equatable/equatable.dart';
import 'package:graduation/shared/utils.dart';

class RegisterState extends Equatable {
  final RequestStatus registerState;
  final String errorMessage;
  final RequestStatus getUniversitiesState;
  final List<String> universities;
  final RequestStatus getFacultiesState;
  final List<String> faculties;

  const RegisterState(
      {this.registerState = RequestStatus.initial,
      this.errorMessage = '',
      this.getUniversitiesState = RequestStatus.initial,
      this.universities = const [],
      this.getFacultiesState = RequestStatus.initial,
      this.faculties = const []});

  RegisterState copyWith({
    RequestStatus? registerState,
    String? errorMessage,
    RequestStatus? getUniversitiesState,
    List<String>? universities,
    RequestStatus? getFacultiesState,
    List<String>? faculties,
  }) {
    return RegisterState(
      errorMessage: errorMessage ?? this.errorMessage,
      registerState: registerState ?? this.registerState,
      getFacultiesState: getFacultiesState ?? this.getFacultiesState,
      getUniversitiesState: getUniversitiesState ?? this.getUniversitiesState,
      faculties: faculties ?? this.faculties,
      universities: universities ?? this.universities,
    );
  }

  @override
  List<Object?> get props => [registerState,errorMessage,getUniversitiesState,universities,getFacultiesState,faculties];
}
