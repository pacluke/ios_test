//
//  ViewController.swift
//  ios_test
//
//  Created by Lucas Flores on 17/02/19.
//  Copyright © 2019 lucas.flores. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // let service = Service()
    
    // MARK: - layout variables
    
    // image
    @IBOutlet weak var imageView: UIImageView!
    
    // views
    @IBOutlet weak var connectionView: UIView!
    @IBOutlet weak var switchView: UIView!
    
    // controll
    // connection controll
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var connectionSwitch: UISwitch!
    
    // dimmer controll
    @IBOutlet weak var dimmerLabel: UILabel!
    @IBOutlet weak var dimmerCountLabel: UILabel!
    @IBOutlet weak var dimmerSlider: UISlider!
    
    
    // MARK: - UIView default load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = "Beyond"
        
        setImageView(imageView: imageView)
        
        setView(view: self.connectionView)
        setView(view: self.switchView)
        
        setLabel(label: self.connectionLabel)
        setLabel(label: self.dimmerLabel)
        setLabel(label: self.dimmerCountLabel)
        
        setSwitchText(switchA: self.connectionSwitch, switchLabel: self.connectionLabel, onText: "Connected", offText: "Disconnected")
        
        setSlider(slider: self.dimmerSlider)
        
        // se a conexao com o mqtt tivesse ok, aqui seria colocado o valor atual no dimmer no subscribe
    }
    
    // MARK: - layout customization
    private func setView(view: UIView){
        view.layer.cornerRadius = 10
        view.layer.backgroundColor = UIColor.darkGray.cgColor
    }
    
    private func setLabel(label: UILabel){
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    private func setSlider(slider: UISlider){
        slider.maximumValue = 100.0
        slider.minimumValue = 0.0
    }
    
    private func setSwitchText(switchA: UISwitch, switchLabel: UILabel, onText: String, offText: String){
        if switchA.isOn {
            switchLabel.text = onText
        }
        else {
            switchLabel.text = offText
        }
    }
    
    private func setImageView(imageView: UIImageView){
        if self.dimmerSlider.value < 50.0 {
            imageView.image = UIImage(named: "off.png")
        }
        else {
            imageView.image = UIImage(named: "on.png")
        }
    }
    
    // MARK - connection switch update
    // function trigger when connection switch is updated
    @IBAction func connectionSwitchUpdate(_ sender: UISwitch) {
        // se a conexao com o mqtt tivesse ok, aqui seria feita a conexao caso ela não estivesse up ainda
        setSwitchText(switchA: sender, switchLabel: connectionLabel, onText: "Connected", offText: "Disconnected")
        if !self.connectionSwitch.isOn {
            dimmerSlider.isEnabled = false
        }
        else {
            dimmerSlider.isEnabled = true
        }
        // else show alert
    }
    
    
    // MARK - dimmer slider update
    // function trigger when dimmer slider is updated
    @IBAction func dimmerSwitchUpdate(_ sender: UISlider) {
        // aqui seria o publish pra alterar o valor, e caso algo tivesse dado errado ele manteria o valor encontrado na ultima mensagem do subscribe
        self.dimmerCountLabel.text = "\(Int(sender.value))"
        setImageView(imageView: self.imageView)
    }
    
}

