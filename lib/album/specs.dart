class Specs {
  final String result;

  Specs({this.result});

  factory Specs.fromJson(Map<String, dynamic> json) {
    return Specs(
      result: json['result']
    );
  }
}