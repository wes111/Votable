//
//  SubmitPostInput.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class PostCreationRequestBuilder: CreationRequestBuilder {
    typealias Flow = PostFlow
    @ObservationIgnored @Injected(\.richLinkService) private var richLinkService
    @ObservationIgnored @Injected(\.userAsyncStreamManager) private var userStreamManager
    
    let community: Community
    private(set) var title: PostTitleInput?
    private(set) var primaryLink: Link?
    private(set) var body: PostBodyInput?
    private(set) var tags: [CommunityTag] = []
    private(set) var category: PostCategory?
    
    init(community: Community) {
        self.community = community
    }
    
    func setTitle(_ title: String) throws(BuilderError) {
        self.title = try validate(
            value: title,
            transform: { try PostTitleInput(value: $0) },
            field: .title
        )
    }
    
    func setPrimaryLink(_ link: String) async throws(BuilderError) {
        do {
            try await fetchLinkMetadata(for: link)
        } catch {
            throw .linkMissingMetadata
        }
        self.primaryLink = try validate(
            value: link,
            transform: { try Link(value: $0) },
            field: .primaryLink
        )
    }
    
    func setBody(_ body: String) throws(BuilderError) {
        self.body = try validate(
            value: body,
            transform: { try PostBodyInput(value: $0) },
            field: .body
        )
    }
    
    func setTags(_ tags: [CommunityTag]) {
        self.tags = tags
    }
    
    func setCategory(_ category: PostCategory) {
        self.category = category
    }
    
    private func fetchLinkMetadata(for urlString: String) async throws(BuilderError) {
        guard let url = URL(string: urlString) else {
            throw .linkMissingMetadata
        }
        do {
            _ = try await richLinkService.getMetadata(for: url)
        } catch {
            throw .linkMissingMetadata
        }
    }
    
    func build() async throws(BuilderError) -> PostCreationRequest {
        guard let title, let body, let category, let userId = await userStreamManager.currentValue?.id else {
            throw .defaultError
        }
        
        return PostCreationRequest(
            title: title.value,
            body: body.value,
            link: primaryLink?.value.absoluteString,
            categoryName: category.name,
            tagIds: tags.map { $0.id },
            communityTagsString: tags.map { $0.name }.joined(separator: ","),
            userId: userId,
            communityId: community.id
        )
    }
}
