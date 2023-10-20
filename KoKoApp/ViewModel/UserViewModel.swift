//
//  UserViewModel.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import UIKit

final class UserViewModel {

    public var userResponse: (UserResponse) -> () = { response in }
    public var errorResponse: (Error) -> () = { error in }

    public func bindingApi() {
        
        ApiServersModel(api: .profile, method: .GET).requestHttpServer { [weak self] (result: Result<UserResponse, Error>) in
            switch result {
            case .success(let success):
                self?.userResponse(success)
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

    }

}
