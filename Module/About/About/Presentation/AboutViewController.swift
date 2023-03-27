//
//  AboutViewController.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import Core

public class AboutViewController: UIViewController {
  
  @IBOutlet weak var profileImg: UIImageView!
  @IBOutlet weak var fullnameLbl: UILabel!
  @IBOutlet weak var dateOfBirthLbl: UILabel!
  @IBOutlet weak var statusLbl: UILabel!
  @IBOutlet weak var genderLbl: UILabel!
  @IBOutlet weak var addressLbl: UILabel!
  
  public init() {
    super.init(nibName: String(describing: AboutViewController.self), bundle: Bundle(identifier: "com.dicoding.academy.About"))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    setDefaultNavigationTheme()
    configureNavigationBar()
    setContent()
  }
  
  private func setDefaultNavigationTheme() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor  = .white
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
  }
  
  private func configureNavigationBar() {
    let titleLabel = UILabel()
    titleLabel.font = .boldFont(withSize: 14)
    titleLabel.text = "About"
    titleLabel.textColor = .black
    
    navigationItem.titleView = titleLabel
  }
  
  private func setContent() {
    profileImg.image = UIImage(named: "PhotoProfile")
    fullnameLbl.text = "Rudi Anton"
    dateOfBirthLbl.text = "27-Juni-1993"
    statusLbl.text = "Menikah"
    genderLbl.text = "Laki - laki"
    addressLbl.text = "Desa Karangkerta RT.03 RW.02 Kec. Tukdana Kab. Indramayu Jawa Barat"
  }
  
  @objc func leftNavigationBarButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
}
