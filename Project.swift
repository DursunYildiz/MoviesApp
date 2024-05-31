import ProjectDescription
import ProjectDescriptionHelpers
let project = Project(
    name: "Movies",
    packages: [],
    targets: [.target(
        name: "Movies",
        destinations: .iOS,
        product: .app,
        productName: "Movies",
        bundleId: "com.example.movies",
        deploymentTargets: .iOS("17.0"),
        infoPlist: .extendingDefault(with: ["UILaunchScreen": [:]]),
        sources: "Movies/Sources/**",
        resources: "Movies/Resources/**",
        dependencies: [networkKit,utilsKit,mockKit]
    )]
)
