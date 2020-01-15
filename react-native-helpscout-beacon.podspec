require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-helpscout-beacon"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-helpscout-beacon
                   DESC
  s.homepage     = "https://github.com/Driversnote-Dev/react-native-helpscout-beacon"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Driversnote.com" => "ja@driversnote.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/Driversnote-Dev/react-native-helpscout-beacon.git", :tag => "master" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  # ...
  # s.dependency "..."
end
