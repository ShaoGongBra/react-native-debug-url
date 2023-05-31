require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-debug-url"
  s.version      = package["version"]
  s.summary      = package["description"]
  
  s.authors      = package['author']
  s.homepage     = package['homepage']

  s.license      = "MIT"

  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/ShaoGongBra/react-native-debug-url.git", :tag => "#{s.version}" }

  s.source_files    = 'ios/*.{h,m}'

  s.dependency 'React-Core'
end

