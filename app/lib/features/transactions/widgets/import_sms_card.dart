import 'package:flutter/material.dart';

class ImportSmsCard extends StatelessWidget {
  final VoidCallback onImport;

  const ImportSmsCard({
    super.key,
    required this.onImport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.sms,
                  color: Colors.indigo,
                ),
                SizedBox(width: 8),
                Text(
                  'Import SMS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

            const Text(
              'Import your recent UPI transactions securely from SMS.',
            ),

            const SizedBox(
              height: 16,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onImport,
                icon: const Icon(
                  Icons.download,
                ),
                label: const Text(
                  'Import SMS',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}