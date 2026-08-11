import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. شريط الترحيب والبحث
              _buildHeaderSection(),
              const SizedBox(height: 20),

              // 2. شبكة البطاقات (أنشئ محتواك التعليمي)
              _buildSectionTitle('أنشئ محتواك التعليمي ✨'),
              const SizedBox(height: 12),
              _buildGridMenu(),
              const SizedBox(height: 20),

              // 3. قسم المساعد الصوتي
              _buildVoiceAssistantCard(),
              const SizedBox(height: 20),

              // 4. الأدوات الأكثر استخداماً
              _buildSectionTitle('الأدوات الأكثر استخداماً ✨'),
              const SizedBox(height: 12),
              _buildQuickToolsRow(),
            ],
          ),
        ),
      ),
    );
  }

  // رأس الصفحة (الترحيب)
  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFFE0D8FF),
                child: Icon(Icons.person, color: Color(0xFF6C5CE7), size: 35),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً أستاذة وفاء 👋',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'المساعد الذكي جاهز لمساعدتك في إنشاء محتوى تعليمي ممتاز',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحثي عن درس، موضوع، أو اكتبي طلبك...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF6C5CE7)),
              filled: true,
              fillColor: const Color(0xFFF3F0FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // عنوان الأقسام
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  // شبكة الخدمات الرئيسية
  Widget _buildGridMenu() {
    final List<Map<String, dynamic>> items = [
      {'title': 'قصة أو تهيئة', 'icon': Icons.menu_book, 'color': Colors.pinkAccent},
      {'title': 'لعبة تعليمية', 'icon': Icons.sports_esports, 'color': Colors.orangeAccent},
      {'title': 'اختبار إلكتروني', 'icon': Icons.assignment_turned_in, 'color': Colors.blueAccent},
      {'title': 'ورقة عمل', 'icon': Icons.description, 'color': Colors.green},
      {'title': 'إنشاء فيديو للدرس', 'icon': Icons.play_circle_fill, 'color': Colors.purpleAccent},
      {'title': 'إنشاء PowerPoint', 'icon': Icons.slideshow, 'color': Colors.deepOrange},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], size: 36, color: item['color']),
              const SizedBox(height: 8),
              Text(
                item['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }

  // بطاقة التحدث الصوتي
  Widget _buildVoiceAssistantCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تحدثي مع المساعد الذكي',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'قولي ما تريدين، وسنساعدك في إنجاز كل ما تحتاجينه',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.mic, color: Colors.white, size: 30),
          )
        ],
      ),
    );
  }

  // الشريط السريع
  Widget _buildQuickToolsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('عرض الكل', Icons.grid_view, Colors.purple),
          _buildChip('قصة', Icons.book, Colors.pink),
          _buildChip('نشاط', Icons.sports_launch, Colors.teal),
          _buildChip('لعبة', Icons.gamepad, Colors.orange),
          _buildChip('اختبار', Icons.quiz, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildChip(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Chip(
        avatar: Icon(icon, color: color, size: 18),
        label: Text(label),
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}
