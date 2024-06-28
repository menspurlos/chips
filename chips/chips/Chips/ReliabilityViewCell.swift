//
//  ReliabilityViewCell.swift
//  chips
//
//  Created by Дмитрий Гришкин on 28.06.2024.
//

import UIKit

final class ReliabilityAlternatibeViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: ReliabilityAlternatibeViewCell.self)
    
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var commonView: UIView = {
        
        return UIView(frame: .zero)
    }()
    
    func configure(with model: Reliability.Alternative.AlternativeList) {
        label.text = model.title
    }
    
    private func commonInit() {
        
        contentView.addSubview(commonView)
        commonView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        commonView.addSubview(label)
        label.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
        
        commonView.layer.cornerRadius = 8
        commonView.layer.borderColor = UIColor(named: "black")?.cgColor
        commonView.layer.borderWidth = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Allow the cell to resize itself as needed when the collection view width changes
        contentView.autoresizingMask = [.flexibleWidth]
    }
}
