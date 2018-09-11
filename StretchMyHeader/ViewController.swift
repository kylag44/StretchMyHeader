//
//  ViewController.swift
//  StretchMyHeader
//
//  Created by Kyla  on 2018-09-11.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

struct NewsItem {
  let category: String
  let headline: String
  
  init(category: String, headline: String) {
    self.category = category
    self.headline = headline
  }
}

private let kTableHeaderHeight: CGFloat = 310


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
  
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tableViewOutlet: UITableView!
  
  var headerView: UIView!
  var newsItems = [NewsItem]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  
    headerView = tableViewOutlet.tableHeaderView
    tableViewOutlet.tableHeaderView = nil
    tableViewOutlet.addSubview(headerView)
    
    tableViewOutlet.contentInset = UIEdgeInsetsMake(kTableHeaderHeight, 0, 0, 0)
    tableViewOutlet.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
    updateHeaderView()
    
  ////date label
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy"
    let result = formatter.string(from: date)
    dateLabel.text = result
    
    
    self.newsItems.append(NewsItem(category: "World", headline: "Climate change protests, divestments meet fossil fuels realities"))
    self.newsItems.append(NewsItem(category: "Europe", headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"))
    self.newsItems.append(NewsItem(category: "Middle East", headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"))
    self.newsItems.append(NewsItem(category: "Africa", headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"))
    self.newsItems.append(NewsItem(category: "Asia Pacific", headline: "Despite UN ruling, Japan seeks backing for whale hunting"))
    self.newsItems.append(NewsItem(category: "Americas", headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"))
    self.newsItems.append(NewsItem(category: "World", headline: "South Africa in $40 billion deal for Russian nuclear reactors"))
    self.newsItems.append(NewsItem(category: "Europe", headline: "'One million babies' created by EU student exchanges"))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  //Mark: Header
  func updateHeaderView() {
    var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableViewOutlet.bounds.width, height: kTableHeaderHeight)
    if tableViewOutlet.contentOffset.y < -kTableHeaderHeight {
      headerRect.origin.y = tableViewOutlet.contentOffset.y
      headerRect.size.height = -tableViewOutlet.contentOffset.y
    }
    headerView.frame = headerRect
  }
  
  //Mark: ScrollView
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateHeaderView()
  }
  
  // MARK: Data Source
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.newsItems.count
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    tableView.estimatedRowHeight = UITableViewAutomaticDimension
    tableView.rowHeight = UITableViewAutomaticDimension
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
      fatalError("The dequeued cell is not an instance of TableViewCell.")
    }
    
    for index in indexPath {
      let category = self.newsItems[index].category
      let headline = self.newsItems[index].headline
      
      switch category {
      case "World":
        cell.categoryLabel.textColor = UIColor.red
      case "Americas":
        cell.categoryLabel.textColor = UIColor.blue
      case "Europe":
        cell.categoryLabel.textColor = UIColor.green
      case "Middle East":
        cell.categoryLabel.textColor = UIColor.yellow
      case "Africa":
        cell.categoryLabel.textColor = UIColor.orange
      case "Asia Pacific":
        cell.categoryLabel.textColor = UIColor.purple
      default:
        cell.categoryLabel.textColor = UIColor.black
      }
      
      cell.categoryLabel.text = category
      cell.headlineLabel.text = headline
    }
    
    
    
    return cell
  }
  
  
}
