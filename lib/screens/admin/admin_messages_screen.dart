import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/firestore_service.dart';
import '../../widgets/admin_shell.dart';

class AdminMessagesScreen extends StatelessWidget {
  const AdminMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return AdminShell(
      activeRoute: '/admin/messages',
      child: StreamBuilder(
        stream: firestoreService.streamContactSubmissions(),
        builder: (context, snapshot) {
          final docs = snapshot.data?.docs ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Messages', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.charcoal)),
              const SizedBox(height: 20),
              Expanded(
                child: docs.isEmpty
                    ? const Center(
                        child: Text('No submissions yet.', style: TextStyle(color: AppColors.textMuted)),
                      )
                    : ListView.separated(
                        itemCount: docs.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final d = docs[index];
                          final data = d.data();
                          final isRead = data['read'] == true;
                          return Container(
                            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data['name'] ?? ''} · ${data['subject'] ?? '(no subject)'}',
                                        style: TextStyle(
                                          fontWeight: isRead ? FontWeight.w500 : FontWeight.w800,
                                          color: AppColors.charcoal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(data['email'] ?? '', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                                      const SizedBox(height: 6),
                                      Text(data['message'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                if (!isRead)
                                  TextButton(
                                    onPressed: () => firestoreService.markAsRead(d.id),
                                    child: const Text('Mark as read'),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
