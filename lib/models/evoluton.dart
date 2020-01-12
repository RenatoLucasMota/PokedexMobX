class Evolucao {
  Null babyTriggerItem;
  Chain chain;
  int id;

  Evolucao({this.babyTriggerItem, this.chain, this.id});

  Evolucao.fromJson(Map<String, dynamic> json) {
    babyTriggerItem = json['baby_trigger_item'];
    chain = json['chain'] != null ? new Chain.fromJson(json['chain']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baby_trigger_item'] = this.babyTriggerItem;
    if (this.chain != null) {
      data['chain'] = this.chain.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Chain {
  List<EvolutionDetails> evolutionDetails;
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Trigger species;

  Chain({this.evolutionDetails, this.evolvesTo, this.isBaby, this.species});

  Chain.fromJson(Map<String, dynamic> json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = new List<EvolutionDetails>();
      json['evolution_details'].forEach((v) {
        evolutionDetails.add(new EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails.map((v) => v.toJson()).toList();
    }
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolvesTo {
  List<EvolutionDetails> evolutionDetails;
  List<EvolvesTo> evolvesTo;
  bool isBaby;
  Trigger species;

  EvolvesTo({this.evolutionDetails, this.evolvesTo, this.isBaby, this.species});

  EvolvesTo.fromJson(Map<String, dynamic> json) {
    if (json['evolution_details'] != null) {
      evolutionDetails = new List<EvolutionDetails>();
      json['evolution_details'].forEach((v) {
        evolutionDetails.add(new EvolutionDetails.fromJson(v));
      });
    }
    if (json['evolves_to'] != null) {
      evolvesTo = new List<EvolvesTo>();
      json['evolves_to'].forEach((v) {
        evolvesTo.add(new EvolvesTo.fromJson(v));
      });
    }
    isBaby = json['is_baby'];
    species =
        json['species'] != null ? new Trigger.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evolutionDetails != null) {
      data['evolution_details'] =
          this.evolutionDetails.map((v) => v.toJson()).toList();
    }
    if (this.evolvesTo != null) {
      data['evolves_to'] = this.evolvesTo.map((v) => v.toJson()).toList();
    }
    data['is_baby'] = this.isBaby;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class EvolutionDetails {
  int minLevel;
  bool needsOverworldRain;
  String timeOfDay;
  Trigger trigger;
  bool turnUpsideDown;
  Trigger item;

  EvolutionDetails(
      {this.minLevel,
      this.needsOverworldRain,
      this.timeOfDay,
      this.trigger,
      this.turnUpsideDown,
      this.item,});

  EvolutionDetails.fromJson(Map<String, dynamic> json) {
    minLevel = json['min_level'];
    needsOverworldRain = json['needs_overworld_rain'];
    timeOfDay = json['time_of_day'];
    item = json['item'] != null ? new Trigger.fromJson(json['item']) : null;
    trigger =
        json['trigger'] != null ? new Trigger.fromJson(json['trigger']) : null;
    turnUpsideDown = json['turn_upside_down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_level'] = this.minLevel;
    data['needs_overworld_rain'] = this.needsOverworldRain;
    data['time_of_day'] = this.timeOfDay;
    if (this.trigger != null) {
      data['trigger'] = this.trigger.toJson();
    }
    data['turn_upside_down'] = this.turnUpsideDown;
    return data;
  }
}

class Trigger {
  String name;
  String url;

  Trigger({this.name, this.url});

  Trigger.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}