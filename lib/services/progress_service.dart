import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  ProgressService._internal();
  static final ProgressService instance = ProgressService._internal();

  int totalStars = 0;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    totalStars = prefs.getInt('zanako_total_stars') ?? 0;
  }

  Future<void> addStar() async {
    totalStars += 1;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zanako_total_stars', totalStars);
  }
}
