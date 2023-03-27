//
//  GamesTableViewCell.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

typealias VoidCompletion = () -> Void

class GamesTableViewCell: UITableViewCell {
  
  @IBOutlet weak var viewContainer: UIView!
  @IBOutlet weak var gameImage: UIImageView!
  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var descLbl: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var rateLbl: UILabel!
  @IBOutlet weak var favoritBtn: UIButton!
  
  var favoritTapped: VoidCompletion?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    viewContainer.layer.masksToBounds = false
    viewContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17).cgColor
    viewContainer.layer.shadowOpacity = 1
    viewContainer.layer.shadowOffset = CGSize(width: 2, height: 4)
    viewContainer.layer.shadowRadius = 6
    viewContainer.layer.cornerRadius = 16
    gameImage.layer.cornerRadius = 16
  }
  
  @IBAction func favoritTapped(_ sender: Any) {
    favoritTapped?()
  }
}

