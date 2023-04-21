abstract class ListItem<T, X> {
  ListItem(this.key, this.value);
  final T key;
  final X value;

  @override
  bool operator ==(dynamic other) => other != null && this.key == other.key;

  @override
  int get hashCode => super.hashCode;
}

class BaseItem implements ListItem<int, String>{
  @override
  final int key;
  @override
  final String value;

  BaseItem(this.key, this.value);

  @override
  bool operator ==(dynamic other) => other != null && this.key == other.key;

  @override
  int get hashCode => super.hashCode;
}

class StudentItem implements ListItem<String, String>{
  @override
  final String key;
  @override
  final String value;

  final int age;

  StudentItem(this.key, this.value, this.age);
  
  @override
  bool operator ==(dynamic other) => other != null && this.key == other.key;

  @override
  int get hashCode => super.hashCode;
}