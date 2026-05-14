import 'package:flutter/material.dart';
import 'models/topic_model.dart';
import 'services/api_service.dart';

import 'services/local_storage_service.dart';

void main() {
  runApp(const DersAjandamApp());
}

class DersAjandamApp extends StatelessWidget {
  const DersAjandamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DersAjandam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mint,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class AppColors {
  static const Color paper = Color(0xFFFFF8E7);
  static const Color paperDark = Color(0xFFF3E7CF);
  static const Color card = Color(0xFFFFFCF2);

  static const Color pastelYellow = Color(0xFFFFE7A8);
  static const Color pastelGreen = Color(0xFFCDEEDC);
  static const Color pastelBlue = Color(0xFFBFDDF7);
  static const Color pastelPink = Color(0xFFFFC9C9);
  static const Color pastelPurple = Color(0xFFDCCEFF);
  static const Color mint = Color(0xFF9ED5C5);

  static const Color ink = Color(0xFF3F3830);
  static const Color brown = Color(0xFF7B6048);
  static const Color line = Color(0xFFE4D4B7);

  static const Color plusGreen = Color(0xFF5E9C76);
  static const Color minusRed = Color(0xFFD96C6C);
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    StudentsScreen(),
    HomeworkScreen(),
    ExamResultsScreen(),
    SettingsScreen(),
  ];

  final List<String> titles = const [
    'Ders Ajandam',
    'Öğrenciler',
    'Ödev Defteri',
    'Net Analizi',
    'Ayarlar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: MathTab(symbol: 'π'),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: MathTab(symbol: '√'),
          ),
        ],
      ),
      body: Stack(
        children: [
          const GraphPaperBackground(),
          screens[selectedIndex],
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        decoration: notebookDecoration(AppColors.card),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          height: 72,
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.pastelYellow,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.auto_stories_outlined),
              selectedIcon: Icon(Icons.auto_stories),
              label: 'Ajanda',
            ),
            NavigationDestination(
              icon: Icon(Icons.face_6_outlined),
              selectedIcon: Icon(Icons.face_6),
              label: 'Öğrenci',
            ),
            NavigationDestination(
              icon: Icon(Icons.checklist_rtl_outlined),
              selectedIcon: Icon(Icons.checklist_rtl),
              label: 'Ödev',
            ),
            NavigationDestination(
              icon: Icon(Icons.functions_outlined),
              selectedIcon: Icon(Icons.functions),
              label: 'Net',
            ),
            NavigationDestination(
              icon: Icon(Icons.tune_outlined),
              selectedIcon: Icon(Icons.tune),
              label: 'Ayar',
            ),
          ],
        ),
      ),
    );
  }
}

class GraphPaperBackground extends StatelessWidget {
  const GraphPaperBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: GraphPaperPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class GraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final smallLinePaint = Paint()
      ..color = AppColors.line.withOpacity(0.28)
      ..strokeWidth = 0.5;

    final bigLinePaint = Paint()
      ..color = AppColors.line.withOpacity(0.45)
      ..strokeWidth = 0.8;

    const double smallStep = 20;
    const double bigStep = 100;

    for (double x = 0; x < size.width; x += smallStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), smallLinePaint);
    }

    for (double y = 0; y < size.height; y += smallStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), smallLinePaint);
    }

    for (double x = 0; x < size.width; x += bigStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), bigLinePaint);
    }

    for (double y = 0; y < size.height; y += bigStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), bigLinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MathTab extends StatelessWidget {
  final String symbol;

  const MathTab({
    super.key,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.pastelYellow,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: AppColors.ink.withOpacity(0.16),
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            symbol,
            style: const TextStyle(
              color: AppColors.ink,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
      children: const [
        HeroNotebookCard(),
        SizedBox(height: 14),
        ProfessorTipCard(),
        SizedBox(height: 18),
        SectionTitle(title: 'Bugünün küçük denklemi'),
        SizedBox(height: 10),
        DashboardGrid(),
        SizedBox(height: 18),
        SectionTitle(title: 'Bugünkü dersler'),
        SizedBox(height: 10),
        LessonCard(
          studentName: 'Ayşe Yılmaz',
          lesson: 'Matematik',
          time: '18:00',
          topic: 'Kareköklü İfadeler',
          isReady: true,
        ),
        LessonCard(
          studentName: 'Mehmet Kaya',
          lesson: 'Fen Bilimleri',
          time: '19:30',
          topic: 'Basınç',
          isReady: false,
        ),
      ],
    );
  }
}

class HeroNotebookCard extends StatelessWidget {
  const HeroNotebookCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: notebookDecoration(AppColors.pastelYellow),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 108,
            decoration: BoxDecoration(
              color: AppColors.brown.withOpacity(0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DersAjandam',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Matematik özel dersleri için öğrenci, ödev, konu ve net takip defteri.',
                  style: TextStyle(
                    color: AppColors.brown,
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'E = emek × düzen²',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 82,
            height: 92,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.14),
                width: 1.2,
              ),
            ),
            child: const Center(
              child: Text(
                '👨‍🏫\nπ + √',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  height: 1.18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfessorTipCard extends StatelessWidget {
  const ProfessorTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: notebookDecoration(AppColors.pastelGreen),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.12),
              ),
            ),
            child: const Center(
              child: Text(
                '🧠',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 14,
                  height: 1.35,
                ),
                children: [
                  TextSpan(
                    text: 'Mini profesör notu: ',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text:
                        'Bir eksik konu kapatılırsa, öğrenci denklemi bir adım daha sadeleşir.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '=',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.brown,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.18,
      children: const [
        StatCard(
          title: 'Öğrenci',
          value: '6',
          symbol: '+',
          color: AppColors.pastelBlue,
        ),
        StatCard(
          title: 'Bugünkü Ders',
          value: '2',
          symbol: 'x',
          color: AppColors.pastelPink,
        ),
        StatCard(
          title: 'Bekleyen Ödev',
          value: '4',
          symbol: '−',
          color: AppColors.pastelYellow,
        ),
        StatCard(
          title: 'Konu İlerleme',
          value: '%68',
          symbol: '√',
          color: AppColors.pastelGreen,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String symbol;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: notebookDecoration(color),
      padding: const EdgeInsets.all(14),
      child: Stack(
        children: [
          Positioned(
            right: 2,
            top: -12,
            child: Text(
              symbol,
              style: TextStyle(
                color: AppColors.ink.withOpacity(0.14),
                fontSize: 58,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: AppColors.brown.withOpacity(0.24),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.brown,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String studentName;
  final String lesson;
  final String time;
  final String topic;
  final bool isReady;

  const LessonCard({
    super.key,
    required this.studentName,
    required this.lesson,
    required this.time,
    required this.topic,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: notebookDecoration(AppColors.card),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: PlusMinusBadge(isPositive: isReady),
        title: Text(
          studentName,
          style: const TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          '$lesson • $topic',
          style: const TextStyle(
            color: AppColors.brown,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.pastelYellow,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.ink.withOpacity(0.12),
            ),
          ),
          child: Text(
            time,
            style: const TextStyle(
              color: AppColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = [
      {
        'name': 'Ayşe Yılmaz',
        'grade': '8. Sınıf',
        'lesson': 'Matematik',
        'score': '72.5',
        'symbol': 'x²',
        'color': AppColors.pastelPink,
      },
      {
        'name': 'Mehmet Kaya',
        'grade': '8. Sınıf',
        'lesson': 'Fen Bilimleri',
        'score': '68.0',
        'symbol': '√',
        'color': AppColors.pastelGreen,
      },
      {
        'name': 'Zeynep Demir',
        'grade': '7. Sınıf',
        'lesson': 'Türkçe',
        'score': '81.0',
        'symbol': 'π',
        'color': AppColors.pastelBlue,
      },
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
      children: [
        Container(
          decoration: notebookDecoration(AppColors.card),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Öğrenci ara, denklem çözelim...',
              hintStyle: TextStyle(
                color: AppColors.brown.withOpacity(0.75),
              ),
              prefixIcon: const Icon(Icons.search, color: AppColors.brown),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...students.map(
          (student) => StudentCard(
            name: student['name'] as String,
            grade: student['grade'] as String,
            lesson: student['lesson'] as String,
            score: student['score'] as String,
            symbol: student['symbol'] as String,
            color: student['color'] as Color,
          ),
        ),
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String grade;
  final String lesson;
  final String score;
  final String symbol;
  final Color color;

  const StudentCard({
    super.key,
    required this.name,
    required this.grade,
    required this.lesson,
    required this.score,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StudentDetailPage(
              name: name,
              grade: grade,
              lesson: lesson,
              score: score,
              symbol: symbol,
              color: color,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: notebookDecoration(color),
        child: ListTile(
          contentPadding: const EdgeInsets.all(14),
          leading: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.12),
              ),
            ),
            child: Center(
              child: Text(
                symbol,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: AppColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: Text(
            '$grade • $lesson',
            style: const TextStyle(
              color: AppColors.brown,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Son Net',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.brown,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  score,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class StudentDetailPage extends StatelessWidget {
  final String name;
  final String grade;
  final String lesson;
  final String score;
  final String symbol;
  final Color color;

  const StudentDetailPage({
    super.key,
    required this.name,
    required this.grade,
    required this.lesson,
    required this.score,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
        elevation: 0,
        title: const Text(
          'Öğrenci Defteri',
          style: TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.ink),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const GraphPaperBackground(),
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Container(
                decoration: notebookDecoration(color),
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 72,
                      height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.ink.withOpacity(0.14),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          symbol,
                          style: const TextStyle(
                            fontSize: 28,
                            color: AppColors.ink,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$grade • $lesson',
                            style: const TextStyle(
                              color: AppColors.brown,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Son deneme neti: $score',
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const SectionTitle(title: 'Öğrenci özeti'),
              const SizedBox(height: 10),

              const DetailInfoCard(
                color: AppColors.pastelYellow,
                symbol: '√',
                title: 'Konu İlerlemesi',
                value: '%68 tamamlandı',
                description: 'Kareköklü ifadeler ve problemler tekrar edilmeli.',
              ),

              const DetailInfoCard(
                color: AppColors.pastelGreen,
                symbol: '+',
                title: 'Ödev Durumu',
                value: '3 tamamlandı, 1 bekliyor',
                description: 'Son verilen problem ödevi kontrol edilmeli.',
              ),

              const DetailInfoCard(
                color: AppColors.pastelPink,
                symbol: '−',
                title: 'Eksik Alan',
                value: 'Matematik Problemleri',
                description: 'Yeni nesil problem sorularında işlem takibi zayıf.',
              ),

              const DetailInfoCard(
                color: AppColors.pastelBlue,
                symbol: '∑',
                title: 'Deneme Analizi',
                value: 'Hedef: 80 net',
                description: 'Mevcut net ile hedef arasında yaklaşık 7.5 net fark var.',
              ),

              const SizedBox(height: 16),

              const SectionTitle(title: 'Hızlı işlemler'),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: ActionBox(
                      title: 'Konu Takip',
                      symbol: 'π',
                      color: AppColors.pastelYellow,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TopicTrackingPage(
                studentName: name,
                grade: grade,
                lesson: lesson,
              ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: ActionBox(
                      title: 'Ödev Ekle',
                      symbol: '+',
                      color: AppColors.pastelGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Row(
                children: [
                  Expanded(
                    child: ActionBox(
                      title: 'Net Gir',
                      symbol: '∑',
                      color: AppColors.pastelBlue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ActionBox(
                      title: 'Not Yaz',
                      symbol: '✎',
                      color: AppColors.pastelPink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailInfoCard extends StatelessWidget {
  final Color color;
  final String symbol;
  final String title;
  final String value;
  final String description;

  const DetailInfoCard({
    super.key,
    required this.color,
    required this.symbol,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: notebookDecoration(color),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MathTab(symbol: symbol),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.brown,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.ink,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ActionBox extends StatelessWidget {
  final String title;
  final String symbol;
  final Color color;
  final VoidCallback? onTap;

  const ActionBox({
    super.key,
    required this.title,
    required this.symbol,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        decoration: notebookDecoration(color),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              symbol,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


























class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
      children: const [
        SectionTitle(title: 'Ödev denklemleri'),
        SizedBox(height: 12),
        HomeworkCard(
          title: '40 soru problem çözümü',
          student: 'Ayşe Yılmaz',
          lesson: 'Matematik',
          status: 'Tamamlandı',
          note: 'Artı hanesine yazıldı.',
        ),
        HomeworkCard(
          title: 'Paragraf testi 2 adet',
          student: 'Zeynep Demir',
          lesson: 'Türkçe',
          status: 'Bekliyor',
          note: 'Henüz sonuç belirsiz.',
        ),
        HomeworkCard(
          title: 'Basınç konusu tekrar',
          student: 'Mehmet Kaya',
          lesson: 'Fen Bilimleri',
          status: 'Eksik',
          note: 'Eksi hanesine düştü.',
        ),
      ],
    );
  }
}

class HomeworkCard extends StatelessWidget {
  final String title;
  final String student;
  final String lesson;
  final String status;
  final String note;

  const HomeworkCard({
    super.key,
    required this.title,
    required this.student,
    required this.lesson,
    required this.status,
    required this.note,
  });

  bool get isDone => status == 'Tamamlandı';
  bool get isMissing => status == 'Eksik';

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isDone
        ? AppColors.pastelGreen
        : isMissing
            ? AppColors.pastelPink
            : AppColors.pastelYellow;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: notebookDecoration(cardColor),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          PlusMinusBadge(
            isPositive: isDone,
            isNeutral: !isDone && !isMissing,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$student • $lesson',
                  style: const TextStyle(
                    color: AppColors.brown,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.1),
              ),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExamResultsScreen extends StatelessWidget {
  const ExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
      children: const [
        SectionTitle(title: 'Net formülleri'),
        SizedBox(height: 12),
        ExamCard(
          student: 'Ayşe Yılmaz',
          examName: 'LGS Deneme 1',
          totalScore: 72.5,
          strongLesson: 'Türkçe',
          weakLesson: 'Matematik',
          formula: 'D − Y/3 = Net',
        ),
        ExamCard(
          student: 'Mehmet Kaya',
          examName: 'LGS Deneme 2',
          totalScore: 68.0,
          strongLesson: 'Fen Bilimleri',
          weakLesson: 'İngilizce',
          formula: 'Hedef − Net = Eksik',
        ),
      ],
    );
  }
}

class ExamCard extends StatelessWidget {
  final String student;
  final String examName;
  final double totalScore;
  final String strongLesson;
  final String weakLesson;
  final String formula;

  const ExamCard({
    super.key,
    required this.student,
    required this.examName,
    required this.totalScore,
    required this.strongLesson,
    required this.weakLesson,
    required this.formula,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: notebookDecoration(AppColors.card),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const MathTab(symbol: '∑'),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  student,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.pastelGreen,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.ink.withOpacity(0.1),
                  ),
                ),
                child: Text(
                  totalScore.toStringAsFixed(1),
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            examName,
            style: const TextStyle(
              color: AppColors.brown,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: totalScore / 100,
              minHeight: 12,
              backgroundColor: AppColors.pastelPink.withOpacity(0.45),
              color: AppColors.plusGreen,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.pastelYellow.withOpacity(0.78),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.1),
              ),
            ),
            child: Text(
              formula,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '+ Güçlü ders: $strongLesson',
            style: const TextStyle(
              color: AppColors.plusGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            '− Geliştirilecek ders: $weakLesson',
            style: const TextStyle(
              color: AppColors.minusRed,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
      children: [
        const SectionTitle(title: 'Ajanda ayarları'),
        const SizedBox(height: 12),
        Container(
          decoration: notebookDecoration(AppColors.pastelGreen),
          child: SwitchListTile(
            value: true,
            onChanged: (value) {},
            activeColor: AppColors.plusGreen,
            title: const Text(
              'Ders hatırlatma bildirimi',
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: const Text(
              'Yaklaşan derslerde mini profesör seni dürtsün.',
              style: TextStyle(
                color: AppColors.brown,
                fontWeight: FontWeight.w700,
              ),
            ),
            secondary: const Text(
              '+',
              style: TextStyle(
                fontSize: 34,
                color: AppColors.plusGreen,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: notebookDecoration(AppColors.pastelYellow),
          child: const ListTile(
            leading: MathTab(symbol: 'π'),
            title: Text(
              'DersAjandam',
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: Text(
              'Matematik özel ders odaklı öğrenci takip uygulaması',
              style: TextStyle(
                color: AppColors.brown,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              'v1.0',
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlusMinusBadge extends StatelessWidget {
  final bool isPositive;
  final bool isNeutral;

  const PlusMinusBadge({
    super.key,
    required this.isPositive,
    this.isNeutral = false,
  });

  @override
  Widget build(BuildContext context) {
    final String symbol = isNeutral
        ? '='
        : isPositive
            ? '+'
            : '−';

    final Color color = isNeutral
        ? AppColors.brown
        : isPositive
            ? AppColors.plusGreen
            : AppColors.minusRed;

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.45), width: 2),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.ink.withOpacity(0.12),
            ),
          ),
          child: const Center(
            child: Text(
              '✎',
              style: TextStyle(
                fontSize: 17,
                color: AppColors.brown,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}


class TopicTrackingPage extends StatefulWidget {
  final String studentName;
  final String grade;
  final String lesson;

  const TopicTrackingPage({
    super.key,
    required this.studentName,
    required this.grade,
    required this.lesson,
  });

  @override
  State<TopicTrackingPage> createState() => _TopicTrackingPageState();
}

class _TopicTrackingPageState extends State<TopicTrackingPage> {
  final ApiService apiService = ApiService();
  final LocalStorageService localStorageService = LocalStorageService();

  List<TopicModel> topics = [];
  bool isLoading = true;
  String? errorMessage;

  final List<Color> topicColors = const [
    AppColors.pastelGreen,
    AppColors.pastelBlue,
    AppColors.pastelYellow,
    AppColors.pastelPurple,
    AppColors.pastelPink,
  ];

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  Future<void> loadTopics() async {
    try {
      final fetchedTopics = await apiService.fetchTopics();

      final filteredTopics = fetchedTopics.where((topic) {
        return topic.grade == widget.grade && topic.lesson == widget.lesson;
      }).toList();
      for (final topic in filteredTopics) {
        final savedStatus = await localStorageService.getTopicStatus(
          studentName: widget.studentName,
          topicTitle: topic.title,
        );

        if (savedStatus != null) {

          topic.done = savedStatus;
        }
      }
      
      setState(() {
        topics = filteredTopics;
        isLoading = false;
        errorMessage = null;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Konu listesi servisten alınamadı.';
      });
    }
  }

  double get progress {
    if (topics.isEmpty) return 0;

    final completed = topics.where((topic) => topic.done).length;
    return completed / topics.length;
  }

  int get completedCount {
    return topics.where((topic) => topic.done).length;
  }

  Color getTopicColor(int index) {
    return topicColors[index % topicColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: AppBar(
        backgroundColor: AppColors.paper,
        surfaceTintColor: AppColors.paper,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.ink),
        centerTitle: true,
        title: const Text(
          'Konu Takip Defteri',
          style: TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          const GraphPaperBackground(),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.plusGreen,
              ),
            )
          else if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: notebookDecoration(AppColors.pastelPink),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const PlusMinusBadge(isPositive: false),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (topics.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: notebookDecoration(AppColors.pastelYellow),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const MathTab(symbol: '∅'),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${widget.grade} ${widget.lesson} için konu verisi bulunamadı.',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                Container(
                  decoration: notebookDecoration(AppColors.pastelYellow),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const MathTab(symbol: 'π'),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.lesson} Konu Takibi',
                              style: const TextStyle(
                                color: AppColors.ink,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${widget.studentName} • ${widget.grade}',
                              style: const TextStyle(
                                color: AppColors.brown,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Veriler GitHub JSON servisinden çekiliyor',
                              style: TextStyle(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${(progress * 100).round()}%',
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  decoration: notebookDecoration(AppColors.card),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'İlerleme denklemi',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                          backgroundColor:
                              AppColors.pastelPink.withOpacity(0.45),
                          color: AppColors.plusGreen,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$completedCount / ${topics.length} konu tamamlandı',
                        style: const TextStyle(
                          color: AppColors.brown,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SectionTitle(
                  title: '${widget.grade} ${widget.lesson} konuları',
                ),
                const SizedBox(height: 10),
                ...topics.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final topic = entry.value;

                    return TopicCard(
                      title: topic.title,
                      formula: topic.formula,
                      isDone: topic.done,
                      color: getTopicColor(index),
                      onTap: () async {
                        setState(() {
                          topics[index].done = !topics[index].done;
                        });
                        
                        await localStorageService.saveTopicStatus(
                          studentName: widget.studentName,
                          topicTitle: topics[index].title,
                          isDone: topics[index].done,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final String formula;
  final bool isDone;
  final Color color;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.formula,
    required this.isDone,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: notebookDecoration(color),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: PlusMinusBadge(isPositive: isDone),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.ink,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          formula,
          style: const TextStyle(
            color: AppColors.brown,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.ink.withOpacity(0.12),
              ),
            ),
            child: Text(
              isDone ? 'Tamam' : 'Eksik',
              style: TextStyle(
                color: isDone ? AppColors.plusGreen : AppColors.minusRed,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


BoxDecoration notebookDecoration(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: AppColors.ink.withOpacity(0.13),
      width: 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.brown.withOpacity(0.12),
        blurRadius: 8,
        offset: const Offset(3, 4),
      ),
    ],
  );
}