require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-secp256k1"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-secp256k1
                   DESC
  s.homepage     = "https://github.com/RicardoGuiliani/react-native-secp256k1"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "author" => "Yujun 'fingera' Liu" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/RicardoGuiliani/react-native-secp256k1.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "bitcoin-core-secp256k1"
  # ...
  # s.dependency "..."
end
