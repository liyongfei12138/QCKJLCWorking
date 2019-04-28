#
# Be sure to run `pod lib lint QCKJLCWorking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QCKJLCWorking'
  s.version          = '1.1.2'
  s.summary          = 'just a demo'

  
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/liyongfei12138/QCKJLCWorking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyongfei12138' => 'miap972712779@qq.com' }
  s.source           = { :git => 'https://github.com/liyongfei12138/QCKJLCWorking.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'QCKJLCWorking/Classes/**/*'
  s.resources =  'QCKJLCWorking/QCKJBundle.bundle'
    
  s.dependency 'WebViewJavascriptBridge'
  s.dependency 'AVOSCloud'
  #, '~>11.5.2'
  
  
end
