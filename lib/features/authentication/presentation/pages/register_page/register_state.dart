import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class RegisterState extends Equatable {
  final RequestStatus registerState;
  final UserData userData;
  final String errorMessage;
  final RequestStatus getUniversitiesState;
  final List<String> universities;
  final RequestStatus getFacultiesState;
  final List<String> faculties;

  const RegisterState(
      {this.registerState = RequestStatus.initial,
        this.userData=const UserData.initial(),
      this.errorMessage = '',
      this.getUniversitiesState = RequestStatus.initial,
      this.universities = const [],
      this.getFacultiesState = RequestStatus.initial,
      this.faculties = const []});

  RegisterState copyWith({
    RequestStatus? registerState,
    UserData ? userData,
    String? errorMessage,
    RequestStatus? getUniversitiesState,
    List<String>? universities,
    RequestStatus? getFacultiesState,
    List<String>? faculties,
  }) {
    return RegisterState(
      errorMessage: errorMessage ?? this.errorMessage,
      registerState: registerState ?? this.registerState,
      userData: userData??this.userData,
      getFacultiesState: getFacultiesState ?? this.getFacultiesState,
      getUniversitiesState: getUniversitiesState ?? this.getUniversitiesState,
      faculties: faculties ?? this.faculties,
      universities: universities ?? this.universities,
    );
  }

  @override
  List<Object?> get props => [registerState,userData,errorMessage,getUniversitiesState,universities,getFacultiesState,faculties];
}
