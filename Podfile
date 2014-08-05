
workspace 'iMeal.xcworkspace'
xcodeproj 'iMeal.xcodeproj'

platform :ios, '7.0'

# 非UI第三方依赖
target 'iMealModel' do
    xcodeproj 'iMealModel/iMealModel.xcodeproj'
    pod 'AVOSCloud', '~> 2.5.8.1'
    pod 'ReactiveCocoa', '~> 2.3.1'
    pod 'FLEX', '~> 1.0.0'
end

# UI第三方依赖
target 'iMeal' do
    xcodeproj 'iMeal.xcodeproj'
    pod 'AVOSCloud', '~> 2.5.8.1'
    pod 'UIImageView-PlayGIF', '~> 1.0.1'
    pod 'pop', '~> 1.0.6'
    pod 'XXNibBridge', :git => 'https://github.com/sunnyxx/XXNibBridge.git'

end