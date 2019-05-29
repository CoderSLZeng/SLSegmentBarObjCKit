#
# Be sure to run `pod lib lint SLSegmentBarObjCKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SLSegmentBarObjCKit'
  s.version          = '0.1.0'
  s.summary          = '选项卡控件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  选项卡控件框架
                       DESC

  s.homepage         = 'https://github.com/CoderSLZeng/SLSegmentBarObjCKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderSLZeng' => '359297567@qq.com' }
  s.source           = { :git => 'https://github.com/CoderSLZeng/SLSegmentBarObjCKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # 导入二进制文件和非二进制文件判断
  if ENV['IS_BINARY']
      
      s.source_files = 'SLSegmentBarObjCKit/Classes/**/*.h'
      s.public_header_files = 'SLSegmentBarObjCKit/Classes/**/*.h'
      
      if ENV['IS_LIB'] # Use demo: IS_BINARY=1 IS_LIB=1 pod install
          
          # 打包 【.a】 文件命令行
          # pod package SLSegmentBarObjCKit.podspec --library --exclude-deps --spec-sources='https://github.com/CoderSLZeng/SLSegmentBarObjCKit.git,https://github.com/CocoaPods/Specs.git'
          
          s.ios.vendored_libraries = 'SLSegmentBarObjCKit/Products/libSLSegmentBarObjCKit.a'
          
          else # Use demo: IS_BINARY=1 pod install
          
          # 打包 【.framework】 文件命令行
          # pod package SLSegmentBarObjCKit.podspec  --exclude-deps --spec-sources='https://github.com/CoderSLZeng/SLSegmentBarObjCKit.git,https://github.com/CocoaPods/Specs.git'
          
          s.ios.vendored_frameworks = 'SLSegmentBarObjCKit/Products/SLSegmentBarObjCKit.framework'
          
      end
      
      else # Use demo: pod install
      # 导入资源文件
      # s.source_files = 'SLSegmentBarObjCKit/Classes/**/*{.h,.m}'
      
      # 导入图片资源文件
      # s.resource_bundles = {
      #   'SLSegmentBarObjCKit' => ['SLSegmentBarObjCKit/Assets/*.png']
      # }
      
      # Subspec 子文件
      s.subspec 'Controller' do |controller|
          controller.source_files = 'SLSegmentBarObjCKit/Classes/Controller/*.{h,m}'
      end
      
      s.subspec 'View' do |view|
          view.source_files = 'SLSegmentBarObjCKit/Classes/View/*.{h,m}'
      end
      
      s.subspec 'Config' do |config|
          config.source_files = 'SLSegmentBarObjCKit/Classes/Config/*.{h,m}'
      end
      
      s.dependency 'SLCategoryObjCKit/View'
  end
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
