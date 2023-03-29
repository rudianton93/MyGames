//
//  Video.swift
//  MyGames
//
//  Created by Rudi Anton on 09/03/23.
//

import UIKit
import AVKit

public class Video: UIView {
  
  var pauseBtn = UIButton()
  var durationSlider = UISlider()
  var viewSlider = UIView()
  var durationLbl = UILabel()
  var emptyLbl = UILabel()
  
  var activityIndicator = UIActivityIndicatorView(style: .medium)
  var player: AVPlayer?
  
  var durationVideo = ""
  var isDuration: Float = 0
  
  public var clip: String? {
    didSet {
      if clip == nil {
        configEmpty()
      } else {
        configPlayVideo()
      }
    }
  }
  
  private func configEmpty() {
    self.addSubview(emptyLbl)
    
    emptyLbl.translatesAutoresizingMaskIntoConstraints = false
    emptyLbl.text = "Clip Tidak Tersedia"
    emptyLbl.textColor = .white
    
    NSLayoutConstraint.activate([
      emptyLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
      emptyLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
    ])
  }
  
  private func configPlayVideo() {
    if let url = URL(string: clip ?? "") {
      let player = AVPlayer(url: url)
      let playerLayer = AVPlayerLayer(player: player)
      playerLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
      playerLayer.videoGravity = .resizeAspect
      self.layer.addSublayer(playerLayer)
      self.player = player
      self.player?.isMuted = false
      self.isDuration = 0
      self.player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                             name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
      
      let interval = CMTime(value: 1, timescale: 2)
      self.player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
        
        let duration = self.getHoursMinutesSecondsFrom(seconds: CMTimeGetSeconds(progressTime))
        let stringDuration = String(format: "%0d:%02d", duration.minutes, duration.seconds)
        let returnString = self.durationVideo.replacingOccurrences(of: "--", with: stringDuration)
        
        self.durationLbl.text = returnString
        
        if let duration = self.player?.currentItem?.duration {
          let durationSeconds = CMTimeGetSeconds(duration)
          self.durationSlider.value = Float(CMTimeGetSeconds(progressTime) / durationSeconds)
        }
      })
      
      addViews()
    }
  }
  
  func handleSliderChange(value: Float?) {
    if let duration = player?.currentItem?.duration, duration.value > 0, value != nil {
      let totalSeconds = CMTimeGetSeconds(duration)
      let value = Float64(value ?? 0) * totalSeconds
      let seekTime = CMTime(value: Int64(value), timescale: 1)
      player?.seek(to: seekTime, completionHandler: { _ in
        
      })
    }
  }
  
  func getHoursMinutesSecondsFrom(seconds: Double) -> (minutes: Int, seconds: Int) {
    let secs = Int(seconds)
    let minutes = (secs % 3600) / 60
    let seconds = (secs % 3600) % 60
    return (minutes, seconds)
  }
  
  public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    
    if keyPath == "currentItem.loadedTimeRanges" {
      activityIndicator.removeFromSuperview()
      pauseBtn.isHidden = false
      durationLbl.isHidden = false
      
      if let duration =
          player?.currentItem?.duration {
        let seconds = CMTimeGetSeconds(duration)
        
        if !seconds.isNaN {
          let secondsText = Int(seconds) % 60
          let minutesText = String(format: "%02d", Int(seconds) / 60)
          durationVideo = "-- / \(minutesText):\(secondsText)"
          if isDuration == 0 {
            durationLbl.text = "0:00 / \(minutesText):\(secondsText)"
            isDuration = 1
          }
        }
      }
    }
  }
  
  @objc func playerDidFinishPlaying(note: NSNotification) {
    handleSliderChange(value: 0)
    pauseBtn.setImage(UIImage(named: "play"), for: .normal)
    player?.pause()
  }
  
  func addViews() {
    self.addSubview(viewSlider)
    self.addSubview(durationSlider)
    self.addSubview(durationLbl)
    self.addSubview(pauseBtn)
    self.addSubview(activityIndicator)
    
    viewSlider.backgroundColor = .black
    viewSlider.layer.opacity = 0.3
    viewSlider.translatesAutoresizingMaskIntoConstraints = false
    
    durationSlider.value = 0
    durationSlider.maximumTrackTintColor = .gray
    durationSlider.minimumTrackTintColor = .white
    durationSlider.addTarget(self, action: #selector(self.didChangeSlider), for: .valueChanged)
    durationSlider.translatesAutoresizingMaskIntoConstraints = false
    
    durationLbl.isHidden = true
    durationLbl.textColor = .white
    durationLbl.font = .boldFont(withSize: 12)
    durationLbl.translatesAutoresizingMaskIntoConstraints = false
    
    pauseBtn.setImage(UIImage(named: "play")
                      , for: .normal)
    pauseBtn.setTitle("", for: .normal)
    pauseBtn.setTitleColor(.clear, for: .normal)
    pauseBtn.isHidden = true
    pauseBtn.addTarget(self, action: #selector(self.didTappedPlayVideo), for: .touchUpInside)
    pauseBtn.translatesAutoresizingMaskIntoConstraints = false
    
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.color = .white
    
    NSLayoutConstraint.activate([
      viewSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
      viewSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
      viewSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
    ])
    
    NSLayoutConstraint.activate([
      pauseBtn.topAnchor.constraint(equalTo: viewSlider.topAnchor, constant: 8),
      pauseBtn.leadingAnchor.constraint(equalTo: viewSlider.leadingAnchor, constant: 16),
      pauseBtn.bottomAnchor.constraint(equalTo: viewSlider.bottomAnchor, constant: -8),
      pauseBtn.heightAnchor.constraint(equalToConstant: 24),
      pauseBtn.widthAnchor.constraint(equalToConstant: 24)
    ])
    
    NSLayoutConstraint.activate([
      durationLbl.leadingAnchor.constraint(equalTo: pauseBtn.trailingAnchor, constant: 16),
      durationLbl.centerYAnchor.constraint(equalTo: pauseBtn.centerYAnchor, constant: 0),
    ])
    
    NSLayoutConstraint.activate([
      durationSlider.leadingAnchor.constraint(equalTo: durationLbl.trailingAnchor, constant: 16),
      durationSlider.trailingAnchor.constraint(equalTo: viewSlider.trailingAnchor, constant: -16),
      durationSlider.bottomAnchor.constraint(equalTo: viewSlider.bottomAnchor, constant: -8)
    ])
    
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
      activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
      activityIndicator.heightAnchor.constraint(equalToConstant: 32),
      activityIndicator.widthAnchor.constraint(equalToConstant: 32)
    ])
    
  }
  
  func removeVideo(isRemoveVideo: Bool) {
    if isRemoveVideo == true {
      self.player?.pause()
    }
  }
  
  @objc func didChangeSlider() {
    handleSliderChange(value: durationSlider.value)
  }
  
  @objc func didTappedPlayVideo() {
    let status = self.player?.timeControlStatus == .playing
    pauseVideo(isPlaying: !status)
  }
  
  public func pauseVideo(isPlaying: Bool) {
    if !isPlaying {
      pauseBtn.setImage(UIImage(named: "play"), for: .normal)
      self.player?.pause()
    } else {
      pauseBtn.setImage(UIImage(named: "pause"), for: .normal)
      self.player?.play()
    }
  }
}

