//
//  network_loadData
//
//  Created by Евгений Сабина on 11.05.24.
//

import Foundation

struct todos: Codable {
    let userId, id: Int
    let title: String
    let completed: Bool
}
