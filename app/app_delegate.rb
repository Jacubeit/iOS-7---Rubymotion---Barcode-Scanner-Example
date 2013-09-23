class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @main_view_controller = MainViewController.alloc.initWithNibName(nil, bundle: nil)
    @window.rootViewController = @main_view_controller
    true
  end
end
