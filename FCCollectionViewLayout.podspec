#
# Be sure to run `pod lib lint FCCollectionViewLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FCCollectionViewLayout'
  s.version          = '0.0.1'
  s.summary          = 'A short description of FCCollectionViewLayout.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/2585299617@qq.com/FCCollectionViewLayout'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '2585299617@qq.com' => '617@qq.com' }
  s.source           = { :git => 'https://github.com/2585299617@qq.com/FCCollectionViewLayout.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  

#  s.public_header_files = 'FCCollectionViewLayout/Classes/**/*.h'
  
#  s.default_subspec = 'ObjC'
  
  s.ios.deployment_target = '9.0'
  s.subspec 'ObjC' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'FCCollectionViewLayout/Classes/**/*.{h,m}'
  end
  
  s.swift_version = '4.0'
  s.subspec 'Swift' do |ss|
    ss.ios.deployment_target = '9.0'
    ss.source_files = 'FCCollectionViewLayout/Classes/**/*.swift'
  end
  
end
