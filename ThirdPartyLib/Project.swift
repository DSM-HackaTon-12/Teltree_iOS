import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLib",
    packages: [
        .RxSwift,
        .Moya,
        .Then,
        .SnapKit,
        .Kingfisher
    ],
    deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
    dependencies: [
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.SnapKit,
        .SPM.Kingfisher
    ]
)
