import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/gemini_service.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService(apiKey: 'YOUR_GEMINI_API_KEY');
});

class LessonState {
  final bool isLoading;
  final Map<String, dynamic>? lessonData;
  final String? errorMessage;

  LessonState({this.isLoading = false, this.lessonData, this.errorMessage});

  LessonState copyWith({
    bool? isLoading,
    Map<String, dynamic>? lessonData,
    String? errorMessage,
  }) {
    return LessonState(
      isLoading: isLoading ?? this.isLoading,
      lessonData: lessonData ?? this.lessonData,
      errorMessage: errorMessage,
    );
  }
}

class LessonNotifier extends StateNotifier<LessonState> {
  final GeminiService _geminiService;

  LessonNotifier(this._geminiService) : super(LessonState());

  Future<void> generateLesson({
    required String subject,
    required String grade,
    required String semester,
    required String topic,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _geminiService.generateLessonPlan(
        country: 'المملكة العربية السعودية',
        curriculum: 'وزارة التعليم',
        subject: subject,
        grade: grade,
        semester: semester,
        topic: topic,
      );
      state = state.copyWith(isLoading: false, lessonData: result);
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        errorMessage: 'حدث خطأ أثناء توليد التحضير: $e',
      );
    }
  }
}

final lessonProvider = StateNotifierProvider<LessonNotifier, LessonState>((ref) {
  final gemini = ref.watch(geminiServiceProvider);
  return LessonNotifier(gemini);
});
