# Uncomment the next line to define a global platform for your project
platform :ios, '14.5'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod "Cuckoo"
  pod 'RealmSwift'
  pod 'SDWebImage'
end

target 'TMDB' do
  use_frameworks!
  pod 'RealmSwift'
  pod 'SDWebImage'
  pod 'Cosmos'
  pod 'Swinject'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'RxSwiftUtilities'
  pod 'RxDataSources'
  pod 'RxOptional'
  pod 'NotificationBannerSwift'
  pod 'SkeletonView'

  target 'TMDBTests' do
    inherit! :search_paths
    testing_pods
  end

end
