import 'package:flutter/material.dart';


class SlideData {
  final Color backgroundColor;
  final Color questionColor;
  final String question;
  final String header;
  final String subText;

  SlideData({
    required this.backgroundColor,
    required this.questionColor,
    required this.question,
    required this.header,
    required this.subText,
  });
}

final List<SlideData> animationdatalist = [
    SlideData(
      backgroundColor: const Color(0xFFE35446),
      questionColor: const Color(0xFF5E1D1A),
      question: "How do I minimize returns and losses?",
      header: "With us,",
      subText: "you get fewer returns and more profit.",
    ),
    SlideData(
      backgroundColor: const Color(0xFFE27928),
      questionColor: const Color(0xFF5E3114),
      question: "What if most of my sales happen offline?",
      header: "No worries",
      subText: "offline exposure is part of the plan.",
    ),
    SlideData(
      backgroundColor: const Color(0xFF9456A5),
      questionColor: const Color(0xFF4D2152),
      question: "Can I reach more customers beyond my area?",
      header: "Yes!",
      subText: "We deliver to 20,000+ pin codes across India.",
    ),
    SlideData(
      backgroundColor: const Color(0xFF39B54A),
      questionColor: const Color(0xFF1A5222),
      question: "How much of my earnings do I get to keep?",
      header: "100%.",
      subText: "We charge zero commission on your sales.",
    ),
    SlideData(
      backgroundColor: const Color(0xFF2D7EB8),
      questionColor: const Color(0xFF163652),
      question: "Will I get paid on time, and is it safe?",
      header: "Always.",
      subText: "Payments are secure and on-time, every time.",
    ),
  ];