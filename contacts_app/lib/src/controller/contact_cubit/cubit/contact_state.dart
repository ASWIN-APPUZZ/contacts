part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

final class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactCreateStateInitial extends ContactState {
  @override
  List<Object> get props => [];
}
//create states

final class ContactCreateStateLoading extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactCreateStateSuccess extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactCreateStateError extends ContactState {
  @override
  List<Object> get props => [];
}

//read states

final class ContactReadStateInitial extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactReadStateLoading extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactReadStateSuccess extends ContactState {
  final List<ContactModel> data;
  ContactReadStateSuccess({required this.data});
  @override
  List<Object> get props => [this.data];
}

final class ContactReadStateError extends ContactState {
  final String error;
  ContactReadStateError({required this.error});
  @override
  List<Object> get props => [error];
}

//update states

final class ContactUpdateStateInitial extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactUpdateStateLoading extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactUpdateStateSuccess extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactUpdateStateError extends ContactState {
  @override
  List<Object> get props => [];
}

//delete states

final class ContactDeleteStateInitial extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactDeleteStateLoading extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactDeleteStateSuccess extends ContactState {
  @override
  List<Object> get props => [];
}

final class ContactDeleteStateError extends ContactState {
  ContactDeleteStateError();

  @override
  List<Object> get props => [];
}