#
# Be sure to run `pod lib lint AnyBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnyBox'
  s.version          = '0.1.3'
  s.summary          = 'AnyBox is a iOS Base Project.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  基础工具包，做到一行命令，工程的基础框架就已经搭好了，开发者只需要些写UI即可
                       DESC

  s.homepage         = 'https://github.com/fcl3016/AnyBox'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fcl3016' => 'fcl3016@163.com' }
  s.source           = { :git => 'https://github.com/fcl3016/AnyBox.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AnyBox/Classes/**/*'
  
  s.resource_bundles = {
    'AnyBox' => ['AnyBox/Assets/*.png']
  }

  s.public_header_files = ['AnyBox/Classes/*.h', 'AnyBox/Classes/**/*.h', 'AnyBox/Classes/**/**/*.h']
  s.frameworks = 'UIKit'
end
