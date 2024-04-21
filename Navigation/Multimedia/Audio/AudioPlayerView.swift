//
//  View.swift
//  testMultiMeadia
//
//  Created by Руслан Усманов on 11.01.2024.
//

import UIKit
import AVFoundation



class MusicPlayerView: UIView {
    
    private var player: AVAudioPlayer!
    var trackList: [URL] = makeURLArray()
    var currentTrack: Int = 0  {
        didSet{
            setPlayer()
        }
    }
    
    //MARK: Subviews
    
    private lazy var trackNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 8)
        return lbl
    }()
    private lazy var pauseBtn: CustomButton = CustomButton(title: "", textColor: .black, backColor: .white){ [weak self] in
        self?.pauseBtnPressed()
    }
    private lazy var stopBtn: CustomButton = CustomButton(title: "", textColor: .black, backColor: .white){ [weak self] in
        self?.stopBtnPressed()
    }
    private lazy var  nextBtn: CustomButton = CustomButton(title: "", textColor: .black, backColor: .white){[weak self] in
        self?.slideBtnPressed(next: true)
    }
    private lazy var  previousBtn: CustomButton = CustomButton(title: "", textColor: .black, backColor: .white){[weak self] in
        self?.slideBtnPressed(next: false)
    }
    private lazy var backGround: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(slided), for: .valueChanged)
        return slider
    }()
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableViewCell()
        setConstraints()
        tuneView()
        setPlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private
    private func setPlayer(){
        do {
            player = try AVAudioPlayer(contentsOf: trackList[currentTrack])
            player.prepareToPlay()
            slider.maximumValue = Float(player.duration)
            trackNameLabel.text = String(trackList[currentTrack].lastPathComponent.dropLast(4))
        }
        catch {
            print("Weird mistake")
        }
    }
    
    private func setTableViewCell(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 44
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Interactive
    
    private func pauseBtnPressed(){
        switch player.isPlaying{
        case true:
            player.stop()
            pauseBtn.setImage(UIImage(named: "play"), for: .normal)
        case false:
            player.play()
            pauseBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    private func stopBtnPressed(){
        player.stop()
        player.currentTime = 0
        pauseBtn.setImage(UIImage(named: "play"), for: .normal)
    }
    private func slideBtnPressed(next: Bool){
        switch next{
        case true:
            if currentTrack + 1 == trackList.count {
                currentTrack = 0
            } else {
                currentTrack += 1
            }
        case false:
            if currentTrack == 0 {
                currentTrack = trackList.count - 1
            } else {
                currentTrack -= 1
            }
        }
        pauseBtnPressed()
        updateSlider()
    }
    @objc func slided(){
        player.stop()
        player.currentTime = TimeInterval(slider.value)
        player.play()
    }
    private func setConstraints(){
        [tableView, backGround, pauseBtn, stopBtn, nextBtn, slider, previousBtn, trackNameLabel].forEach({
            self.addSubview($0)
        })
            NSLayoutConstraint.activate([
                slider.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
                slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
                
                previousBtn.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
                previousBtn.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 8),
                previousBtn.heightAnchor.constraint(equalToConstant: 25),
                previousBtn.widthAnchor.constraint(equalToConstant: 25),
                
                pauseBtn.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
                pauseBtn.leadingAnchor.constraint(equalTo: previousBtn.trailingAnchor, constant: 8),
                pauseBtn.heightAnchor.constraint(equalToConstant: 25),
                pauseBtn.widthAnchor.constraint(equalToConstant: 25),
                
                nextBtn.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
                nextBtn.leadingAnchor.constraint(equalTo: pauseBtn.trailingAnchor, constant: 4),
                nextBtn.heightAnchor.constraint(equalToConstant: 25),
                nextBtn.widthAnchor.constraint(equalToConstant: 25),
            
                
                stopBtn.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
                stopBtn.leadingAnchor.constraint(equalTo: nextBtn.trailingAnchor, constant: 8),
                stopBtn.heightAnchor.constraint(equalToConstant: 20),
                stopBtn.widthAnchor.constraint(equalToConstant: 20),
            
                trackNameLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor, constant: 6),
                trackNameLabel.bottomAnchor.constraint(equalTo: slider.topAnchor,constant: -8),
            
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0),
                tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
                tableView.bottomAnchor.constraint(equalTo: trackNameLabel.topAnchor, constant: -12),
                
                backGround.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
                backGround.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: -8),
                backGround.topAnchor.constraint(equalTo: trackNameLabel.topAnchor, constant: -8),
                backGround.bottomAnchor.constraint(equalTo: pauseBtn.bottomAnchor, constant: 8)
            ])
        }
    
    private func tuneView(){
        pauseBtn.setImage(UIImage(named: "play"), for: .normal)
        nextBtn.setImage(UIImage(named: "next"), for: .normal)
        stopBtn.backgroundColor = .black
        previousBtn.setImage(UIImage(named: "previous"), for: .normal)
        
        [pauseBtn, nextBtn, previousBtn].forEach({
            $0.backgroundColor = .systemGray4
        })
        
        stopBtn.clipsToBounds = true
        stopBtn.layer.cornerRadius = 2.5
    }
    private func updateCurrentTrakc(pickedTrack: Int)  {
        let status = player.isPlaying
        currentTrack = pickedTrack
        updateSlider()
        if status {
            player.play()
        }
    }
    
    //MARK: internal
    internal func updateSlider(){
        self.slider.value = Float(player.currentTime)
    }
 
}

extension MusicPlayerView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCurrentTrakc(pickedTrack: indexPath.row)
    }
}
extension MusicPlayerView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        makeURLArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.detailTextLabel?.text = makeURLArray().map {
            String($0.lastPathComponent.dropLast(4))        }[indexPath.row]
        return cell
    }
    
    
}

