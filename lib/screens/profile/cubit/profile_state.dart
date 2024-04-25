part of 'profile_cubit.dart';

abstract class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final List<DocumentSnapshot> profileData;

  ProfileLoaded(this.profileData);
}

final class ProfileError extends ProfileState {
  final String error;
  ProfileError(this.error);
}
