Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '12.0'
  s.name = "Extension"
  s.summary = "Extension module"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Author" => "https://www.author.ru" }
  s.homepage = "https://www.author.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.source_files = "Extension/**/*.swift"
end