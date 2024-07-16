import ProjectDescriptionHelpers
import ProjectDescription

let project = Project.excutable(
    name: "TelTree",
    platform: .iOS,
    deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
    dependencies: []
)
