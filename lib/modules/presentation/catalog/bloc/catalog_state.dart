part of 'catalog_bloc.dart';

@immutable
abstract class CatalogState extends Equatable {
  const CatalogState();
  @override
  List<Object?> get props => [];
}


class InitCatalogState extends CatalogState {
  const InitCatalogState();
  

  @override
  List<Object?> get props => [];
}

class LoadingCatalogState extends CatalogState {
  const LoadingCatalogState();
  

  @override
  List<Object?> get props => [];
}

class CreatedCatalogState extends CatalogState {
  const CreatedCatalogState();
  

  @override
  List<Object?> get props => [];
}

class UpdatedCatalogState extends CatalogState {
  const UpdatedCatalogState();
  

  @override
  List<Object?> get props => [];
}

class DeletedCatalogState extends CatalogState {
  const DeletedCatalogState();
  

  @override
  List<Object?> get props => [];
}

class LoadedCatalogState extends CatalogState {
  const LoadedCatalogState(this.results,);
  final List<String> results;
  

  @override
  List<Object?> get props => [results];
}

class ErrorCatalogState extends CatalogState {
  const ErrorCatalogState(this.errorMessage,);
  final String errorMessage;
  

  @override
  List<Object?> get props => [errorMessage];
}
