#
#  Be sure to run `pod spec lint Fractal.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "Fractal"
  s.version      = "0.0.1"
  s.summary      = "Atomic Design Theory for iOS made easy"
  s.description  = <<-DESC
Rapid Prototyping • Quick Rebranding • Reusable UI • Minimum Code
                   DESC

  s.homepage     = "https://github.com/kouzoh/fractal" #"https://github.com/mercari/fractal"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = ['Mercari, Inc.']
  s.source           = { :git => 'git@github.com:kouzoh/fractal.git', :tag => s.version.to_s } #https://github.com/mercari/Fractal.git

  s.ios.deployment_target = '9.0'

  s.source_files = 'DesignSystem/Sources/**/*.{swift,h,plist}'
  s.resources = 'DesignSystem/Resources/Images.xcassets/**/*.{png,jpeg,jpg,pdf,json,storyboard,xib,xcassets}'

  s.frameworks = 'UIKit'

  s.cocoapods_version = '>= 1.4.0'
  s.swift_version = '4.2'

end












  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

#  s.source_files  = "Classes", "Classes/**/*.{h,m}"
#  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"