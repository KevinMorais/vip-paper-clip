public protocol PaperClipCategories {
    func fetch(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void)
}

final public class PaperClipCategoriesImpl {

    struct Dependencies {
        let repository: PaperClipCategoriesRepository
        init(repository: PaperClipCategoriesRepository = PaperClipCategoriesRepositoryImpl()) {
            self.repository = repository
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public init() {
        self.dependencies = Dependencies()
    }

}

// MARK: - PaperClipCategories
extension PaperClipCategoriesImpl: PaperClipCategories {

    public func fetch(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void) {
        dependencies.repository.get(completionHandler: completionHandler)
    }
}
