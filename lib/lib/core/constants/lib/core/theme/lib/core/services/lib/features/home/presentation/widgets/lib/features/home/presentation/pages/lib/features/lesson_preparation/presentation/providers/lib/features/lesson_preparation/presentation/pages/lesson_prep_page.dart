import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/lesson_provider.dart';

class LessonPrepPage extends ConsumerStatefulWidget {
  const LessonPrepPage({super.key});

  @override
  ConsumerState<LessonPrepPage> createState() => _LessonPrepPageState();
}

class _LessonPrepPageState extends ConsumerState<LessonPrepPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedSubject = 'الرياضيات';
  String _selectedGrade = 'الصف الخامس الابتدائي';
  String _selectedSemester = 'الفصل الدراسي الثاني';
  final TextEditingController _topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lessonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تحضير درس جديد'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      decoration: const InputDecoration(labelText: 'المادة الدراسية'),
                      items: ['الرياضيات', 'العلوم', 'اللغة العربية', 'الدراسات الإسلامية']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedSubject = v!),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedGrade,
                      decoration: const InputDecoration(labelText: 'الصف الدراسي'),
                      items: ['الصف الرابع الابتدائي', 'الصف الخامس الابتدائي', 'الصف السادس الابتدائي']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedGrade = v!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _topicController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان الدرس',
                        hintText: 'مثال: جمع الكسور المتشابهة',
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال عنوان الدرس' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                ref.read(lessonProvider.notifier).generateLesson(
                                      subject: _selectedSubject,
                                      grade: _selectedGrade,
                                      semester: _selectedSemester,
                                      topic: _topicController.text,
                                    );
                              }
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('توليد التحضير بالذكاء الاصطناعي'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (state.errorMessage != null) ...[
              Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            if (state.lessonData != null) ...[
              _buildLessonResult(state.lessonData!),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildLessonResult(Map<String, dynamic> data) {
    return Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('نتائج التحضير', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.red),
                onPressed: () {},
              )
            ],
          ),
          const Divider(),
          _buildSectionTitle('الأهداف السلوكية:'),
          ...?((data['objectives'] as List?)?.map((o) => Text('• $o'))),
          const SizedBox(height: 12),
          _buildSectionTitle('التهيئة:'),
          Text(data['introduction'] ?? ''),
          const SizedBox(height: 12),
          _buildSectionTitle('الاستراتيجيات المستخدمة:'),
          Text((data['strategies'] as List?)?.join(', ') ?? ''),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
