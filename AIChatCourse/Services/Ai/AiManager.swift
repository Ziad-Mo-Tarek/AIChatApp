//
//  AiManager.swift
//  AIChatCourse
//
//  Created by Systemira's mac mini on 01/06/2026.
//

import Foundation
import SwiftUI

protocol AIService {
    func generateImage(input: String) async throws -> UIImage
}

struct MockAiService: AIService {
    func generateImage(input: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "star.fill")!
    }
}

import OpenAI
struct OpenAiService: AIService {
    
    var openAi: OpenAI {
        OpenAI(apiToken: Keys.openAi)
    }
    
    func generateImage(input: String) async throws -> UIImage {
        let query = ImagesQuery(
            prompt: input,
            n: 1,
            quality: .hd,
            responseFormat: .b64_json,
            size: ._512,
            style: .natural,
            user: nil
        )
        
        let result = try await openAi.images(query: query)
        
        guard let b64Json = result.data.first?.b64Json,
              let data = Data(base64Encoded: b64Json),
              let image = UIImage(data: data) else {
            throw OpenAiError.invalidResponse
        }
        
        return image
        
    }
    
    enum OpenAiError: LocalizedError {
        case invalidResponse
    }
    
}


@Observable
@MainActor
class AiManager {
    
    private let service: AIService
    
    init(service: AIService) {
        self.service = service
    }
    
    func generateImage(input: String) async throws -> UIImage {
        try await service.generateImage(input: input)
    }
    
}
