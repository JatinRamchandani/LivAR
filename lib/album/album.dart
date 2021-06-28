class Album {
  final String endpoint;

  Album({
    this.endpoint,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      endpoint: json['endpoint'],
    );
  }
}
