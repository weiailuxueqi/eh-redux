// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStoreBase, Store {
  final _$dataAtom = Atom(name: '_GalleryStoreBase.data');

  @override
  ObservableMap<GalleryId, Gallery> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(ObservableMap<GalleryId, Gallery> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$detailsAtom = Atom(name: '_GalleryStoreBase.details');

  @override
  ObservableMap<GalleryId, GalleryDetails> get details {
    _$detailsAtom.reportRead();
    return super.details;
  }

  @override
  set details(ObservableMap<GalleryId, GalleryDetails> value) {
    _$detailsAtom.reportWrite(value, super.details, () {
      super.details = value;
    });
  }

  final _$errorsAtom = Atom(name: '_GalleryStoreBase.errors');

  @override
  ObservableMap<GalleryId, GalleryError> get errors {
    _$errorsAtom.reportRead();
    return super.errors;
  }

  @override
  set errors(ObservableMap<GalleryId, GalleryError> value) {
    _$errorsAtom.reportWrite(value, super.errors, () {
      super.errors = value;
    });
  }

  final _$contentWarningDisabledAtom =
      Atom(name: '_GalleryStoreBase.contentWarningDisabled');

  @override
  ObservableSet<GalleryId> get contentWarningDisabled {
    _$contentWarningDisabledAtom.reportRead();
    return super.contentWarningDisabled;
  }

  @override
  set contentWarningDisabled(ObservableSet<GalleryId> value) {
    _$contentWarningDisabledAtom
        .reportWrite(value, super.contentWarningDisabled, () {
      super.contentWarningDisabled = value;
    });
  }

  final _$paginationsAtom = Atom(name: '_GalleryStoreBase.paginations');

  @override
  ObservableMap<GalleryPaginationKey, Pagination<GalleryId>> get paginations {
    _$paginationsAtom.reportRead();
    return super.paginations;
  }

  @override
  set paginations(
      ObservableMap<GalleryPaginationKey, Pagination<GalleryId>> value) {
    _$paginationsAtom.reportWrite(value, super.paginations, () {
      super.paginations = value;
    });
  }

  final _$loadInitialPageAsyncAction =
      AsyncAction('_GalleryStoreBase.loadInitialPage');

  @override
  Future<void> loadInitialPage(GalleryPaginationKey key) {
    return _$loadInitialPageAsyncAction.run(() => super.loadInitialPage(key));
  }

  final _$loadNextPageAsyncAction =
      AsyncAction('_GalleryStoreBase.loadNextPage');

  @override
  Future<void> loadNextPage(GalleryPaginationKey key) {
    return _$loadNextPageAsyncAction.run(() => super.loadNextPage(key));
  }

  final _$refreshPageAsyncAction = AsyncAction('_GalleryStoreBase.refreshPage');

  @override
  Future<void> refreshPage(GalleryPaginationKey key) {
    return _$refreshPageAsyncAction.run(() => super.refreshPage(key));
  }

  final _$loadGalleryDetailsAsyncAction =
      AsyncAction('_GalleryStoreBase.loadGalleryDetails');

  @override
  Future<void> loadGalleryDetails(GalleryId id) {
    return _$loadGalleryDetailsAsyncAction
        .run(() => super.loadGalleryDetails(id));
  }

  final _$saveGalleryAsyncAction = AsyncAction('_GalleryStoreBase.saveGallery');

  @override
  Future<void> saveGallery(GalleryId id) {
    return _$saveGalleryAsyncAction.run(() => super.saveGallery(id));
  }

  final _$_GalleryStoreBaseActionController =
      ActionController(name: '_GalleryStoreBase');

  @override
  void add(Gallery gallery) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.add');
    try {
      return super.add(gallery);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAll(Iterable<Gallery> gallery) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.addAll');
    try {
      return super.addAll(gallery);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentFavorite(GalleryId id, int value) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.setCurrentFavorite');
    try {
      return super.setCurrentFavorite(id, value);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disableContentWarning(GalleryId id) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.disableContentWarning');
    try {
      return super.disableContentWarning(id);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
details: ${details},
errors: ${errors},
contentWarningDisabled: ${contentWarningDisabled},
paginations: ${paginations}
    ''';
  }
}
