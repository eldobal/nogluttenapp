class Ciudad {
  int id;
  String name;

  Ciudad(this.id, this.name);

  static List<Ciudad> getCompanies() {
    return <Ciudad>[

      Ciudad(1, 'Puerto Montt'),
      Ciudad(2, 'Puerto Varas'),
      Ciudad(3, 'Osorno'),
      Ciudad(4, 'Valdivia'),
      Ciudad(5, 'temuco'),
    ];
  }
}