Pod::Spec.new do |s|
  s.name         = "RNTaboola"
  s.version      = "1.0.0"
  s.summary      = "RNTaboola"
  s.description  = <<-DESC
                  RNTaboola
                   DESC
  s.homepage     = "https://github.com/author/RNTaboola.git"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNTaboola.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true
  s.dependency "TaboolaSDK"
  # React can NOT be a dependency in this podspec, otherwise when adding it to the sample app it will bring an old react native version that will break the app.
  # Instead we rely on the app using this pod to be created with react-native init and already includes React that comes from npm (and not from cocoapods).
  s.dependency "React"
  #s.dependency "others"
  s.xcconfig =  {
                    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
                    'ENABLE_BITCODE' => 'YES',
                    'SWIFT_VERSION' => '5.0',
                    #'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}"/RNTaboola/**',
                    'OTHER_LDFLAGS' => '-ObjC -framework "TaboolaSDK"',
                    #'USER_HEADER_SEARCH_PATHS' => '"$(inherited)" "${PODS_ROOT}"/RNTaboola/**'
                }
end

