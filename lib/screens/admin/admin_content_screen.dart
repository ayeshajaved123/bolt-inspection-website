import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../services/firestore_service.dart';
import '../../widgets/admin_shell.dart';

class AdminContentScreen extends StatefulWidget {
  const AdminContentScreen({super.key});

  @override
  State<AdminContentScreen> createState() => _AdminContentScreenState();
}

class _AdminContentScreenState extends State<AdminContentScreen> {
  final _firestoreService = FirestoreService();
  final _controllers = <String, TextEditingController>{};
  bool _loadedOnce = false;
  bool _saving = false;

  void _ensureControllers(Map<String, dynamic> data) {
    if (_loadedOnce) return;
    for (final entry in FirestoreService.defaultHomeContent.entries) {
      _controllers[entry.key] = TextEditingController(text: '${data[entry.key] ?? entry.value}');
    }
    _loadedOnce = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    final data = {for (final e in _controllers.entries) e.key: e.value.text};
    await _firestoreService.updateHomeContent(data);
    setState(() => _saving = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Content updated — live on the site now.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      activeRoute: '/admin/content',
      child: StreamBuilder(
        stream: _firestoreService.streamHomeContent(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data() ?? FirestoreService.defaultHomeContent;
          _ensureControllers(data);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Content', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.charcoal)),
                const SizedBox(height: 8),
                const Text('Edit the homepage copy — changes go live immediately, no redeploy needed.',
                    style: TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 24),
                _sectionCard('Hero Section', ['heroTitle', 'heroSubtitle']),
                const SizedBox(height: 20),
                _sectionCard('Stats Bar', ['statProjects', 'statCountries', 'statExperience']),
                const SizedBox(height: 20),
                _sectionCard('Inspection Service Card', ['inspectionTitle', 'inspectionDescription']),
                const SizedBox(height: 20),
                _sectionCard('Training Service Card', ['trainingTitle', 'trainingDescription']),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Saving...' : 'Save Changes'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionCard(String title, List<String> fields) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.navy)),
          const SizedBox(height: 14),
          for (final f in fields) ...[
            TextField(
              controller: _controllers[f],
              decoration: InputDecoration(labelText: _labelFor(f)),
              maxLines: f.toLowerCase().contains('description') || f.toLowerCase().contains('subtitle') ? 3 : 1,
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  String _labelFor(String key) {
    switch (key) {
      case 'heroTitle':
        return 'Headline';
      case 'heroSubtitle':
        return 'Subheadline';
      case 'statProjects':
        return 'Completed Projects';
      case 'statCountries':
        return 'Countries Served';
      case 'statExperience':
        return 'Years of Experience';
      case 'inspectionTitle':
        return 'Title';
      case 'inspectionDescription':
        return 'Description';
      case 'trainingTitle':
        return 'Title';
      case 'trainingDescription':
        return 'Description';
      default:
        return key;
    }
  }
}
