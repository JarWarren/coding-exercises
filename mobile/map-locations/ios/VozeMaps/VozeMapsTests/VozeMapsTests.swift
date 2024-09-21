//
//  VozeMapsTests.swift
//  VozeMapsTests
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation
import Testing
@testable import VozeMaps

struct VozeMapsTests {

    @Test func testDecodeLocations() async throws {
        let input = """
                [
                    {
                        "id": 4,
                        "latitude": 37.7740,
                        "longitude": -122.4200,
                        "attributes": [
                            {
                                "type": "location_type",
                                "value": "landmark"
                            },
                            {
                                "type": "name",
                                "value": "Transamerica Pyramid"
                            },
                            {
                                "type": "description",
                                "value": "Iconic skyscraper in the Financial District."
                            },
                            {
                                "type": "estimated_revenue_millions",
                                "value": 12.3
                            }
                        ]
                    },
                    {
                        "id": 5,
                        "latitude": 37.7748,
                        "longitude": -122.4185,
                        "attributes": [
                            {
                                "type": "location_type",
                                "value": "cafe"
                            },
                            {
                                "type": "name",
                                "value": "Union Square Cafe"
                            },
                            {
                                "type": "description",
                                "value": "Cozy cafe in the heart of downtown."
                            },
                            {
                                "type": "estimated_revenue_millions",
                                "value": 3.7
                            }
                        ]
                    }
                ]
                """
            .data(using: .utf8)!
        
        let expected: [Location] = [
            Location(
                id: 4,
                latitude: 37.7740,
                longitude: -122.4200,
                type: .landmark,
                name: "Transamerica Pyramid",
                description: "Iconic skyscraper in the Financial District.",
                estimatedRevenueInMillions: 12.3
            ),
            Location(
                id: 5,
                latitude: 37.7748,
                longitude: -122.4185,
                type: .cafe,
                name: "Union Square Cafe",
                description: "Cozy cafe in the heart of downtown.",
                estimatedRevenueInMillions: 3.7
            )
        ]
        
        let result = try JSONDecoder().decode([Location].self, from: input)
        #expect(result == expected)
    }

}
