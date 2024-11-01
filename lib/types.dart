// Entity interface
abstract class Entity {
  String get TABLE;
  Map<String, Object?> toMap();
}
