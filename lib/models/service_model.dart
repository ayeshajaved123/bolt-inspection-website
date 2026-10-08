class ServiceModel {
  final String title;
  final String description;
  final IconIdentifier icon;
  final String routeName;

  const ServiceModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });
}

/// Simple enum so widgets can map to a Material icon without hardcoding
/// IconData in the model layer.
enum IconIdentifier { inspection, training }
