Pod::Spec.new do |spec|

  spec.name         = "NCOTPView"
  spec.version      = "1.0.0"
  spec.summary      = "Awesome otp input fields"
  spec.description  = "You can include in your project."
  spec.homepage     = "https://github.com/shanmugam105/OTPView-Example"
  spec.license      = { :type => "MIT", :file => "LICENSE.txt" }

  spec.author             = { "Shanmugarajeshwaran R" => "shanmugarajeshwaran@sparkouttech.com" }
  spec.social_media_url   = "https://www.instagram.com/sharveshwaran.r"

  spec.platform     = :ios, "12.0"

  spec.source       = { :git => "https://github.com/shanmugam105/OTPView-Example.git", :tag => spec.version.to_s }

  spec.source_files  = "NCOTPView/**/*.{swift}"
  spec.swift_versions = "5.0"
  
end
