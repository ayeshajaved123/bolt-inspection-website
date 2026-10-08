import 'package:cloud_firestore/cloud_firestore.dart';

/// Handles all Firestore reads/writes for the site.
///
/// Collections used:
/// - contact_submissions: every "Get In Touch" form submission
/// - site_stats: the three numbers shown in the stats bar (editable from
///   the admin dashboard instead of being hardcoded, so non-technical staff
///   can update "Completed Projects" etc. without a code change)
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    return _db.collection('contact_submissions').add({
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'submittedAt': FieldValue.serverTimestamp(),
      'read': false,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamContactSubmissions() {
    return _db
        .collection('contact_submissions')
        .orderBy('submittedAt', descending: true)
        .snapshots();
  }

  Future<void> markAsRead(String docId) {
    return _db.collection('contact_submissions').doc(docId).update({'read': true});
  }

  // --- Site content (single document holding everything editable) ---
  // Collection: site_content, doc: home
  // Lets the admin dashboard edit copy without a code change + redeploy.

  DocumentReference<Map<String, dynamic>> get _homeContentDoc =>
      _db.collection('site_content').doc('home');

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamHomeContent() {
    return _homeContentDoc.snapshots();
  }

  Future<void> updateHomeContent(Map<String, dynamic> data) {
    return _homeContentDoc.set(data, SetOptions(merge: true));
  }

  /// Default values used until the admin edits them the first time,
  /// or if the site_content/home document hasn't been created yet.
  static const Map<String, dynamic> defaultHomeContent = {
    'heroTitle': 'Delivering The Trust',
    'heroSubtitle': 'ISO 17020 compliant inspection services you can rely on, across Saudi Arabia.',
    'statProjects': '2,521+',
    'statCountries': '12+',
    'statExperience': '15+',
    'inspectionTitle': 'Inspection Services',
    'inspectionDescription': 'We provide third-party inspection services for heavy equipment, '
        'lifting tools, cranes, and related assets in compliance with international standards.',
    'trainingTitle': 'Training Services',
    'trainingDescription': 'We deliver professional training programs designed to enhance skills, '
        'ensure safety, and support compliance with industry regulations.',
  };
}
