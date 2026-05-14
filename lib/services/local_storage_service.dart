import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static String _topicKey(String studentName, String topicTitle) {
    return 'topic_${studentName}_$topicTitle';
  }

  Future<void> saveTopicStatus({
    required String studentName,
    required String topicTitle,
    required bool isDone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_topicKey(studentName, topicTitle), isDone);
  }

  Future<bool?> getTopicStatus({
    required String studentName,
    required String topicTitle,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_topicKey(studentName, topicTitle));
  }
}
