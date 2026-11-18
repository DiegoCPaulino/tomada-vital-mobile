/// Kind of life-support device plugged into the Tomada Vital sensor.
enum EquipmentType { oxygenConcentrator, ventilator, suctionDevice, infusionPump, other }

/// Urgency of an outage, based on the minutes of battery left.
enum Priority { critical, high, moderate }

/// Lifecycle of an outage in the response queue.
enum OutageStatus { open, inProgress, resolved }

/// Actions the response center takes while handling an outage.
enum ResponseAction { teamOnTheWay, generatorDelivered, patientRelocated, powerRestored }
