const appwriteEndpoint = 'http://localhost/v1';
const appwriteProjectId = '652f623728dbe98a96b5';
const appwriteDatabaseId = '6530c69109dbbaa69bbb';

abstract class CollectionNames {
  static String get delta => 'delta';
  static String get deltaDocumentsPath => 'collections.$delta.documents';
  static String get pages => 'pages';
  static String get pagesDocumentsPath => 'collections.$pages.documents';
}