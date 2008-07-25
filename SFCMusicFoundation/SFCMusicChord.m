//
//  MusicChord.m
//  MusicFoundation
//
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import "SFCMusicChord.h"

@interface SFCMusicChord(PrivateMethods)

- initWithFundamental:(SFCMusicNote *)n scale:(SFCMusicScale *)s;

@end

@implementation SFCMusicChord

+ (SFCMusicChord *)majorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    return [[[SFCMusicChord alloc] initMajorTriadForNote:n scale:s] autorelease];
}

+ (SFCMusicChord *)minorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    return [[[SFCMusicChord alloc] initMinorTriadForNote:n scale:s] autorelease];
}

+ (SFCMusicChord *)augmentedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    return [[[SFCMusicChord alloc] initAugmentedTriadForNote:n scale:s] autorelease];
}

+ (SFCMusicChord *)diminishedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    return [[[SFCMusicChord alloc] initDiminishedTriadForNote:n scale:s] autorelease];
}

+ (SFCMusicChord *)powerChordForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s octave:(BOOL)flag {
    return [[[SFCMusicChord alloc] initPowerChordForNote:n scale:s octave:flag] autorelease];
}

- initWithFundamental:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    [super init];
    fund = [n retain];
    scale = [s retain];
    notas = [[NSMutableArray alloc] initWithCapacity:4];
    [notas addObject:n];
    return self;
}

- initMajorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    [self initWithFundamental:n scale:s];
    if (scale) {
        //buscar la nota en la escala
        short ntrvl = [s intervalOfNote:n];
        if (ntrvl == 0) {
            //TODO excepcion
            [self autorelease];
            return nil;
        }
        n = [s noteAtInterval:3 fromInterval:ntrvl];
        [notas addObject:n];
        n = [s noteAtInterval:5 fromInterval:ntrvl];
        [notas addObject:n];
    } else {
        //calcular simplemente por intervalos
        n = [n transposedNote:4];
        [notas addObject:n];
        n = [n transposedNote:3];
        [notas addObject:n];
    }
    nombre = [[fund nameWithoutOctave] retain];
    return self;
}

- initMinorTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    [self initWithFundamental:n scale:s];
    if (scale) {
        //buscar la nota en la escala
    } else {
        //calcular simplemente por intervalos
        n = [n transposedNote:3];
        [notas addObject:n];
        n = [n transposedNote:4];
        [notas addObject:n];
    }
    nombre = [[NSString alloc] initWithFormat:@"%@m", [fund nameWithoutOctave]];
    return self;
}

- initAugmentedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    [self initWithFundamental:n scale:s];
    if (scale) {
        //buscar la nota en la escala
    } else {
        //calcular simplemente por intervalos
        n = [n transposedNote:4];
        [notas addObject:n];
        n = [n transposedNote:4];
        [notas addObject:n];
    }
    nombre = [[NSString alloc] initWithFormat:@"%@+", [fund nameWithoutOctave]];
    return self;
}

- initDiminishedTriadForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s {
    [self initWithFundamental:n scale:s];
    if (scale) {
        //buscar la nota en la escala
    } else {
        //calcular simplemente por intervalos
        n = [n transposedNote:3];
        [notas addObject:n];
        n = [n transposedNote:3];
        [notas addObject:n];
    }
    nombre = [[NSString alloc] initWithFormat:@"%@ dim", [fund nameWithoutOctave]];
    return self;
}

- initPowerChordForNote:(SFCMusicNote *)n scale:(SFCMusicScale *)s octave:(BOOL)flag {
    [self initWithFundamental:n scale:s];
    if (scale) {
        //buscar la nota en la escala
        unsigned short ntrvl = [s intervalOfNote:n];
        if (ntrvl == 0) {
            //TODO excepcion
            [self autorelease];
            return nil;
        }
        n = [s noteAtInterval:5 fromInterval:ntrvl];
        [notas addObject:n];
        if (flag) {
            n = [fund nextOctave];
        }
    } else {
        n = [n transposedNote:7];
        [notas addObject:n];
        if (flag) {
            n = [n transposedNote:5];
            [notas addObject:n];
        }
    }
    nombre = [[NSString alloc] initWithFormat:@"%@5", [fund nameWithoutOctave]];
    return self;
}

- (NSArray *)notes {
    return [[notas copy] autorelease];
}

- (NSString *)name {
    return nombre;
}

- (SFCMusicNote *)fundamental {
    return fund;
}

- (SFCMusicScale *)scale {
    return scale;
}

- (void)invertUp {
    SFCMusicNote *n = [notas objectAtIndex:0];
    [notas removeObjectAtIndex:0];
    [n transpose:12];
    [notas addObject:n];
}

- (void)invertDown {
    SFCMusicNote *n = [notas lastObject];
    [notas removeLastObject];
    [n transpose:-12];
    [notas insertObject:n atIndex:0];
}

- (NSString *)description {
    return [self name];
}

- (void)dealloc {
    [fund release];
    [scale release];
    [notas release];
    [nombre release];
    [super dealloc];
}

@end
