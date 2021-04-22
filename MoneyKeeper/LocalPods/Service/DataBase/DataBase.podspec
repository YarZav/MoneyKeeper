Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '12.0'
  s.name = "DataBase"
  s.summary = "DataBase service"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Raiffeisen" => "https://www.raiffeisen.ru" }
  s.homepage = "https://www.raiffeisen.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.source_files = "DataBase/**/*.swift"
end
