import 'package:flutter/material.dart';

class OnboardingPageData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> gradientColors;
  final List<OnboardingFeature> features;
  final String imagePath;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradientColors,
    required this.features,
    required this.imagePath,
  });
}

class OnboardingFeature {
  final IconData icon;
  final String text;
  final Color color;

  const OnboardingFeature({
    required this.icon,
    required this.text,
    required this.color,
  });
}

class OnboardingData {
  static const List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: 'Find Past Papers',
      subtitle: 'By School & Department',
      description: 'Search and access past papers from your specific school and department. Never miss an exam question pattern again.',
      icon: Icons.school_outlined,
      gradientColors: [Color(0xFFC5F432), Color(0xFF8BC34A)],
      imagePath: 'assets/images/search_papers.png',
      features: [
        OnboardingFeature(
          icon: Icons.search,
          text: 'Search by School',
          color: Color(0xFFC5F432),
        ),
        OnboardingFeature(
          icon: Icons.filter_list,
          text: 'Filter by Department',
          color: Color(0xFF8BC34A),
        ),
        OnboardingFeature(
          icon: Icons.history_edu,
          text: 'Access Previous Years',
          color: Color(0xFF689F38),
        ),
      ],
    ),
    OnboardingPageData(
      title: 'Smart Topic Search',
      subtitle: 'Find Questions Instantly',
      description: 'Type any topic or unit you\'re studying and get relevant exam questions with AI-powered sample answers.',
      icon: Icons.psychology_outlined,
      gradientColors: [Color(0xFFC09FF8), Color(0xFF9C27B0)],
      imagePath: 'assets/images/topic_search.png',
      features: [
        OnboardingFeature(
          icon: Icons.search_sharp,
          text: 'Topic-based Search',
          color: Color(0xFFC09FF8),
        ),
        OnboardingFeature(
          icon: Icons.smart_toy,
          text: 'AI Sample Answers',
          color: Color(0xFF9C27B0),
        ),
        OnboardingFeature(
          icon: Icons.quiz,
          text: 'Instant Questions',
          color: Color(0xFF673AB7),
        ),
      ],
    ),
    OnboardingPageData(
      title: 'Notes to Questions',
      subtitle: 'Upload & Generate',
      description: 'Upload images of your study notes and get automatically generated questions to test your understanding.',
      icon: Icons.photo_camera_outlined,
      gradientColors: [Color(0xFFFEC4DD), Color(0xFFE91E63)],
      imagePath: 'assets/images/notes_upload.png',
      features: [
        OnboardingFeature(
          icon: Icons.upload_file,
          text: 'Upload Notes Image',
          color: Color(0xFFFEC4DD),
        ),
        OnboardingFeature(
          icon: Icons.auto_awesome,
          text: 'Auto-Generate Questions',
          color: Color(0xFFE91E63),
        ),
        OnboardingFeature(
          icon: Icons.quiz_outlined,
          text: 'Practice Instantly',
          color: Color(0xFFC2185B),
        ),
      ],
    ),
    OnboardingPageData(
      title: 'Share & Collaborate',
      subtitle: 'Study Together',
      description: 'Share questions with friends and study groups. Collaborate and help each other succeed in your academic journey.',
      icon: Icons.share_outlined,
      gradientColors: [Color(0xFF00BCD4), Color(0xFF2196F3)],
      imagePath: 'assets/images/share_collaborate.png',
      features: [
        OnboardingFeature(
          icon: Icons.share,
          text: 'Share Questions',
          color: Color(0xFF00BCD4),
        ),
        OnboardingFeature(
          icon: Icons.group,
          text: 'Study Groups',
          color: Color(0xFF2196F3),
        ),
        OnboardingFeature(
          icon: Icons.group,
          text: 'Collaborate & Learn',
          color: Color(0xFF1976D2),
        ),
      ],
    ),
  ];
}