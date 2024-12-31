//
//  CommunityCreationRequestBuilder.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/28/24.
//

// TODO: We should add more items to the preview (resources, community name, etc...)
extension CommunityCreationRequestBuilder {
    static var preview: CommunityCreationRequestBuilder {
        let builder = CommunityCreationRequestBuilder()
        try! builder.addRule("RuleDescription", description: "Thibcabcahbcatorbcalbcaboubcaobcabcaifbcaobcalippebcapsidbcaowbcandbcabcaikbcabcaakbcainute")
        try! builder.addRule("RuleDescription2", description: "Thibcabcahbcatorbcalbcaboubcaobcabcaifbcaobcalippebcapsidbcaowbcandbcabcaikbcabcaakbcainute")
        return builder
    }
}
