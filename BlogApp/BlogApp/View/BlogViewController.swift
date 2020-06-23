//
//  BlogViewController.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController {

    @IBOutlet weak var blogTable: UITableView!
    lazy var viewModel = BlogViewControllerViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Articles"
        blogTable.rowHeight             = UITableView.automaticDimension
        blogTable.estimatedRowHeight    = UITableView.automaticDimension
        blogTable.tableHeaderView       = UIView(frame: .zero)
        blogTable.tableFooterView       = UIView(frame: .zero)
        viewModel.loadMoreData()
    }
}

extension BlogViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let blogCell = tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell", for: indexPath) as! BlogTableViewCell
        let cellViewModel = BlogTableViewCellViewModel(viewModel.blogForCell(index: indexPath))
        blogCell.loadCell(cellViewModel)
        if let mediaImageURL = cellViewModel.mediaImageURL  {
            blogCell.mediaImage.isHidden = false
            blogCell.mediaImage.image   = ImageDownloader.showImageFromCache(mediaImageURL, completionHandler: {[weak tableView , weak blogCell] (image) in
            DispatchQueue.main.async { [weak tableView , weak blogCell] in
                guard let image = image, let tableView = tableView, let blogCell = blogCell,
                let indexP      = tableView.indexPath(for: blogCell),
                let updatedBlogCell = tableView.cellForRow(at: indexP) as? BlogTableViewCell else {return}
                updatedBlogCell.mediaImage.image   = image
                updatedBlogCell.mediaImage.isHidden = false
                updatedBlogCell.updateConstraints()
            }
            })
        } else {
            blogCell.mediaImage.image       = nil
            blogCell.mediaImage.isHidden    = true
        }
        
        if let profileImageURL = cellViewModel.profileImageURL  {
            blogCell.mediaImage.isHidden = false
            blogCell.mediaImage.image   = ImageDownloader.showImageFromCache(profileImageURL, completionHandler: {[weak tableView , weak blogCell] (image) in
            DispatchQueue.main.async { [weak tableView , weak blogCell] in
                guard let image = image, let tableView = tableView, let blogCell = blogCell,
                let indexP      = tableView.indexPath(for: blogCell),
                let updatedBlogCell = tableView.cellForRow(at: indexP) as? BlogTableViewCell else {return}
                updatedBlogCell.profileImage.image = image
            }
            })
        } else {
            blogCell.profileImage.image       = nil
        }
        
        return blogCell
    }
}

extension BlogViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.numberOfRow() == indexPath.row + 1 {
            viewModel.loadMoreData()
        }
    }
}

extension BlogViewController : BlogViewControllerViewModelDelegate {
    func reloadBlogData() {
        DispatchQueue.main.async { [weak self] in
            self?.blogTable.reloadData()
        }
    }
    
    func showAlaert(_ message: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
