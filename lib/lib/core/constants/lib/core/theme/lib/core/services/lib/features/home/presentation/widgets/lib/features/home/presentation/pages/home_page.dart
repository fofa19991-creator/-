import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/service_card.dart';
import '../../../lesson_preparation/presentation/pages/lesson_prep_page.dart';
import '../../../ai_chat/presentation/pages/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {'title': 'تحضير درس', 'icon': Icons.menu_book_rounded, 'color': Colors.blue, 'page': const LessonPrepPage()},
      {'title': 'المساعد الذكي', 'icon': Icons.smart_toy_rounded, 'color': Colors.purple, 'page': const ChatPage()},
      {'title': 'إنشاء اختبار', 'icon': Icons.quiz_rounded, 'color': Colors.amber, 'page': null},
      {'title': 'أوراق عمل', 'icon': Icons.assignment_rounded, 'color': Colors.teal, 'page': null},
      {'title': 'واجبات منزلية', 'icon': Icons.home_work_rounded, 'color': Colors.deepOrange, 'page': null},
      {'title': 'خطة أسبوعية', 'icon': Icons.calendar_view_week_rounded, 'color': Colors.indigo, 'page': null},
      {'title': 'خطة علاجية', 'icon': Icons.health_and_safety_rounded, 'color': Colors.redAccent, 'page': null},
      {'title': 'تحليل النتائج', 'icon': Icons.analytics_rounded, 'color': Colors.green, 'page': null},
      {'title': 'بنك الأسئلة', 'icon': Icons.folder_copy_rounded, 'color': Colors.blueGrey, 'page': null},
      {'title': 'رسائل أولياء الأمور', 'icon': Icons.mark_chat_read_rounded, 'color': Colors.pink, 'page': null},
      {'title': 'إنشاء شهادات', 'icon': Icons.workspace_premium_rounded, 'color': AppColors.lightGold, 'page': null},
      {'title': 'عرض PowerPoint', 'icon': Icons.slideshow_rounded, 'color': Colors.orange, 'page': null},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعد الذكي للمعلم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.royalBlue, AppColors.royalBlueDark],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أهلاً بك، أستاذنا الفاضل 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ما الذي تريد إنجازه لطلابك اليوم؟',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = services[index];
                  return ServiceCard(
                    title: service['title'],
                    icon: service['icon'],
                    accentColor: service['color'],
                    onTap: () {
                      if (service['page'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => service['page']),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('خدمة ${service['title']} قادمة قريباً!')),
                        );
                      }
                    },
                  );
                },
                childCount: services.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
