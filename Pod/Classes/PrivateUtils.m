//
//  PrivateUtils.m
//
//  Copyright (c) 2015 Andrey Fidrya
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "PrivateUtils.h"

static NSMutableArray * watchedPath;

@implementation PrivateUtils

+ (BOOL)debug { //This is first thing called from UITestServer, so use it as an init
    #ifdef DEBUG
        return YES;
    #else
        return NO;
    #endif
}

#ifdef DEBUG
UIImage *_UICreateScreenUIImage();
#endif

+ (void)setWatchedProjectPath:(NSMutableArray *)path {
    watchedPath = path;
}

+ (NSMutableArray *)watchedProjectPath {
    return watchedPath;
}

+ (UIImage *)takeScreenshot {
    #ifdef DEBUG
        return _UICreateScreenUIImage();
    #else
        return nil;
    #endif
}

// http://stackoverflow.com/questions/12650137/how-to-change-the-device-orientation-programmatically-in-ios-6
+ (void)forceOrientation:(int)orientation {
    #ifdef DEBUG
        NSNumber *value = [NSNumber numberWithInt:orientation];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    #endif
}

+ (UIView *)topLevelApplicationView {
    return [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
}

+ (UIImage *)topLevelSnapshot {
    return [self snapshotFromView:[self topLevelApplicationView]];
}

+ (UIImage *)largestAppIcon {

    //This successfully finds app icon images in asset catalog
    NSArray * files = [NSBundle mainBundle].infoDictionary[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    __block CGFloat max = 0;
    __block UIImage * largest;
    [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        UIImage * img = [UIImage imageNamed:obj];
        if (img.size.width > max) {
            max = img.size.width;
            largest = img;
        }
    }];
    return largest;
}

+ (UIImage *)snapshotFromView:(UIView *)view {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (void)registerWatchedPathsListener {

    [[NSNotificationCenter defaultCenter] addObserverForName:@"jalapenoAddWatchedPath" object:nil queue:nil usingBlock:^(NSNotification * note) {

        NSLog(@"Adding watched path in %s, path: %@", __PRETTY_FUNCTION__, note.userInfo[@"jalapenoWatchedPath"]);
        [self setWatchedProjectPath:note.userInfo[@"jalapenoWatchedPath"]];
    }];
}


@end
