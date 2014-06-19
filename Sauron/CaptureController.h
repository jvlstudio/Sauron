//
//  CaptureController.h
//  Sauron
//
//  Created by Mark Stultz on 6/18/14.
//  Copyright (c) 2014 Mark Stultz. All rights reserved.
//

@import Foundation;

@class AVCaptureSession;
@class CaptureVideoPreviewView;

@interface CaptureController : NSObject

- (id)initWithCaptureSession:(AVCaptureSession *)captureSession captureVideoPreviewView:(CaptureVideoPreviewView *)captureVideoPreviewView;

- (void)startCapture;

@end
