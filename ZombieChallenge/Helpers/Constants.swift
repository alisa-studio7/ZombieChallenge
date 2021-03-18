//
//  Constants.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

struct Zombie {
    struct Core {
        var baseURL: String { return "https://palo-it-zombie.herokuapp.com" }
    }
}

enum EndPoint: String {
    case illnesses = "/illnesses"
    case hospitals = "/hospitals"
}

enum CellIdentifier: String {
    case illnessCell = "IllnessCell"
    case hospitalCell = "HospitalCell"
}

enum StoryboardIdentifier: String {
    case illnesses = "Illnesses"
    case severityLevel = "SeverityLevel"
    case suggestHospital = "Hospitals"
}

enum SeverityLevel: String, CaseIterable {
    case noPain = "No Pain"
    case mild = "Mild"
    case moderate = "Moderate"
    case severe = "Severe"
    case verySevere = "Very Severe"
    
    var level: Int {
        switch self {
        case .noPain:
            return 0
        case .mild:
            return 1
        case .moderate:
            return 2
        case .severe:
            return 3
        case .verySevere:
            return 4
        }
    }
}

enum FirestoreDB: String {
    case PATIENT_INFO = "patientInfo"
    case PATIENT_ILLNESS = "illness"
    case PATIENT_NAME = "name"
    case PATIENT_ID = "id"
    case PATIENT_SEVERITY_LEVEL = "severityLevel"
}
