//
//  RootRouter.swift
//  ArchitectureStudy
//
//  Created by Bongwook Bin on 2017. 3. 1..
//  Copyright © 2017년 papabins. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    func presentLogin(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = ArticlesRouter.assembleModule()
    }
}
