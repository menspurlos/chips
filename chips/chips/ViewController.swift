//
//  ViewController.swift
//  chips
//
//  Created by Дмитрий Гришкин on 28.06.2024.
//

import UIKit

class ViewController: UIViewController {

    let alternative: Reliability.Alternative = .init(title: "Привет", description: "fdfdshjkghkjfdlghkhlglks",
                                         alternatives: [.init(title: "Apple", url: ""),
                                                        .init(title: "hfksfhg", url: ""),
                                                        .init(title: "аваыfdgsdfgsdfgsdgf", url: ""),
                                                        .init(title: "ваывgfhjsfglkjshdgfkjdkjlhfgsdfgsdfg", url: "")])
    let chipsView = ChipsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chipsView.configure(with: alternative)
        
        view.addSubview(chipsView)
        chipsView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.directionalVerticalEdges.equalToSuperview().inset(100)
        }
    }
}

