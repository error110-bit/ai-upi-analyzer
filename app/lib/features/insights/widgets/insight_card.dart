import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final String insight;

  const InsightCard({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.auto_awesome,
              color: Colors.deepPurple,
              size: 32,
            ),

            const SizedBox(
              width: 16,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Insight',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    insight,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}