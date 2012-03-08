//
//  rsMemoryHandler.h
//  rsSystemMemory
//
//  Created by Radif Sharafullin on 3/7/12.
//  Copyright (c) 2012 Radif Sharafullin. All rights reserved.
//
// Released under MIT License

#import <Foundation/Foundation.h>
//RAM
natural_t getFreeMemory();
void freeMemory(natural_t freemem);
natural_t freeUnusedMemory();
double availableMemory();
// DiskSpace
double totalDiskSpace();
double freeDiskSpace();
double usedDiskSpace();
// DiskSpace utils
NSString * gigabytesFromBytes(double bytes);
NSString * megabytesFromBytes(double bytes);


