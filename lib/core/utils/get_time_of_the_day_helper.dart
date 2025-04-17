 String comprimentoDaHora() {
    final agora = DateTime.now();
    final hora = agora.hour;

    if (hora >= 6 && hora < 12) {
      return 'Bom dia,';
    } else if (hora >= 12 && hora < 18) {
      return 'Boa tarde,';
    } else {
      return 'Boa noite,';
    }
  }