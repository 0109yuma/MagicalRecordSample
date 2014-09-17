// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bike.m instead.

#import "_Bike.h"

const struct BikeAttributes BikeAttributes = {
	.comment = @"comment",
	.name = @"name",
	.tag = @"tag",
};

@implementation BikeID
@end

@implementation _Bike

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Bike" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Bike";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Bike" inManagedObjectContext:moc_];
}

- (BikeID*)objectID {
	return (BikeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic comment;

@dynamic name;

@dynamic tag;

@end

