
# Awesome Toggle Switch
## Usage

### installation
```ruby
use_frameworks!
target 'Target-Name' do
  pod 'NCOTPView'
end
```

### Storyboard
![Storyboard setup](/assets/Screenshot1.png?raw=true "Storyboard")

### ViewController
```swift
@IBOutlet weak var otpView1: NCOTPView!
override func viewDidLoad() {
    super.viewDidLoad()
    
    otpView1.configureView(focus: UIColor.blue.cgColor,
                          normal: UIColor.lightGray.cgColor,
                          backgroundColor: .blue.withAlphaComponent(0.1),
                          otpCount: 4,
                          secure: false)
    otpView1.getOtp = { otp, valid in
        print(otp, valid)
        self.submitButton.isHidden = !valid
    }
}
```
### getOtp Closure always called when text entered.

### Result
![Storyboard setup](/assets/Screenshot2.png?raw=true "Simulator")
