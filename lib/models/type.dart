class Type {
  int typeID, categoryID;
  String typeName;

  Type({this.typeID, this.typeName, this.categoryID});

  Type.fromJson(Map<String, dynamic> json)
      : this(typeID: json['typeID'], typeName: json['typeName'], categoryID: json['categoryID']);

  Map<String, dynamic> toJson() => {'typeID': typeID, 'typeName': typeName, 'categoryID': categoryID};
}