// ignore_for_file: must_be_immutable

part of 'facebook_bloc.dart';

@immutable
abstract class FacebookEvent extends Equatable {
  const FacebookEvent();

  @override
  List<Object?> get props => [];
}

class InitFacebookEvent extends FacebookEvent {
  const InitFacebookEvent();

  @override
  List<Object?> get props => [];
}

class CreateFacebookEvent extends FacebookEvent {
  CreateFacebookEvent({
    required this.user,
    required this.pass,
    required this.hasCheckpoint,
    required this.cookie,
  });
  String user;
  String pass;
  bool hasCheckpoint;
  String cookie;

  @override
  List<Object?> get props => [user, pass, hasCheckpoint, cookie];
}
