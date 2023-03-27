//
//  GamesTableViewCell.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit

public typealias VoidCompletion = () -> Void

public class GamesTableViewCell: UITableViewCell {
  
  @IBOutlet weak public var viewContainer: UIView!
  @IBOutlet weak public var gameImage: UIImageView!
  @IBOutlet weak public var titleLbl: UILabel!
  @IBOutlet weak public var descLbl: UILabel!
  @IBOutlet weak public var dateLbl: UILabel!
  @IBOutlet weak public var rateLbl: UILabel!
  @IBOutlet weak public var favoritBtn: UIButton!
  
  public var favoritTapped: VoidCompletion?
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    
    viewContainer.layer.masksToBounds = false
    viewContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17).cgColor
    viewContainer.layer.shadowOpacity = 1
    viewContainer.layer.shadowOffset = CGSize(width: 2, height: 4)
    viewContainer.layer.shadowRadius = 6
    viewContainer.layer.cornerRadius = 16
    gameImage.layer.cornerRadius = 16
    favoritBtn.setImage(Constants.Image.iconSelected, for: .normal)
  }
  
  @IBAction func favoritTapped(_ sender: Any) {
    favoritTapped?()
  }
}

