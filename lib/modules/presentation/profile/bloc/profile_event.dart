part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}


class ChooseAvatarProfileEvent extends ProfileEvent {
  const ChooseAvatarProfileEvent(this.context);
  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class UpdateProfileEvent extends ProfileEvent{
  const UpdateProfileEvent(this.newUser, this.context);
  final UserModel newUser;
  final BuildContext context;
  @override
  List<Object?> get props => [newUser, context];
}

class InitProfileEvent extends ProfileEvent{
  const InitProfileEvent();
  @override
  List<Object?> get props => [];
}