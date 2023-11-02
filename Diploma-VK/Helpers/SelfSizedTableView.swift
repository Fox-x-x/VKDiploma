//
//  SelfSizedTableView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 01.06.2023.
//

import UIKit

class SelfSizedTableView: UITableView {
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
        
    }
      
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = contentSize.height
        return CGSize(width: contentSize.width, height: height)
    }
}
