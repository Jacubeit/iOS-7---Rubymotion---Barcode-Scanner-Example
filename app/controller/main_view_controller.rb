class MainViewController < UIViewController
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    setupCapture()
    true
  end
 
  def setupCapture
    @session = AVCaptureSession.alloc.init
    @session.sessionPreset = AVCaptureSessionPresetHigh
 
    @device = AVCaptureDevice.defaultDeviceWithMediaType AVMediaTypeVideo
    @error = Pointer.new('@')
    @input = AVCaptureDeviceInput.deviceInputWithDevice @device, error: @error

    @previewLayer = AVCaptureVideoPreviewLayer.alloc.initWithSession(@session)
    @previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    layerRect = self.view.layer.bounds
    @previewLayer.bounds = layerRect
    @previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(@previewLayer)

    @queue = Dispatch::Queue.new('camQueue')
    @output = AVCaptureMetadataOutput.alloc.init
    @output.setMetadataObjectsDelegate self, queue: @queue.dispatch_object

    @session.addInput @input
    @session.addOutput @output
    @output.metadataObjectTypes = [ AVMetadataObjectTypeQRCode ]
 
    @session.startRunning
    NSLog "session running: #{@session.running?}"
    true
  end
 
  def captureOutput(captureOutput, didOutputMetadataObjects: metadataObjects, fromConnection: connection)
    Dispatch::Queue.main.async do
      NSLog "#{metadataObjects[0].stringValue}"
      alert = UIAlertView.new
      alert.message = "#{metadataObjects[0].stringValue}"
      alert.show
      true
    end
  end
end