class PlantInfo {
  final String commonName;
  final String scientificName;
  final String description;
  final String care;
  final String lightNeeds;
  final String waterNeeds;

  PlantInfo({
    required this.commonName,
    required this.scientificName,
    required this.description,
    required this.care,
    required this.lightNeeds,
    required this.waterNeeds,
  });
}

// Mapa de información de plantas según la etiqueta detectada por YOLO
// ACTUALIZA ESTO con las clases reales de tu modelo
class PlantDatabase {
  static final Map<String, PlantInfo> plantInfo = {
    'planta': PlantInfo(
      commonName: 'Planta Genérica',
      scientificName: 'Plantae sp.',
      description: 'Una planta detectada por el sistema. Actualiza esta información con datos específicos de tu modelo.',
      care: 'Varía según la especie. Asegúrate de identificar la planta específica.',
      lightNeeds: 'Luz indirecta a directa, según especie',
      waterNeeds: 'Riego moderado',
    ),
    
    // EJEMPLOS - Reemplaza con tus clases reales
    'rosa': PlantInfo(
      commonName: 'Rosa',
      scientificName: 'Rosa spp.',
      description: 'Las rosas son plantas ornamentales muy populares, conocidas por sus hermosas flores y fragancia.',
      care: 'Requiere poda regular, fertilización y protección contra plagas.',
      lightNeeds: 'Pleno sol (6-8 horas diarias)',
      waterNeeds: 'Riego profundo 2-3 veces por semana',
    ),
    
    'girasol': PlantInfo(
      commonName: 'Girasol',
      scientificName: 'Helianthus annuus',
      description: 'Planta anual de gran tamaño con flores grandes y brillantes que siguen el movimiento del sol.',
      care: 'Planta de bajo mantenimiento. Tutorizar si es muy alta.',
      lightNeeds: 'Pleno sol todo el día',
      waterNeeds: 'Riego regular, especialmente en época de floración',
    ),
    
    'cactus': PlantInfo(
      commonName: 'Cactus',
      scientificName: 'Cactaceae family',
      description: 'Plantas suculentas adaptadas a ambientes áridos con hojas modificadas en espinas.',
      care: 'Muy bajo mantenimiento. Evitar exceso de humedad.',
      lightNeeds: 'Pleno sol o luz brillante',
      waterNeeds: 'Riego escaso, dejar secar entre riegos',
    ),
    
    'suculenta': PlantInfo(
      commonName: 'Suculenta',
      scientificName: 'Varios géneros',
      description: 'Plantas con tejidos carnosos que almacenan agua, ideales para principiantes.',
      care: 'Bajo mantenimiento. Sustrato con buen drenaje.',
      lightNeeds: 'Luz brillante indirecta',
      waterNeeds: 'Riego moderado, dejar secar sustrato entre riegos',
    ),
  };

  static PlantInfo getInfo(String label) {
    // Si la etiqueta existe en el mapa, devuélvela
    if (plantInfo.containsKey(label.toLowerCase())) {
      return plantInfo[label.toLowerCase()]!;
    }
    
    // Si no existe, devolver información genérica
    return PlantInfo(
      commonName: label,
      scientificName: 'Desconocido',
      description: 'Planta detectada. Información no disponible en la base de datos.',
      care: 'Consulta con un experto para cuidados específicos.',
      lightNeeds: 'Varía según especie',
      waterNeeds: 'Varía según especie',
    );
  }
}