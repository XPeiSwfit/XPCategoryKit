#
# Be sure to run `pod lib lint XPCategoryKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XPCategoryKit'
  s.version          = '0.2'
  s.summary          = 'A short description of XPCategoryKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?

  s.description      = <<-DESC
TODO:这个描述用于生成标签和改进搜索结果。
     思考:它是做什么的?你为什么要写它?重点是什么? ---
                       DESC
  ###组件首页地址，放个组件库路径即可
  s.homepage         = 'https://github.com/XPeiSwfit/XPCategoryKit'
  
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '18682249915@163.com' => '13762399515@163.com' }
  
  ###组件库远程路径
  s.source           = { :git => 'https://github.com/XPeiSwfit/XPCategoryKit', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  ###指定最低的ios版本
  s.ios.deployment_target = '10.0'

  ###所有的文件路径。建议不要修改
  s.source_files = 'XPCategoryKit/Classes/**/*'
  
  ##组件中资源bunlde路径
  # s.resource_bundles = {
  #   'XPCategoryKit' => ['XPCategoryKit/Assets/*.png']
  # }

  # 公共的头文件，按需设置
  # s.public_header_files = 'Pod/Classes/**/*.h'。#

  ##依赖的系统Framework，按需设置
  # s.frameworks = 'UIKit', 'MapKit'。
 
 ##依赖其他的pod库，按需设置
  # s.dependency 'AFNetworking', '~> 2.3'。
end
