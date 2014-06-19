//
//  CaptureVideoPreviewView.h
//  Sauron
//
//  Created by Mark Stultz on 6/18/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import UIKit;

@class AVCaptureSession;
@class AVCaptureVideoPreviewLayer;

@interface CaptureVideoPreviewView : UIView

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *previewLayer;

@end
