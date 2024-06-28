//
//  ChipsView.swift
//  DNS-SHOP
//
//  Created by Дмитрий Гришкин on 24.06.2024.
//

import UIKit
import SnapKit

protocol ProductCardReliabilityAlternativesViewDelegate: AnyObject {
    func tapOnProductCardReliabilityAlternativesView()
}

enum Section: CaseIterable {
    case alternative
}

class ChipsView: UIView {
    
    weak var delegate: ProductCardReliabilityAlternativesViewDelegate?
    
    private lazy var commonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = CGColor(red: 100, green: 100, blue: 100, alpha: 100)
        view.layer.shadowOpacity = 0.13
        view.layer.shadowOffset = .init(width: 0, height: 1)
        view.layer.shadowRadius = 1.6
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .white
        collection.register(ReliabilityAlternatibeViewCell.self, forCellWithReuseIdentifier: ReliabilityAlternatibeViewCell.reuseIdentifier)
        return collection
    }()
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Reliability.Alternative.AlternativeList>(collectionView: collection) { collection, indexPath, model in
        guard
            let cell = collection.dequeueReusableCell(withReuseIdentifier: ReliabilityAlternatibeViewCell.reuseIdentifier, for: indexPath) as? ReliabilityAlternatibeViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func getLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 8
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(30))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1000),
                                               heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func commonInit() {
        
        addSubview(commonView)
        commonView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.directionalVerticalEdges.equalToSuperview().inset(6)
        }
        
        commonView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(topTitle)
        stackView.addArrangedSubview(descriptionTitle)
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
        contentView.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.directionalHorizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
    
    func configure(with reliability: Reliability.Alternative) {
        guard let title = reliability.title,
              let description = reliability.description else { return }
        
        self.backgroundColor = .blue
        self.topTitle.text = title
        self.descriptionTitle.text = description
        
        if let alternatives = reliability.alternatives {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Reliability.Alternative.AlternativeList>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(alternatives, toSection: .alternative)
            
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
