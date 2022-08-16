Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '13.0'
  s.name = "DI"
  s.summary = "DI module"
  s.requires_arc = true
  s.version = "1.0.0"
  s.author = { "Author" => "https://www.author.ru" }
  s.homepage = "https://www.author.ru"
  s.source = { :git => "", :tag => "#{s.version}"}
  s.dependency 'Swinject'
  s.source_files = "DI/**/*.swift"
end