
class TaskCacheManagerException implements Exception{
  @override
  String toString(){
    return "TaskCacheManager instance has not been initialized.";
  }
}