part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class InitProfileState extends ProfileState{}

class ChooseAvatarProfileState extends ProfileState {
  const ChooseAvatarProfileState(this.avatar);
  final String avatar;

  @override
  List<Object?> get props => [avatar];
}

class LoadingProfileState extends ProfileState {
  const LoadingProfileState();

  @override
  List<Object?> get props => [];
}


class LoadedProfileState extends ProfileState {
  const LoadedProfileState(this.user);
  final UserModel user;

  @override
  List<Object?> get props => [user];
}