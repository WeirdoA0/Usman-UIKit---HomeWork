//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Амир on 14.01.2024.
//

import Foundation
import UIKit
import WebKit

class VideoTableViewCell: UITableViewCell {
    //MARK: Subviews
    private lazy var webview: WKWebView = {
        let pref = WKWebpagePreferences()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let view = WKWebView(frame: .zero, configuration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.scrollView.isScrollEnabled = false
        return view
    }()
    //MARK: lifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: "VideoCell")
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func setConstraints(){
        self.contentView.addSubview(webview)
        NSLayoutConstraint.activate([
            webview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webview.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            webview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
        ])
    }
    //MARK: Internal
    internal func update(id: String){
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(id)") else { return }
//        webview.load(URLRequest(url: youtubeURL))
        webview.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"\(youtubeURL)?&rel=0\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
}
