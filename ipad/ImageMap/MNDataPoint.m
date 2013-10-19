//
//  MNDataPoint.m
//  ImageMap
//
//  Created by Moo on 8/11/13.
//  Copyright (c) 2013 micmoo. All rights reserved.
//

#import "MNDataPoint.h"

@implementation MNDataPoint 

- (id) initWithPointNumber:(int)pn data:(NSDictionary *)_data sampleId:(int)sid subsampleId:(int)ssid{
    self = [super init];
    
    pointNumber = pn;
    data = _data;
    sampleId = sid;
    subsampleId = ssid;
    
    return self;
}


@end
