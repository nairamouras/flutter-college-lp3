class Nmsastros {
  late final String id;
  late final String name;
  late final String date;
  late final String time;
  late final String local;
  //método construtor é utilizado para inicializar o estado do objeto bem como disparar algum
  //processo necessário quando da instanciação desta classe
  Nmsastros(
    this.date,
    this.name,
    this.time,
    this.local,
  );

  //método para converter objetos em formato de MAP em objeto Astro
  Nmsastros.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        date = map['date'],
        time = map['time'],
        local = map['local'];

  //método para conversão para MAP
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'local': local,
    };
  }
}
