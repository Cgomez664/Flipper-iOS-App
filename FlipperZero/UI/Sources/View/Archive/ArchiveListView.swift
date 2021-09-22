import Core
import SwiftUI

struct ArchiveListView: View {
    @Binding var isEditing: Bool
    @Binding var selectedItems: [ArchiveItem]
    var itemSelected: (ArchiveItem) -> Void

    init(
        isEditing: Binding<Bool>,
        selectedItems: Binding<[ArchiveItem]>,
        itemSelected: @escaping (ArchiveItem) -> Void
    ) {
        self._isEditing = isEditing
        self._selectedItems = selectedItems
        self.itemSelected = itemSelected
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(demo) { item in
                    Button {
                        itemSelected(item)
                    } label: {
                        HStack {
                            if isEditing {
                                Image(systemName: selectedItems.contains(item)
                                      ? "checkmark.circle.fill"
                                      : "circle"
                                )
                                .padding(.trailing, 8)
                            }
                            ArchiveListItemView(item: item)
                                .foregroundColor(.primary)
                                .background(systemBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.leading, 16)
            .padding(.trailing, 15)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
    }
}

struct ArchiveListItemView: View {
    let item: ArchiveItem

    var body: some View {
        HStack(spacing: 15) {
            item.icon
                .resizable()
                .frame(width: 23, height: 23)
                .scaledToFit()
                .padding(.horizontal, 17)
                .padding(.vertical, 22)
                .background(item.color)

            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .fontWeight(.medium)
                    .lineLimit(1)

                Text(item.origin)
                    .fontWeight(.thin)
            }

            Spacer()

            VStack {
                Spacer()
                Image(systemName: randomImage())
                    .font(.system(size: 14))
                    .padding(.trailing, 15)
                    .foregroundColor(.secondary)
                    .opacity(randomOpacity())
                Spacer()
            }
        }
    }

    func randomImage() -> String {
        ["checkmark", "arrow.triangle.2.circlepath"].randomElement() ?? ""
    }

    func randomOpacity() -> Double {
        [true, false, true].randomElement() ?? false ? 1 : 0
    }
}
