enum EventStatus {
  extended(key: 'extended'),
  completing(key: 'completing'),
  completed(key: 'completed'),
  expired(key: 'expired'),
  canceled(key: 'canceled'),
  comingSoon(key: 'coming_soon');

  final String key;
  const EventStatus({required this.key});

  String name() {
    return toString().split('.')[1];
  }
}
