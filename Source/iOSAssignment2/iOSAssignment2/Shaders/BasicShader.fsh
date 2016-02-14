//
//  Shader.fsh
//  iOSAssignment2
//
//  Created by ChristoferKlassen on 2016-02-10.
//  Copyright © 2016 Chris Klassen. All rights reserved.
//

varying lowp vec4 colorVarying;

varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;

void main()
{
    gl_FragColor = colorVarying * texture2D(Texture, TexCoordOut);
}
