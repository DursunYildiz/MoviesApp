//
//  BaseViewModel.swift
//  Meter Reader
//
//  Created by Dursun YILDIZ on 10.11.2023.
//

import Foundation

open class BaseViewModel {
    public  init() {
        Log.info("***INIT*** \(String(describing: type(of: self)))")
        onLoad()
    }

   private func onLoad() {}

    deinit {
        Log.info("***DEINIT*** \(String(describing: type(of: self)))")
    }
}
