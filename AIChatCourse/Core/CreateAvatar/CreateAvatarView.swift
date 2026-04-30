//
//  CreateAvatarView.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 30/04/2026.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .defaultValue
    @State private var characterAction: CharacterAction = .defaultValue
    @State private var characterLocation: CharacterLocation = .defaultValue
    @State private var isGenerating: Bool = false
    @State private var generatedImage: UIImage?
    @State private var isSaving: Bool = false

    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                buttonSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }
    
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.title2)
            .fontWeight(.semibold)
            .anyButton {
                onBAckButtonPressed()
            }
    }
    
    private func onBAckButtonPressed(){
        dismiss()
    }
    
    private var nameSection: some View {
        Section {
            TextField("name your avatar", text: $avatarName)
        } header: {
            Text("Name your avatar*")
        }
    }
    
    private var attributesSection: some View {
        Section {
            Picker(selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .tag(option)
                }
            } label: {
                Text("it is...")
            }

            Picker(selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { action in
                    Text(action.rawValue.capitalized)
                        .tag(action)
                }
            } label: {
                Text("that is...")
            }

            Picker(selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { location in
                    Text(location.rawValue.capitalized)
                        .tag(location)
                }
            } label: {
                Text("in the...")
            }

        } header: {
            Text("Attributes")
        }
    }
    
    private var imageSection: some View {
        Section {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    Text("Generate image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton(.plain){
                            onGenerateButtonTapped()
                        }
                        .opacity(isGenerating ? 0 : 1)
                    
                    ProgressView()
                        .tint(.accent)
                        .opacity(isGenerating ? 1 : 0)
                }
                .disabled(isGenerating || avatarName.isEmpty)
                
                Circle()
                    .fill(.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                    .clipShape(Circle())
                
            }
            .removeListRowFormatting()
        }
    }
    
    private var buttonSection: some View {
        Section {
            AsyncCallToActionButton(
                isLoading: isSaving,
                onComplete: onSavePressed
            )
            .removeListRowFormatting()
            .padding(.top, 24)
            .opacity(generatedImage == nil ? 0.5 : 1)
            .disabled(generatedImage == nil)
        }
        
    }
    
    func onGenerateButtonTapped() {
        isGenerating = true
        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "star.fill")
            isGenerating = false
        }
    }
    func onSavePressed() {
        isSaving = true
        Task {
            try? await Task.sleep(for: .seconds(3))
            dismiss()
            isSaving = false
        }
    }
    
}

#Preview {
    CreateAvatarView()
}
