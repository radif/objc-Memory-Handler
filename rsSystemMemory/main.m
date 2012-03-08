//
//  main.m
//  rsSystemMemory
//
//  Created by Radif Sharafullin on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "rsMemoryHandler.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Available RAM: %f", availableMemory());
        freeUnusedMemory();
        NSLog(@"Available RAM: %f",availableMemory());
        freeUnusedMemory();
        NSLog(@"Available RAM: %f",availableMemory());
        
        NSLog(@"Total Disk Capacity: %f",totalDiskSpace());
        NSLog(@"Free Disk Space: %f",freeDiskSpace());
        
    }
    return 0;
}

