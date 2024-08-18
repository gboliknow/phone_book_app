

abstract class LocalCache {
  ///Saves draft
  Future<void> saveDraft(String draftKey);

  ///Retrieves access token for authorizing requests
  Future<String> getToken();

  ///Saves access token for authorizing requests
  Future<void> saveToken(String tokenId);

  ///Deletes cached access token
  Future<void> deleteToken();

  ///Saves `value` to cache using `key`
  Future<void> saveToLocalCache({required String key, required dynamic value});

  ///Retrieves a cached value stored with `key`
  Object? getFromLocalCache(String key);

  ///Removes cached value stored with `key` from cache
  Future<void> removeFromLocalCache(String key);

  ///Caches data of current user
  Future<void> cacheUserData({required String value});

  Future<void> cacheUserArtistData({required String value});



  ///Deletes cached current user data
  Future<void> deleteUserData();

  ///This shows app tour
  Future<void> saveShowOverlay({required String key, required bool value});

  ///This shows app tour
  bool getShowOverlay({required String key});
}
