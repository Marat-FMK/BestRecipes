//
//  InstructionsCell.swift
//  BestRecipes
//
//  Created by Aliaksandr Zuyeu on 14.08.25.
//

import UIKit

class RecipeDetailInstructionsCell: UITableViewCell {
    
    static let identifier = "InstructionsCell"
    
    private let instuctionsHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 20)
        label.text = "Instructions"
        return label
    }()
    
    private let instructionsText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        let text = """
        1. Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.
        2. Place chopped eggs in a bowl.
        3. Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice.
        4. Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper.
        5. Stir and serve on your favorite bread or crackers.
        """
        let instrFont = UIFont(name: Constants.Fonts.poppinsRegular, size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 14
        paragraphStyle.alignment = .left
        textView.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: instrFont!])
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let ingredientsHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: Constants.Fonts.poppinsSemiBold, size: 20)
        label.text = "Ingredients"
        return label
    }()
    
    private let countOfItems: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.poppinsRegular, size: 16)
        label.textColor = Constants.Colors.Neutral.neutral50
        label.text = "items"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(instuctionsHeader)
        NSLayoutConstraint.activate([
            instuctionsHeader.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6.5),
            instuctionsHeader.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            instuctionsHeader.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
        self.contentView.addSubview(instructionsText)
        NSLayoutConstraint.activate([
            instructionsText.topAnchor.constraint(equalTo: instuctionsHeader.bottomAnchor, constant: 5),
            instructionsText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            instructionsText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:  -31)
        ])
        
        self.contentView.addSubview(ingredientsHeaderView)
        NSLayoutConstraint.activate([
            ingredientsHeaderView.topAnchor.constraint(equalTo: instructionsText.bottomAnchor,constant: 37),
            instructionsText.bottomAnchor.constraint(equalTo: ingredientsHeaderView.topAnchor, constant: -37),
            ingredientsHeaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            ingredientsHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ingredientsHeaderView.heightAnchor.constraint(equalToConstant: 28),
            ingredientsHeaderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6.5)
        ])
        
        ingredientsHeaderView.addSubview(ingredientsLabel)
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientsHeaderView.topAnchor),
            ingredientsLabel.leadingAnchor.constraint(equalTo: ingredientsHeaderView.leadingAnchor),
            ingredientsLabel.bottomAnchor.constraint(equalTo: ingredientsHeaderView.bottomAnchor),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 166)
        ])
        
        ingredientsHeaderView.addSubview(countOfItems)
        NSLayoutConstraint.activate([
            countOfItems.centerYAnchor.constraint(equalTo: ingredientsHeaderView.centerYAnchor),
            countOfItems.trailingAnchor.constraint(equalTo: ingredientsHeaderView.trailingAnchor, constant: -7)
        ])
    }
    
    func configure(with recipe: RecipeDetail) {
        let text = recipe.instructions.isEmpty
                ? "You can find following instructions at the link: \(recipe.sourceUrl)"
                : recipe.instructions
            self.instructionsText.attributedText = formatNumberedParagraphs(text)
            self.countOfItems.text = "\(recipe.extendedIngredients.count) items"
    }
}

extension String {
    // Removes all <tags> and their contents
    func removeTags() -> String {
        let pattern = #"<[^>]*>"#
        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
    }

    // Splits text into paragraphs at [. ! ? : ; - —] followed by a capital letter
    func splitIntoParagraphs() -> [String] {
        let cleanText = self.removeTags()
        let pattern = #"(?<=[\.\!\?\:\;\-\—])\s*(?=[A-Z])"#
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(cleanText.startIndex..., in: cleanText)
        let matches = regex?.matches(in: cleanText, options: [], range: range) ?? []

        var lastIndex = cleanText.startIndex
        var paragraphs: [String] = []

        for match in matches {
            let matchRange = Range(match.range, in: cleanText)!
            let paragraph = String(cleanText[lastIndex..<matchRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
            if !paragraph.isEmpty {
                paragraphs.append(paragraph)
            }
            lastIndex = matchRange.lowerBound
        }
        let lastParagraph = String(cleanText[lastIndex...]).trimmingCharacters(in: .whitespacesAndNewlines)
        if !lastParagraph.isEmpty {
            paragraphs.append(lastParagraph)
        }
        return paragraphs
    }
}

// Formats numbered paragraphs with a single newline
func formatNumberedParagraphs(_ text: String) -> NSAttributedString {
    let paragraphs = text.splitIntoParagraphs()
    let instrFont = UIFont(name: Constants.Fonts.poppinsRegular, size: 16)!
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    paragraphStyle.headIndent = 14
    paragraphStyle.alignment = .left

    let result = NSMutableAttributedString()
    for (index, paragraph) in paragraphs.enumerated() {
        let numbered = "\(index + 1). \(paragraph)\n"
        let attr = NSAttributedString(string: numbered, attributes: [
            .font: instrFont,
            .paragraphStyle: paragraphStyle
        ])
        result.append(attr)
    }
    return result
}
