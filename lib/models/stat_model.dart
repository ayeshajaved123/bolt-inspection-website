class StatModel {
  final String value;
  final String label;
  final String iconAsset; // optional, currently rendered with Icons instead

  const StatModel({required this.value, required this.label, this.iconAsset = ''});
}
