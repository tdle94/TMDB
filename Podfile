# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod "Cuckoo"
end

target 'TMDB' do
  use_frameworks!
  pod 'RealmSwift'
  # Pods for TMDB

  target 'TMDBTests' do
    inherit! :search_paths
    testing_pods
  end

end
