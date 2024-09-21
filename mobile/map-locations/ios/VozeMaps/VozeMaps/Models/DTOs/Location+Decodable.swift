//
//  Location+Decodable.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

extension Location: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude, attributes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        
        let attributes = try container.decode([Attribute].self, forKey: .attributes)
        let dictionary = Dictionary(uniqueKeysWithValues: attributes.map { ($0.type, $0.value) })
        
        guard
            let nameAttribute = dictionary[.name],
            let typeAttribute = dictionary[.type],
            let descriptionAttribute = dictionary[.description],
            let estimatedRevenueInMillionsAttribute = dictionary[.estimatedRevenueInMillions],
            case let .string(name) = nameAttribute,
            case let .locationType(type) = typeAttribute,
            case let .string(description) = descriptionAttribute,
            case let .double(estimatedRevenueInMillions) = estimatedRevenueInMillionsAttribute
        else { throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.attributes], debugDescription: "Unexpected attribute")) }
        
        self.name = name
        self.type = type
        self.description = description
        self.estimatedRevenueInMillions = estimatedRevenueInMillions
    }
    
    private struct Attribute: Codable {
        let type: AttributeType
        let value: Value
        
        enum AttributeType: String, Codable {
            case name
            case description
            case type = "location_type"
            case estimatedRevenueInMillions = "estimated_revenue_millions"
        }
        
        enum Value: Codable {
            case locationType(LocationType)
            case string(String)
            case double(Double)
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                if let locationValue = try? container.decode(LocationType.self) {
                    self = .locationType(locationValue)
                } else if let stringValue = try? container.decode(String.self) {
                    self = .string(stringValue)
                } else if let doubleValue = try? container.decode(Double.self) {
                    self = .double(doubleValue)
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unexpected Attribute value")
                }
            }
        }
    }
}
