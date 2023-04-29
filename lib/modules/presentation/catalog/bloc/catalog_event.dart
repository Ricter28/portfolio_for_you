part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}


class InitCatalogEvent extends CatalogEvent {
  const InitCatalogEvent();
  

  @override
  List<Object?> get props => [];
}

class SearchCatalogEvent extends CatalogEvent {
  const SearchCatalogEvent( this.keyWork,);
  final String keyWork;
  

  @override
  List<Object?> get props => [keyWork,];
}

class CreateCatalogEvent extends CatalogEvent {
  const CreateCatalogEvent( this.data,);
  final String data;
  

  @override
  List<Object?> get props => [data,];
}

class UpdateCatalogEvent extends CatalogEvent {
  const UpdateCatalogEvent( this.id, this.data,);
  final String id;
  final String data;
  

  @override
  List<Object?> get props => [id,data,];
}

class DeleteCatalogEvent extends CatalogEvent {
  const DeleteCatalogEvent( this.id,);
  final String id;
  

  @override
  List<Object?> get props => [id,];
}
