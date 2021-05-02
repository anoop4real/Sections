//
//  ViewFactory.swift
//
//  Created by Anoop M on 2021-04-24.
//

import Foundation
import UIKit

class ViewFactory {
    class func createSimpleStackViewWith(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 1, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = distribution
        return stackView
    }
    
    class func createSimpleLabelWith(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    class func createASimpleUIView(with backgroundColor: UIColor = UIColor.white, cornerRadius: CGFloat = 0.0) -> UIView {
        let newView = UIView()
        newView.backgroundColor = backgroundColor
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.layer.cornerRadius = cornerRadius
        return newView
    }
    
    class func createTableViewWith(cellClass: AnyClass?, forCellWithReuseIdentifier: String, headerClass: AnyClass?, forHeaderWithReuseIdentifier: String) -> UITableView {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.register(cellClass, forCellReuseIdentifier: forCellWithReuseIdentifier)
        view.register(headerClass, forHeaderFooterViewReuseIdentifier: forHeaderWithReuseIdentifier)
        view.tableFooterView = UIView()
        return view
    }
    
    class func createSimpleTableViewWith(cellClass: AnyClass?, forCellWithReuseIdentifier: String) -> UITableView {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.register(cellClass, forCellReuseIdentifier: forCellWithReuseIdentifier)
        view.tableFooterView = UIView()
        return view
    }
    
    // Use the new compositional layout
    class func createSimpleCollectionViewWith(layout: UICollectionViewLayout,
                                              cellClass: AnyClass?,
                                              forCellWithReuseIdentifier: String,
                                              supplementaryViewClass: AnyClass?,
                                              forReuseIdentifier: String?,
                                              sectionInset: UIEdgeInsets? = nil) -> UICollectionView
    {
        let alignedFlowLayout = layout
        let view = UICollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(cellClass, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        if let supplementaryClass = supplementaryViewClass,
           let identifier = forReuseIdentifier
        {
            view.register(supplementaryClass,
                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: identifier)
        }

        return view
    }
    
    class func createASimpleImageView(with placeholderImage: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        if let placeholderImage = placeholderImage {
            imageView.image = placeholderImage
        }
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    class func createASimpleTextView(with font: UIFont = .systemFont(ofSize: 15.0), textColor: UIColor = .black) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = font
        textView.textColor = textColor
        
        return textView
    }
}
