// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bike.h instead.

#import <CoreData/CoreData.h>

extern const struct BikeAttributes {
	__unsafe_unretained NSString *comment;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *tag;
} BikeAttributes;

@interface BikeID : NSManagedObjectID {}
@end

@interface _Bike : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BikeID* objectID;

@property (nonatomic, strong) NSString* comment;

//- (BOOL)validateComment:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* tag;

//- (BOOL)validateTag:(id*)value_ error:(NSError**)error_;

@end

@interface _Bike (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveComment;
- (void)setPrimitiveComment:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveTag;
- (void)setPrimitiveTag:(NSString*)value;

@end
