//
//  SliderScreen
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

class SliderScreenViewController: UIViewController, SliderScreenViewProtocol {

    var presenter: SliderScreenPresenterProtocol?
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var radiusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        radiusLabel.text = "\(Int(slider.value))"
    }
    
}
