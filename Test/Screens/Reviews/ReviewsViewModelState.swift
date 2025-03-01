/// Модель, хранящая состояние вью модели.

import Foundation

struct ReviewsViewModelState {

    var items = [any TableCellConfig]()
    var limit = 20
    var offset = 0
    var shouldLoad = true

}
