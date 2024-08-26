class Dog {
  int? id;
  String? name;
  String? breedGroup;
  String? bredFor;
  String? origin;
  String? referenceImageId;
  bool isFavorite;

  Dog({
    this.id,
    this.name,
    this.breedGroup,
    this.bredFor,
    this.origin,
    this.referenceImageId,
    this.isFavorite = false,
  });

  Dog.fromJson(Map<String, dynamic> json)
      :     id = json['id'],
        name = json['name'],
        breedGroup = json['breed_group'],
        bredFor = json['bred_for'],
        origin = json['origin'],
        referenceImageId = json['reference_image_id'],
        isFavorite = json['is_favorite'] == 1;

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['breed_group'] = this.breedGroup;
  //   data['bred_for'] = this.bredFor;
  //   data['origin'] = this.origin;
  //   data['reference_image_id'] = this.referenceImageId;
  //   data['is_favorite'] = this.isFavorite ? 1 : 0;
  //   return data;
  // }

}