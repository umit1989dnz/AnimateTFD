1.change your textField class to AnimatedTFD

2.import AnimateTFD in current ViewController

3.create outlet for textfields

4.set this config

self.yourTextField.titleTextColor = UIColor.red.withAlphaComponent(0.5) 
self.yourTextField.addBottomLine(lineColor: UIColor.brown) //optional
