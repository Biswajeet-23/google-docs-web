import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_web/app/constants.dart';
import 'package:google_docs_web/app/providers.dart';
import 'package:google_docs_web/models/models.dart';
import 'package:google_docs_web/repositories/repository_exception.dart';

final _databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return DatabaseRepository(ref.read);
});

class DatabaseRepository with RepositoryExceptionMixin {
  DatabaseRepository(this._read);

  final Reader _read;

  static Provider<DatabaseRepository> get provider =>
      _databaseRepositoryProvider;

  Databases get _database => _read(Dependency.database);

  Future<void> createNewPage({
    required String documentId,
    required String owner,
  }) async {
    return exceptionHandler(
        _createPageAndDelta(owner: owner, documentId: documentId));
  }

  Future<void> _createPageAndDelta({
    required String documentId,
    required String owner,
  }) async {
    Future.wait([
      _database.createDocument(
        databaseId: appwriteDatabaseId,
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: {
          'owner': owner,
          'title': null,
          'content': null,
        },
      ),
      _database.createDocument(
        databaseId: appwriteDatabaseId,
        collectionId: CollectionNames.delta,
        documentId: documentId,
        data: {
          'delta': null,
          'user': null,
          'deviceId': null,
        },
      ),
    ]);
  }

  Future<DocumentPageData> getPage({
    required String documentId,
  }) {
    return exceptionHandler(_getPage(documentId));
  }

  Future<DocumentPageData> _getPage(String documentId) async {
    final doc = await _database.getDocument(
      databaseId: appwriteDatabaseId,
      collectionId: CollectionNames.pages,
      documentId: documentId,
    );
    return DocumentPageData.fromMap(doc.data);
  }

  Future<void> updatePage(
      {required String documentId,
        required DocumentPageData documentPage}) async {
    return exceptionHandler(
      _database.updateDocument(
        databaseId: appwriteDatabaseId,
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: documentPage.toMap(),
      ),
    );
  }
}