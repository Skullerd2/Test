/// Модель отзыва.
struct Review: Decodable {

    /// Аватарка.
    let avatarUrl: String?
    /// Имя пользователя.
    let firstName: String
    /// Фамилия пользователя.
    let lastName: String
    /// Рейтинг.
    let rating: Int
    /// Текст отзыва.
    let text: String
    /// Время создания отзыва.
    let created: String

}
