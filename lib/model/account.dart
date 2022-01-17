class Account {
  String id;
  String name;
  String imagePath;
  String selfIntroduction;
  String useId;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account({this.id = '', this.name = '', this.imagePath = '', this.selfIntroduction = '',
    this.useId = '', this.createdTime, this.updatedTime,
  });
}