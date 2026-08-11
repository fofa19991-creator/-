import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey;
  late final GenerativeModel _model;
  late final GenerativeModel _jsonModel;

  GeminiService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
    );

    _jsonModel = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );
  }

  /// توليد تحضير درس متكامل
  Future<Map<String, dynamic>> generateLessonPlan({
    required String country,
    required String curriculum,
    required String subject,
    required String grade,
    required String semester,
    required String topic,
  }) async {
    final prompt = '''
    بصفتك خبير تربوي في المنهج الدراسي لدولة $country ($curriculum)، قم بإنشاء تحضير درس مكتمل العناصر للمادة التالية:
    - المادة: $subject
    - الصف: $grade ($semester)
    - عنوان الدرس: $topic

    قم بإرجاع النتيجة بصيغة JSON فقط تحتوي على المفاتيح التالية باللغة العربية:
    {
      "objectives": ["هدف 1", "هدف 2"],
      "introduction": "التهيئة والتمهيد للدرس",
      "strategies": ["استراتيجية 1", "استراتيجية 2"],
      "tools": ["وسيلة تعليمية 1", "وسيلة 2"],
      "steps": ["خطوة الشرح 1", "خطوة 2"],
      "evaluation": ["سؤال تقويم 1", "سؤال 2"],
      "homework": "الواجب المنزلي"
    }
    ''';

    final response = await _jsonModel.generateContent([Content.text(prompt)]);
    final textResponse = response.text ?? '{}';
    return jsonDecode(textResponse) as Map<String, dynamic>;
  }

  /// إنشاء اختبار متكامل
  Future<Map<String, dynamic>> generateQuiz({
    required String subject,
    required String grade,
    required String topic,
  }) async {
    final prompt = '''
    قم بإنشاء اختبار مادة $subject للصف $grade في موضوع $topic.
    أرجع الناتج بتنسيق JSON يحتوي على:
    {
      "mcq": [
        {"question": "السؤال", "options": ["أ", "ب", "ج", "د"], "answer": "أ"}
      ],
      "true_false": [
        {"question": "السؤال", "answer": true}
      ]
    }
    ''';

    final response = await _jsonModel.generateContent([Content.text(prompt)]);
    return jsonDecode(response.text ?? '{}') as Map<String, dynamic>;
  }
}
