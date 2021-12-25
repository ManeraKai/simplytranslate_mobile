#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opencv_4.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'opencv_4'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for accessing OpenCV modules.'
  s.description      = <<-DESC
  A flutter package project which contains a collection of OpenCV modules.
                       DESC
  s.homepage         = 'https://github.com/fgsoruco/opencv_4'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'fgsoruco' => 'fgsoruco@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'OpenCV2', '4.3.0'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
