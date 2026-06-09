class WeatherCodeMapper {
  static String getDescription(int code) {
    switch (code) {
      case 0:
        return "Bezchmurnie";

      case 1:
      case 2:
        return "Lekko pochmurno";

      case 3:
        return "Pochmurno";

      case 45:
      case 48:
        return "Mgła";

      case 51:
      case 53:
      case 55:
        return "Mżawka";

      case 61:
      case 63:
      case 65:
        return "Deszcz";

      case 71:
      case 73:
      case 75:
        return "Śnieg";

      case 95:
        return "Burza";

      default:
        return "Nieznana pogoda";
    }
  }

  static String getIcon(int code) {
    switch (code) {
      case 0:
        return "☀️";

      case 1:
      case 2:
        return "🌤";

      case 3:
        return "☁️";

      case 45:
        return "🌫";

      case 51:
      case 53:
      case 55:
        return "🌦";

      case 61:
      case 63:
      case 65:
        return "🌧";

      case 71:
      case 73:
      case 75:
        return "❄️";

      case 95:
        return "⛈";

      default:
        return "🌍";
    }
  }
}
