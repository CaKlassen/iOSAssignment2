//
//  BasicProgram.m
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-12.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicProgram.h"

@interface BasicProgram ()
{
	enum
	{
		UNIFORM_VIEWPROJECTION_MATRIX,
		UNIFORM_WORLD_MATRIX,
		UNIFORM_NORMAL_MATRIX,
		UNIFORM_EYE_DIRECTION,
		NUM_UNIFORMS
	};
	
	GLint uniforms[NUM_UNIFORMS];
}

@end


@implementation BasicProgram

-(id)init
{
	// Create the shaders
	self = [super initWithShaders:@"BasicShader" fragmentShader:@"BasicShader"];
	
	// Retrieve the uniform locations
	[self retrieveUniforms];
	
	return self;
}


-(void)retrieveUniforms
{
	uniforms[UNIFORM_VIEWPROJECTION_MATRIX] = glGetUniformLocation(program, "ViewProj");
	uniforms[UNIFORM_WORLD_MATRIX] = glGetUniformLocation(program, "World");
	uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(program, "normalMatrix");
	uniforms[UNIFORM_EYE_DIRECTION] = glGetUniformLocation(program, "EyeDirection");
}


-(void)useProgram:(GLuint)vertexArray
{
	glUseProgram(program);
	
	glBindVertexArrayOES(vertexArray);
	
	GLKMatrix4 viewProj;
	GLKMatrix4 world;
	GLKMatrix3 normalMatrix;
	GLKVector3 eyePos;
	
	[[[self uniforms] objectForKey:@"ViewProj"] getBytes:&viewProj length:sizeof(GLKMatrix4)];
	[[[self uniforms] objectForKey:@"World"] getBytes:&world length:sizeof(GLKMatrix4)];
	[[[self uniforms] objectForKey:@"normalMatrix"] getBytes:&normalMatrix length:sizeof(GLKMatrix3)];
	[[[self uniforms] objectForKey:@"EyeDirection"] getBytes:&eyePos length:sizeof(GLKVector3)];
	
	glUniformMatrix4fv(uniforms[UNIFORM_VIEWPROJECTION_MATRIX], 1, 0, viewProj.m);
	glUniformMatrix4fv(uniforms[UNIFORM_WORLD_MATRIX], 1, 0, world.m);
	glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, normalMatrix.m);
	glUniform3fv(uniforms[UNIFORM_EYE_DIRECTION], 1, eyePos.v);
}


@end