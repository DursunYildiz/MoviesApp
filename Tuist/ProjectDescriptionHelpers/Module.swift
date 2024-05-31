//
//  Module.swift
//  PokusManifests
//
//  Created by Dursun YILDIZ on 25.03.2024.
//

import ProjectDescription
public extension Project
{
    static func module(name: String,
                       hasResources: Bool,
                       resources: ResourceFileElements = ["Resources/**"],
                       dependencies: [TargetDependency] = [],
                       packages: [Package] = []) -> Self
    {
        let frameworkTarget: Target = .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            bundleId: bundleId + "." + name,
            deploymentTargets: .iOS(iOSTargetVersion),
            infoPlist: .default,
            sources: "Sources/**",
            resources: hasResources ? resources : nil,
            dependencies: dependencies
        )
        return Project(
            name: name,
            packages: packages,
            targets: [frameworkTarget]
        )
    }
}

private let bundleId: String = "com.example.movies" 
public let version: String = "1.0.0"
public let bundleVersion: String = "1"
public let iOSTargetVersion: String = "16.0"
