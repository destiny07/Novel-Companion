import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_lyca/models/models.dart';
import 'package:project_lyca/repositories/contracts/contracts.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {
  final DataRepository dataRepository;

  UserConfigBloc({required this.dataRepository})
      : super(const UserConfigState.initial());

  @override
  Stream<UserConfigState> mapEventToState(UserConfigEvent event) {
    throw UnimplementedError();
  }
}
