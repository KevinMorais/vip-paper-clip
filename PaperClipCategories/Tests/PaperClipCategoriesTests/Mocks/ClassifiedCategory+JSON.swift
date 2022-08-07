//
//  ClassifiedCategory+JSON.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
import PaperClipCategories

extension ClassifiedCategory {

    static func getArrayJSON() -> String {
        """
        [
          {
            "id": 1,
            "name": "Véhicule"
          },
          {
            "id": 2,
            "name": "Mode"
          },
          {
            "id": 3,
            "name": "Bricolage"
          }
        ]
        """
    }

    static func getArrayWrongJSON() -> String {
        """
        [
          {
            "id": 1,
            "name": "Véhicule"
          },
          {
            "id": 2,
            "name": "Mode"
          },
          {
            "id": error,
            "name": "Bricolage"
          }
        ]
        """
    }
}
