//
//  rsMemoryHandler.m
//  rsSystemMemory
//
//  Created by Radif Sharafullin on 3/7/12.
//  Copyright (c) 2012 Radif Sharafullin. All rights reserved.
//
// Released under MIT License

#import "rsMemoryHandler.h"
#import <mach/mach_host.h>

#pragma mark memory
natural_t getFreeMemory(){
	mach_port_t host_port;
	mach_msg_type_number_t host_size;
	vm_size_t pagesize;
	host_port = mach_host_self();
	host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
	host_page_size(host_port, &pagesize);
	vm_statistics_data_t vm_stat;
	if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
		printf("Failed to fetch vm statistics\n %s",__FUNCTION__);
		return 0;
	}
	/* Stats in bytes */
	natural_t mem_free = vm_stat.free_count * pagesize;
	return mem_free;
}
void freeMemory(natural_t freemem){
	size_t size = freemem - 2048;
	void *allocation = malloc(freemem - 2048);
	bzero(allocation, size);
	free(allocation);
}
natural_t freeUnusedMemory(){
    natural_t freemem = getFreeMemory();
    freeMemory(freemem);
	freemem=freemem- getFreeMemory();
	return freemem;
}
double availableMemory(){
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
	
	if(kernReturn != KERN_SUCCESS) {
		return NSNotFound;
	}
	
	return ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
}
#pragma mark DiskSpace
NSString * gigabytesFromBytes(double bytes){
	double kilobytes = bytes/1024.0;
	double megabytes = kilobytes/1024.0;
	double gigabytes = megabytes/1024.0;
	return [NSString stringWithFormat:@"%.2f",gigabytes];
}
NSString * megabytesFromBytes(double bytes){
	double kilobytes = bytes/1024.0;
	double megabytes = kilobytes/1024.0;
	return [NSString stringWithFormat:@"%.2f",megabytes];
}

double totalDiskSpace(){  
    double bytes = 0.0f;  
    NSError *error = nil;
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:docPath error: &error];  
    
    if (dictionary) {  
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];  
        bytes = [fileSystemSizeInBytes doubleValue];  
    } else {  
        NSLog(@"Error Obtaining File System Info: Domain = %@, Code = %@", [error domain], [error code]);  
        return NSNotFound;
    }  
	
    return bytes;
}
double freeDiskSpace() {  
	double bytes = 0.0f;  
    NSError *error = nil;  
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:docPath error: &error];  
	
    if (dictionary) {  
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];  
        bytes = [fileSystemSizeInBytes doubleValue];  
    } else {  
        printf("Error Obtaining File System Info: Domain = %s, Code = %ld", [[error domain] cStringUsingEncoding:NSUTF8StringEncoding], [error code]);  
        return NSNotFound;
    }  
    
    return bytes;
}
double usedDiskSpace(){  
	double bytes = (totalDiskSpace())-(freeDiskSpace());
    return bytes;
}



