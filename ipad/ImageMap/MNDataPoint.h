//
//  MNDataPoint.h
//  ImageMap
//
//  Created by Moo on 8/11/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNDataPoint : NSObject {
    int pointNumber;
    int sampleId;
    int subsampleId;
    NSDictionary *data;
    NSString *checksum;

}

- (id) initWithPointNumber:(int)pn data:(NSDictionary *)data sampleId:(int)sid subsampleId:(int)ssid;


@end
