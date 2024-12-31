//
//  PreviewService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import Factory

final class PreviewService {
    @StorageActor
    static func registerMocks() {
        Container.shared.appwriteService.register { AppwriteServiceMock() }
        Container.shared.commentService.register { CommentServiceMock() }
        Container.shared.communityService.register { CommunityServiceMock() }
        Container.shared.membershipService.register { MembershipServiceMock() }
        Container.shared.postService.register { PostServiceMock() }
        Container.shared.richLinkService.register { RichLinkServiceMock() }
        Container.shared.voteService.register { VoteServiceMock() }
        // session service
        // user service
    }
}
