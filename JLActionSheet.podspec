Pod::Spec.new do |s|
  s.name     = 'JLActionSheet'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'An easy to use and customize replacement to the stock UIActionSheet.'
  s.homepage = 'https://github.com/bfcrampton/JLActionSheet'
  s.author  = { 'Jason Loewy' => 'JasonLoewy@gmail.com' }
  s.source   = { :git => 'https://github.com/bfcrampton/JLActionSheet.git', :tag => 'v1.0.1' }
  s.source_files = 'JLActionSheet' '/Sources/*.{h,m}'
  s.requires_arc = true
  s.platform = :ios
  s.ios.deployment_target = '5.1'
  s.ios.framework = 'QuartzCore'
end
