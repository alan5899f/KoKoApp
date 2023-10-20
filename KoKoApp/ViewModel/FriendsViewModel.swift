//
//  FriendsViewModel.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import Foundation

enum FriendsApiType {
    case friend1
    case friend2
    case friend3
}

class FriendsViewModel {

    public var friendsResponse: ([FriendModel]) -> () = { response in }
    public var errorResponse: (Error) -> () = { error in }
    public var friendsApiType: FriendsApiType = .friend1

    public func refreshBinding() {
        switch friendsApiType {
        case .friend1:
            bindingApi1()
        case .friend2:
            bindingApi2()
        case .friend3:
            bindingApi3()
        }
    }

    /// 需求1
    public func bindingApi1() {

        friendsApiType = .friend1

        ApiServersModel(api: .friend4).requestHttpServer { [weak self] (result: Result<FriendsResponse, Error>) in
            switch result {
            case .success(let success):
                self?.friendsResponse(success.response ?? [])
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

    }

    /// 需求2
    public func bindingApi2() {

        friendsApiType = .friend2

        let group = DispatchGroup()
        var friendsData: [FriendModel] = []

        group.enter()
        ApiServersModel(api: .friend1).requestHttpServer { [weak self] (result: Result<FriendsResponse, Error>) in
            switch result {
            case .success(let success):
                friendsData += success.response ?? []
                group.leave()
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

        group.enter()
        ApiServersModel(api: .friend2).requestHttpServer { [weak self] (result: Result<FriendsResponse, Error>) in
            switch result {
            case .success(let success):
                friendsData += success.response ?? []
                group.leave()
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

        group.notify(queue: .global()) { [weak self] in
            self?.friendsResponse(self?.dataMerge(friendsData) ?? [])
        }

    }

    /// 需求3
    public func bindingApi3() {

        friendsApiType = .friend3

        ApiServersModel(api: .friend3).requestHttpServer { [weak self] (result: Result<FriendsResponse, Error>) in
            switch result {
            case .success(let success):
                self?.friendsResponse(success.response ?? [])
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

    }

    private func dataMerge(_ data: [FriendModel]) -> [FriendModel] {

        var mergedData: [String: FriendModel] = [:]

        data.forEach { friend in

            let fid = friend.fid ?? ""
            let updateDateStr = friend.updateDate ?? ""

            if let existingFriend = mergedData[fid],
               let existingUpdateDateStr = existingFriend.updateDate {

                if compareDate(lhs: updateDateStr, rhs: existingUpdateDateStr) {
                    mergedData[fid] = friend
                }

            } else {

                mergedData[fid] = friend

            }


        }

        let mergedArray = Array(mergedData.values)
        return mergedArray.sorted(by: {$0.name ?? "" > $1.name ?? ""})
    }

    private func compareDate(lhs: String, rhs: String) -> Bool {
        lhs.toDate1970Double() > rhs.toDate1970Double()
    }

}
