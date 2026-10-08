import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../widgets/admin_shell.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = AuthService().currentUser?.email ?? 'admin';
    final firestoreService = FirestoreService();

    return AdminShell(
      activeRoute: '/admin/dashboard',
      child: StreamBuilder(
        stream: firestoreService.streamContactSubmissions(),
        builder: (context, snapshot) {
          final docs = snapshot.data?.docs ?? [];
          final unread = docs.where((d) => d.data()['read'] == false).length;
          final recent = docs.take(5).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome back, Admin',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.charcoal)),
                        Text(email, style: const TextStyle(color: AppColors.textMuted)),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await AuthService().signOut();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(context, '/admin/login', (r) => false);
                        }
                      },
                      icon: const Icon(Icons.logout, size: 16),
                      label: const Text('Logout'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _SummaryCard(title: 'Unread Messages', value: '$unread', sub: 'New messages', icon: Icons.mark_email_unread_outlined),
                    _SummaryCard(title: 'Total Submissions', value: '${docs.length}', sub: 'All time', icon: Icons.description_outlined),
                    _SummaryCard(
                      title: 'Last Submission',
                      value: recent.isEmpty ? '—' : 'Recent',
                      sub: recent.isEmpty ? 'No submissions yet' : 'See table below',
                      icon: Icons.calendar_today_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recent Contact Form Submissions',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.charcoal)),
                      const SizedBox(height: 16),
                      if (recent.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Text('No submissions yet — this table fills in once the contact form is live.',
                              style: TextStyle(color: AppColors.textMuted)),
                        )
                      else
                        Table(
                          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3), 2: FlexColumnWidth(2), 3: FlexColumnWidth(1)},
                          children: [
                            const TableRow(children: [
                              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Name', style: TextStyle(fontWeight: FontWeight.w700))),
                              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Subject', style: TextStyle(fontWeight: FontWeight.w700))),
                              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Email', style: TextStyle(fontWeight: FontWeight.w700))),
                              Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Status', style: TextStyle(fontWeight: FontWeight.w700))),
                            ]),
                            for (final d in recent)
                              TableRow(children: [
                                Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('${d.data()['name'] ?? ''}')),
                                Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('${d.data()['subject'] ?? ''}')),
                                Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text('${d.data()['email'] ?? ''}')),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: _StatusPill(read: d.data()['read'] == true),
                                ),
                              ]),
                          ],
                        ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, '/admin/messages'),
                            child: const Text('View All Submissions'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final IconData icon;

  const _SummaryCard({required this.title, required this.value, required this.sub, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.charcoal)),
              Icon(icon, color: AppColors.amber),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.navy)),
          Text(sub, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final bool read;
  const _StatusPill({required this.read});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: read ? AppColors.successBg : AppColors.dangerBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        read ? 'Read' : 'Unread',
        style: TextStyle(color: read ? AppColors.success : AppColors.red, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
