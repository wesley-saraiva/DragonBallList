enum TaskFilterEnum {
  today,
  tomorrow,
  week,
  month,
}

extension TaskFilterDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return "DE HOJE";
      case TaskFilterEnum.tomorrow:
        return "DE AMANHÃ";
      case TaskFilterEnum.week:
        return "DA SEMANA";
      case TaskFilterEnum.month:
        return "DO MÊS";
    }
  }
}
