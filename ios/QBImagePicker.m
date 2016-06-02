#import "QBImagePicker.h"

@implementation QBImagePicker

RCT_EXPORT_MODULE();

- (instancetype)init
{
  if (self = [super init]) {

      self.defaultOptions = @{
        @"animated": @YES,
        @"allowsMultipleSelection": @NO,
        @"minimumNumberOfSelection": @0,
        @"maximumNumberOfSelection": @0,
        @"assetCollectionSubtypes": @[
          @"cameraRoll",
          @"photoStream",
          @"panoramas",
          @"videos",
          @"bursts"
        ],
        @"mediaType": @"any",
        @"showsNumberOfSelectedAssets": @YES,
        @"numberOfColumnsInPortrait": @4,
        @"numberOfColumnsInLandscape": @7
      };
  }

  return self;
}

RCT_EXPORT_METHOD(openPicker:(NSDictionary *)options
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject
) {

  self.resolve = resolve;
  self.reject = reject;
  self.options = [NSMutableDictionary dictionaryWithDictionary:self.defaultOptions];

  for (NSString *key in options.keyEnumerator) {
      [self.options setValue:options[key] forKey:key];
  }

  // Convert assetCollectionSubtypes array values to corresponding subtypes
  if ([self.options objectForKey:@"assetCollectionSubtypes"]) {

    NSMutableArray *types = [NSMutableArray arrayWithArray:
      [self.options objectForKey:@"assetCollectionSubtypes"]];

    NSMutableArray *subtypes = [[NSMutableArray alloc] init];

    for (NSString __strong *type in types) {

      // Obj-C's `switch` doesn't support string cases ¯\_(ツ)_/¯
      if ([type isEqualToString:@"cameraRoll"]) {
        [subtypes addObject:@(PHAssetCollectionSubtypeSmartAlbumUserLibrary)];
      }

      else if ([type isEqualToString:@"photoStream"]) {
        [subtypes addObject:@(PHAssetCollectionSubtypeAlbumMyPhotoStream)];
      }

      else if ([type isEqualToString:@"panoramas"]) {
        [subtypes addObject:@(PHAssetCollectionSubtypeSmartAlbumPanoramas)];
      }

      else if ([type isEqualToString:@"videos"]) {
        [subtypes addObject:@(PHAssetCollectionSubtypeSmartAlbumVideos)];
      }

      else if ([type isEqualToString:@"bursts"]) {
        [subtypes addObject:@(PHAssetCollectionSubtypeSmartAlbumBursts)];
      }
    }

    [self.options setValue:subtypes forKey:@"assetCollectionSubtypes"];
  }

  // Convert mediaType value to corresponding subtype
  NSString *mediaType =[self.options objectForKey:@"mediaType"];

  if (mediaType) {
      if ([mediaType isEqualToString:@"any"]) {
        [self.options setValue:@(QBImagePickerMediaTypeAny) forKey:@"mediaType"];
      }

      if ([mediaType isEqualToString:@"video"]) {
        [self.options setValue:@(QBImagePickerMediaTypeVideo) forKey:@"mediaType"];
      }

      if ([mediaType isEqualToString:@"image"]) {
        [self.options setValue:@(QBImagePickerMediaTypeImage) forKey:@"mediaType"];
      }
  }


  [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    dispatch_async(dispatch_get_main_queue(), ^{

      QBImagePickerController *imagePickerController =
        [QBImagePickerController new];

      imagePickerController.delegate = self;

      @"animated": @YES,
      @"allowsMultipleSelection": @NO,
      @"minimumNumberOfSelection": @0,
      @"maximumNumberOfSelection": @0,
      @"assetCollectionSubtypes": @[
        @"cameraRoll",
        @"photoStream",
        @"panoramas",
        @"videos",
        @"bursts"
      ],
      @"mediaType": @"any",
      @"showsNumberOfSelectedAssets": @YES,
      @"numberOfColumnsInPortrait": @4,
      @"numberOfColumnsInLandscape": @7

      imagePickerController.allowsMultipleSelection =
        [[self.options objectForKey:@"allowsMultipleSelection"] boolValue];

      imagePickerController.minimumNumberOfSelection =
        [[self.options objectForKey:@"minimumNumberOfSelection"] intValue];

      imagePickerController.maximumNumberOfSelection =
        [[self.options objectForKey:@"maximumNumberOfSelection"] intValue];

      imagePickerController.assetCollectionSubtypes =
        [self.options objectForKey:@"assetCollectionSubtypes"];

      imagePickerController.mediaType =
        [self.options objectForKey:@"mediaType"];

      imagePickerController.prompt =
          [self.options objectForKey:@"prompt"];

      imagePickerController.showsNumberOfSelectedAssets =
          [[self.options objectForKey:@"showsNumberOfSelectedAssets"] boolValue];

      imagePickerController.numberOfColumnsInPortrait =
          [[self.options objectForKey:@"numberOfColumnsInPortrait"] intValue];

      imagePickerController.numberOfColumnsInLandscape =
        [[self.options objectForKey:@"numberOfColumnsInLandscape"] intValue];

      UIViewController *root =
        [[[[UIApplication sharedApplication] delegate] window] rootViewController];

      [root presentViewController:imagePickerController
            animated:[[self.options objectForKey:@"animated"] boolValue]
            completion:NULL];
    });
  }];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
