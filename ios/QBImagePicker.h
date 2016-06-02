//
//  QBImagePicker.h
//  RNQBImagePicker
//
//  Created by Jon Long on 5/31/16.

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import <QBImagePickerController.h>

@interface QBImagePicker : NSObject<
RCTBridgeModule,
QBImagePickerControllerDelegate>

@property (nonatomic, strong) NSDictionary *defaultOptions;
@property (nonatomic, retain) NSMutableDictionary *options;
@property (nonatomic, strong) RCTPromiseResolveBlock resolve;
@property (nonatomic, strong) RCTPromiseRejectBlock reject;

@end
