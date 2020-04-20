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
  s.summary          = '这是一个摘要'
  ###指定最低的ios版本
   s.ios.deployment_target = '10.0'
   #制定的最低swift版本
   s.swift_version = '4.0'


  s.description      = <<-DESC
  长描述
TODO:这个描述用于生成标签和改进搜索结果。
     思考:它是做什么的?你为什么要写它?重点是什么? ---
                       DESC
  ###组件首页地址，放个组件库路径即可
  s.homepage         = 'https://github.com/XPeiSwfit/XPCategoryKit'
  
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xp' => '13762399515@163.com' }
  
  ###组件库远程路径
  s.source           = { :git => 'https://github.com/XPeiSwfit/XPCategoryKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

 
  ###所有的文件路径。建议不要修改
  s.source_files = 'XPCategoryKit/Classes/**/*'
  #   下载HycProject文件夹下名称为AppManInfo和AppWomanInfo的共4项文件
  #   s.source_files ='HycProject/App{Man,Woman}Info.{h,m}'
  #   目标路径下的文件不进行下载
  #   s.ios.exclude_files = 'AppInfo/Info/json'
  
  
  ##组件中资源bunlde路径
  # s.resource_bundles = {
  #   'XPCategoryKit' => ['XPCategoryKit/Assets/*.png']
  # }

  # 公共的头文件，按需设置
#   s.public_header_files = 'XPCategoryKit/Classes/**/*' #

  ##依赖的系统Framework，按需设置
  # s.frameworks = 'UIKit', 'MapKit'。
 
 ##依赖其他的pod库，按需设置，可多个
  # s.dependency 'AFNetworking', '~> 2.3'。
   # s.dependency 'AFNetworking'
   

   
   
   # 要是文件有分层 就这样写
    s.subspec 'PublicClass' do |ss|
        ss.source_files = 'XPCategoryKit/Classes/PublicClass/*.{swift}'
    end
end
