import PaperClipCategories

public protocol PaperClipClassifiedAds {
    func fetch(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void)
}

final public class PaperClipClassifiedAdsImpl {

    struct Dependencies {
        let categoriesFeature: PaperClipCategories
        let repository: PaperClipClassifiedAdsRepository
        init(
            repository: PaperClipClassifiedAdsRepository = PaperClipClassifiedAdsRepositoryImpl(),
            categoriesFeature: PaperClipCategories = PaperClipCategoriesImpl()
        ) {
            self.repository = repository
            self.categoriesFeature = categoriesFeature
        }
    }

    private let dependencies: Dependencies
    private var categories: [ClassifiedCategory] = []

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    public init() {
        self.dependencies = Dependencies()
    }

    private func fetchCategories(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void) {
        dependencies.categoriesFeature.fetch { [weak self] result in
            self?.categories = (try? result.get()) ?? []
            completionHandler(result)
        }
    }

    private func appendCategories(with classifiedAds: [ClassifiedAd]) -> [ClassifiedAd] {
        return classifiedAds.map { classifiedAd in
            var mutableClassifiedAd = classifiedAd
            let category = categories.first(where: { $0.id == classifiedAd.categoryId })
            mutableClassifiedAd.set(category)
            return mutableClassifiedAd
        }
    }

}

// MARK: - PaperClipClassifiedAds
extension PaperClipClassifiedAdsImpl: PaperClipClassifiedAds {

    public func fetch(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        fetchCategories { [weak self] result in
            if case let .failure(error) = result {
                completionHandler(.failure(error))
                return
            }
            self?.dependencies.repository.get { [weak self] response in
                guard let self = self else {
                    return
                }
                let newResponse = response.map { classifiedAds in
                    return self.appendCategories(with: classifiedAds)
                }
                completionHandler(newResponse)
            }
        }
    }
}
