Pod::Spec.new do |spec|
  spec.name         = "UIOutlineView"
  spec.version      = "1.0.0"
  spec.summary      = "OutlineView for iOS"
  spec.description  = "UIOutlineView is an iOS analogue for NSOutlineView class available for macOS"
  spec.homepage     = "https://github.com/VihlayewAlex/UIOutlineView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Alex Vihlayew" => "vihlayew.alex@gmail.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/VihlayewAlex/UIOutlineView.git", :tag => "#{spec.version}" }
  spec.source_files = "UIOutlineView/Sources/**/*.{h,m}"
end
