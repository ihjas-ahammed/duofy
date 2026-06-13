import 'package:shared_preferences/shared_preferences.dart';

class ActiveRequestInfo {
  final DateTime startTime;
  final Duration estimatedDuration;
  final String label;
  
  ActiveRequestInfo({
    required this.startTime,
    required this.estimatedDuration,
    required this.label,
  });
}

class AiEstimator {
  // Default values
  static const double defaultBaseOverhead = 6.0; // base overhead in seconds
  static const double defaultRatePer1000Chars = 0.8; // seconds per 1000 chars of payload
  
  static final Map<String, double> _baseOverheads = {};
  static final Map<String, double> _rates = {};
  
  static bool _initialized = false;
  
  // Registry for active AI requests (e.g. key = targetId, value = ActiveRequestInfo)
  static final Map<String, ActiveRequestInfo> activeRequests = {};
  
  static void Function(String targetId, ActiveRequestInfo info)? onRegisterActiveRequest;
  static void Function(String targetId)? onUnregisterActiveRequest;
  
  /// Preloads cached estimators from SharedPreferences
  static Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith('ai_est_base_')) {
          final model = key.substring('ai_est_base_'.length);
          _baseOverheads[model] = prefs.getDouble(key) ?? defaultBaseOverhead;
        } else if (key.startsWith('ai_est_rate_')) {
          final model = key.substring('ai_est_rate_'.length);
          _rates[model] = prefs.getDouble(key) ?? defaultRatePer1000Chars;
        }
      }
    } catch (e) {
      print('[AiEstimator] Error preloading from preferences: $e');
    }
    _initialized = true;
  }
  
  /// Estimates the duration (in seconds) synchronously based on current settings
  static double estimateDurationSync(String model, int payloadSize) {
    final base = _baseOverheads[model] ?? defaultBaseOverhead;
    final rate = _rates[model] ?? defaultRatePer1000Chars;
    final payloadKb = payloadSize / 1000.0;
    return base + (payloadKb * rate);
  }
  
  static double estimateUnitDurationSync({
    required String textModel,
    required String graphicsModel,
    required bool generateGraphics,
    int? plannedLessonsCount,
  }) {
    final int lessons = plannedLessonsCount ?? 4;
    
    // Plan request: ~8,000 characters payload
    final double planSecs = estimateDurationSync(textModel, 8000);
    
    // Lesson text requests: ~15,000 characters payload per lesson
    final double lessonTextSecs = estimateDurationSync(textModel, 15000);
    
    // Lesson graphics request: ~3,000 characters payload per diagram
    final double lessonArtSecs = generateGraphics ? estimateDurationSync(graphicsModel, 3000) : 0.0;
    
    return planSecs + lessons * (lessonTextSecs + lessonArtSecs);
  }
  
  /// Updates estimated parameters with a measured duration using Exponential Moving Average
  static Future<void> recordRequest(String model, int payloadSize, Duration actualDuration, {String? requestType}) async {
    await init();
    final double actualSeconds = actualDuration.inMilliseconds / 1000.0;
    final double payloadKb = payloadSize / 1000.0;
    
    final currentBase = _baseOverheads[model] ?? defaultBaseOverhead;
    final currentRate = _rates[model] ?? defaultRatePer1000Chars;
    
    const double alpha = 0.15; // smooth factor
    
    double newBase = currentBase;
    double newRate = currentRate;
    
    if (payloadKb < 1.0) {
      newBase = currentBase * (1.0 - alpha) + alpha * actualSeconds;
    } else {
      double derivedRate = (actualSeconds - currentBase) / payloadKb;
      if (derivedRate < 0.01) derivedRate = 0.01;
      newRate = currentRate * (1.0 - alpha) + alpha * derivedRate;
      newBase = currentBase * (1.0 - 0.05) + 0.05 * (actualSeconds - payloadKb * newRate);
    }
    
    // Clamp to logical limits
    newBase = newBase.clamp(1.0, 45.0);
    newRate = newRate.clamp(0.01, 15.0);
    
    _baseOverheads[model] = newBase;
    _rates[model] = newRate;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('ai_est_base_$model', newBase);
      await prefs.setDouble('ai_est_rate_$model', newRate);
    } catch (e) {
      print('[AiEstimator] Error persisting updates: $e');
    }
    
    print('[AiEstimator] Model "$model" updated: base=${newBase.toStringAsFixed(2)}s, rate=${newRate.toStringAsFixed(3)}s/KB. Actual request took ${actualSeconds.toStringAsFixed(2)}s for ${payloadKb.toStringAsFixed(2)}KB payload');
  }
}
